#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
gerar_wiki.py — gera o wiki HTML autocontido (index.html) a partir das notas
atomicas em notas/**/*.md (formato: frontmatter YAML + corpo em markdown).

Layout editorial com mapa de relacoes em grafo (posicionado via simulacao de
forcas calculada em JS no carregamento da pagina), navegacao por dominio,
busca e paginas de nota com fontes/relacionadas clicaveis.

Uso:
    python gerar_wiki.py [--notas-dir CAMINHO] [--saida CAMINHO]

Padroes:
    --notas-dir  ../notas   (pasta 'notas' irma da pasta 'wiki')
    --saida      index.html (gravado dentro da pasta deste script)

Sem dependencias externas (nao usa PyYAML) — o parser de frontmatter foi
escrito especificamente para o esquema usado nas notas desta base:

    ---
    id: nota-0001
    titulo: "..."
    dominio: metricas-de-potencia
    camada: [diario, semanal]
    aplicacao: direta
    tipo_nota: regra-interpretacao
    sinais: [TSS, IF]
    fontes:
      - arquivo: "..."
        pagina: 123
        trecho: "..."
    relacionadas:
      - id: nota-0007
        tipo: pre-requisito
        justificativa: "..."
    confianca: 0.9
    status: auto-aprovado
    ---

    Corpo em markdown simples (paragrafos, **negrito**, tabelas, listas,
    terminando opcionalmente em "Aplicação ao feedback: ...").
"""

import argparse
import json
import re
import sys
from pathlib import Path

DOMINIO_LABELS = {
    "fisiologia": "Fisiologia",
    "limiares-e-lactato": "Limiares e lactato",
    "metricas-de-potencia": "Métricas de potência",
    "metodologia-e-periodizacao": "Metodologia e periodização",
    "tipos-de-treino": "Tipos de treino",
    "avaliacao-e-testes": "Avaliação e testes",
    "nutricao-e-energia": "Nutrição e energia",
    "recuperacao-e-fadiga": "Recuperação e fadiga",
    "contexto-atleta": "Contexto do atleta",
    "templates-feedback": "Templates de feedback",
}
DOMINIO_ORDER = list(DOMINIO_LABELS.keys())
DOMINIO_COLOR_VAR = {
    "fisiologia": "var(--d-fisiologia)",
    "limiares-e-lactato": "var(--d-limiares)",
    "metricas-de-potencia": "var(--d-metricas)",
    "metodologia-e-periodizacao": "var(--d-metodologia)",
    "tipos-de-treino": "var(--d-tipos)",
    "avaliacao-e-testes": "var(--d-avaliacao)",
    "nutricao-e-energia": "var(--d-nutricao)",
    "recuperacao-e-fadiga": "var(--d-recuperacao)",
    "contexto-atleta": "var(--d-contexto)",
    "templates-feedback": "var(--d-templates)",
}


# --------------------------------------------------------------------------
# Parser de frontmatter (YAML restrito ao esquema usado nas notas)
# --------------------------------------------------------------------------

def strip_quotes(s):
    s = s.strip()
    if len(s) >= 2 and ((s[0] == '"' and s[-1] == '"') or (s[0] == "'" and s[-1] == "'")):
        return s[1:-1]
    return s


def parse_inline_list(s):
    """Faz parse de listas inline, ex.: [TSS, IF] ou ["FC (média/máx)", cadência]."""
    s = s.strip()
    if not (s.startswith("[") and s.endswith("]")):
        return [s] if s else []
    inner = s[1:-1].strip()
    if not inner:
        return []
    items = []
    current = ""
    in_quotes = False
    quote_char = ""
    depth = 0
    for ch in inner:
        if in_quotes:
            current += ch
            if ch == quote_char:
                in_quotes = False
        elif ch in ('"', "'"):
            in_quotes = True
            quote_char = ch
            current += ch
        elif ch == "(":
            depth += 1
            current += ch
        elif ch == ")":
            depth -= 1
            current += ch
        elif ch == "," and depth == 0:
            items.append(current.strip())
            current = ""
        else:
            current += ch
    if current.strip():
        items.append(current.strip())
    return [strip_quotes(it) for it in items]


def parse_list_item(item_lines):
    """Faz parse de um item de lista em bloco (fontes / relacionadas)."""
    d = {}
    first = item_lines[0]
    dash_idx = first.find("- ")
    content = first[dash_idx + 2:]
    if ":" in content:
        key, _, val = content.partition(":")
        d[key.strip()] = strip_quotes(val.strip())
    for line in item_lines[1:]:
        stripped = line.strip()
        if ":" in stripped:
            k, _, v = stripped.partition(":")
            d[k.strip()] = strip_quotes(v.strip())
    return d


def parse_frontmatter(text):
    lines = text.split("\n")
    data = {}
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        if not line.strip():
            i += 1
            continue
        indent = len(line) - len(line.lstrip(" "))
        stripped = line.strip()
        if indent == 0 and ":" in stripped:
            key, _, rest = stripped.partition(":")
            key = key.strip()
            rest = rest.strip()
            if rest == "":
                if i + 1 < n and lines[i + 1].lstrip().startswith("- "):
                    items = []
                    i += 1
                    while i < n and lines[i].strip().startswith("- "):
                        item_indent = len(lines[i]) - len(lines[i].lstrip(" "))
                        item_lines = [lines[i]]
                        i += 1
                        while i < n and lines[i].strip() and (
                            len(lines[i]) - len(lines[i].lstrip(" "))
                        ) > item_indent:
                            item_lines.append(lines[i])
                            i += 1
                        items.append(parse_list_item(item_lines))
                    data[key] = items
                    continue
                else:
                    data[key] = None
                    i += 1
                    continue
            elif rest.startswith("["):
                data[key] = parse_inline_list(rest)
                i += 1
                continue
            else:
                data[key] = strip_quotes(rest)
                i += 1
                continue
        else:
            i += 1
    return data


def parse_note_file(path: Path):
    text = path.read_text(encoding="utf-8")
    parts = text.split("---", 2)
    if len(parts) < 3:
        print(f"[aviso] {path} nao tem frontmatter valido (---...---), ignorada.", file=sys.stderr)
        return None
    frontmatter_text = parts[1]
    body = parts[2].strip()
    data = parse_frontmatter(frontmatter_text)
    data["body"] = body

    data.setdefault("id", path.stem.split("-")[0] + "-" + path.stem.split("-")[1] if "-" in path.stem else path.stem)
    data.setdefault("titulo", data.get("id", path.stem))
    data.setdefault("dominio", "")
    data.setdefault("camada", [])
    data.setdefault("aplicacao", "")
    data.setdefault("tipo_nota", "")
    data.setdefault("sinais", [])
    data.setdefault("fontes", [])
    data.setdefault("relacionadas", [])
    data.setdefault("status", "")
    try:
        data["confianca"] = float(data.get("confianca") or 0)
    except (TypeError, ValueError):
        data["confianca"] = None

    if not isinstance(data["camada"], list):
        data["camada"] = [data["camada"]] if data["camada"] else []
    if not isinstance(data["sinais"], list):
        data["sinais"] = [data["sinais"]] if data["sinais"] else []
    if not isinstance(data["fontes"], list):
        data["fontes"] = []
    if not isinstance(data["relacionadas"], list):
        data["relacionadas"] = []

    data["arquivo_origem"] = str(path.as_posix())
    return data


def coletar_notas(notas_dir: Path):
    notas = []
    for md_path in sorted(notas_dir.rglob("*.md")):
        parsed = parse_note_file(md_path)
        if parsed:
            notas.append(parsed)
    return notas


# --------------------------------------------------------------------------
# Parser dos arquivos de revisao (_revisao/baixa-confianca, conflitos,
# modelos-concorrentes) — formato livre em markdown, nao segue o esquema
# de frontmatter das notas atomicas. Dois estilos observados:
#
#   Estilo A (frontmatter curto):
#     ---
#     titulo: "..." | nota: nota-XXXX
#     notas_envolvidas: [nota-0001, nota-0002] | confianca: 0.NN
#     status: revisar
#     ---
#     corpo em markdown...
#
#   Estilo B (markdown puro, sem frontmatter):
#     # Titulo do arquivo (H1)
#     **Campo:** valor
#     **Notas envolvidas:** nota-0001, nota-0002 (...)
#     resto do corpo...
# --------------------------------------------------------------------------

ID_PATTERN = re.compile(r"nota-\d{4}")
CONF_PATTERN = re.compile(r"confian[cç]a\s+([0-9]*\.?[0-9]+)", re.IGNORECASE)


def parse_revisao_file(path: Path, tipo: str):
    text = path.read_text(encoding="utf-8")
    notas_ids = []
    confianca = None
    titulo = None
    body = text.strip()

    if text.lstrip().startswith("---"):
        parts = text.split("---", 2)
        if len(parts) >= 3:
            fm = parse_frontmatter(parts[1])
            body = parts[2].strip()
            titulo = fm.get("titulo")
            if fm.get("notas_envolvidas"):
                notas_ids = list(fm["notas_envolvidas"])
            elif fm.get("nota"):
                notas_ids = [fm["nota"]]
            if fm.get("confianca") not in (None, ""):
                try:
                    confianca = float(fm["confianca"])
                except (TypeError, ValueError):
                    confianca = None
            if not titulo and fm.get("motivo"):
                body = fm["motivo"]
    else:
        lines = text.strip().split("\n")
        if lines and lines[0].startswith("#"):
            titulo = lines[0].lstrip("#").strip()
            body = "\n".join(lines[1:]).strip()
        m = CONF_PATTERN.search(text)
        if m:
            try:
                confianca = float(m.group(1))
            except ValueError:
                confianca = None
        env_match = re.search(r"\*\*Notas envolvidas:?\*\*\s*(.+)", text)
        if env_match:
            notas_ids = ID_PATTERN.findall(env_match.group(1))
        motivo_match = re.search(r"\*\*Motivo:?\*\*\s*(.+)", text, re.DOTALL)
        if motivo_match:
            body = motivo_match.group(1).strip()

    if not notas_ids:
        notas_ids = sorted(set(ID_PATTERN.findall(text)))
    if not titulo:
        titulo = path.stem

    return {
        "tipo": tipo,
        "titulo": titulo,
        "notas": notas_ids,
        "body": body,
        "confianca": confianca,
    }


def coletar_revisoes(revisao_dir: Path):
    if not revisao_dir.exists():
        return []
    tipo_map = {
        "baixa-confianca": "baixa-confianca",
        "conflitos": "conflito",
        "modelos-concorrentes": "modelo-concorrente",
    }
    revisoes = []
    for subdir, tipo in tipo_map.items():
        pasta = revisao_dir / subdir
        if not pasta.exists():
            continue
        for md_path in sorted(pasta.glob("*.md")):
            revisoes.append(parse_revisao_file(md_path, tipo))
    return revisoes


# --------------------------------------------------------------------------
# Geracao do HTML
# --------------------------------------------------------------------------

def build_html(notas, revisoes=None, titulo_wiki="Base de Conhecimento — Ciclismo"):
    if revisoes is None:
        revisoes = []
    notas_json = json.dumps(notas, ensure_ascii=False)
    doms_json = json.dumps(
        {k: {"nm": v, "c": DOMINIO_COLOR_VAR[k]} for k, v in DOMINIO_LABELS.items()},
        ensure_ascii=False,
    )
    dom_order_json = json.dumps(DOMINIO_ORDER, ensure_ascii=False)
    revisoes_json = json.dumps(revisoes, ensure_ascii=False)
    html = HTML_TEMPLATE.replace("__TITULO__", titulo_wiki)
    html = html.replace("__NOTAS_JSON__", notas_json)
    html = html.replace("__DOMS_JSON__", doms_json)
    html = html.replace("__DOM_ORDER_JSON__", dom_order_json)
    html = html.replace("__REVISOES_JSON__", revisoes_json)
    return html


HTML_TEMPLATE = r"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>__TITULO__</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
  :root{
    --paper:#F3F3EF; --card:#FFFFFF; --ink:#17191E; --muted:#6A6E77;
    --line:#E4E3DD; --line-strong:#D3D2CA; --signal:#D8452F;
    --d-fisiologia:#6E8F3F; --d-limiares:#3F9E96; --d-metricas:#3E6B8C;
    --d-metodologia:#8A6DB0; --d-tipos:#C46A2B; --d-avaliacao:#55809E;
    --d-nutricao:#B08A2E; --d-recuperacao:#C24D57; --d-contexto:#7A7E86;
    --d-templates:#A6ACB4;
    --r:14px;
    --serif: "Space Grotesk", system-ui, sans-serif;
    --sans: "Inter", system-ui, -apple-system, sans-serif;
    --mono: "Space Mono", ui-monospace, monospace;
  }
  *{box-sizing:border-box}
  html,body{margin:0;padding:0}
  body{background:var(--paper);color:var(--ink);font-family:var(--sans);
    font-size:15px;line-height:1.55;-webkit-font-smoothing:antialiased}
  a{color:inherit}
  .app{display:grid;grid-template-columns:280px 1fr;min-height:100vh}
  .rail{background:var(--card);border-right:1px solid var(--line);
    padding:26px 22px;display:flex;flex-direction:column;gap:22px;position:sticky;top:0;height:100vh;overflow-y:auto}
  .brand{font-family:var(--serif);font-weight:700;font-size:19px;letter-spacing:-.02em;line-height:1.15}
  .brand .k{display:block;font-family:var(--mono);font-size:10.5px;font-weight:400;
    letter-spacing:.16em;text-transform:uppercase;color:var(--signal);margin-bottom:7px}
  .search{width:100%;border:1px solid var(--line-strong);background:var(--paper);
    border-radius:10px;padding:9px 11px;font-family:var(--sans);font-size:13.5px;color:var(--ink)}
  .search:focus{outline:2px solid var(--ink);outline-offset:1px}
  .navlink{display:block;width:100%;text-align:left;border:0;background:none;cursor:pointer;
    font-family:var(--serif);font-weight:600;font-size:14px;color:var(--ink);padding:7px 8px;border-radius:8px}
  .navlink:hover{background:var(--paper)}
  .navlink.active{background:var(--ink);color:#fff}
  .lbl{font-family:var(--mono);font-size:10px;letter-spacing:.15em;text-transform:uppercase;
    color:var(--muted);margin:2px 0 4px}
  .doms{display:flex;flex-direction:column;gap:1px}
  .dom{display:flex;align-items:center;gap:9px;border:0;background:none;cursor:pointer;
    text-align:left;padding:6px 8px;border-radius:8px;font-size:13px;color:var(--ink);width:100%}
  .dom:hover{background:var(--paper)}
  .dom .dot{width:10px;height:10px;border-radius:3px;flex:none}
  .dom .nm{flex:1;min-width:0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
  .dom .ct{font-family:var(--mono);font-size:11px;color:var(--muted)}
  .dom[data-empty="1"]{opacity:.42}
  .foot{margin-top:auto;font-size:11.5px;color:var(--muted);line-height:1.5;border-top:1px solid var(--line);padding-top:16px}
  .main{padding:0}
  .wrap{padding:34px 40px 70px;max-width:1080px}
  .h-eyebrow{font-family:var(--mono);font-size:11px;letter-spacing:.16em;text-transform:uppercase;color:var(--signal)}
  h1{font-family:var(--serif);font-weight:700;font-size:34px;letter-spacing:-.025em;line-height:1.08;margin:10px 0 12px}
  .lede{font-size:16px;color:#33363D;max-width:64ch;margin:0 0 6px}
  .hint{font-size:13.5px;color:var(--muted);max-width:64ch}
  .graphcard{margin-top:26px;background:var(--card);border:1px solid var(--line);border-radius:var(--r);overflow:hidden}
  .graphhead{display:flex;justify-content:space-between;align-items:center;gap:14px;
    padding:14px 18px;border-bottom:1px solid var(--line);flex-wrap:wrap}
  .graphhead .t{font-family:var(--serif);font-weight:600;font-size:15px}
  .legend{display:flex;gap:16px;flex-wrap:wrap;font-size:11.5px;color:var(--muted);align-items:center}
  .legend span{display:inline-flex;align-items:center;gap:6px}
  .lg-line{width:22px;height:0;border-top:2px solid var(--line-strong)}
  .lg-line.pre{border-top-style:solid;border-color:#9A9E29A6}
  .lg-line.cau{border-top:2px solid var(--signal)}
  .lg-line.com{border-top:2px dashed var(--line-strong)}
  .lg-line.con{border-top:2px solid #B23A55}
  .lg-line.alt{border-top:2px dotted #8A6DB0}
  .graphwrap{position:relative;background:
    radial-gradient(circle at 1px 1px, #E7E6E0 1px, transparent 0) 0 0/22px 22px}
  svg.graph{display:block;width:100%;height:640px;cursor:grab}
  svg.graph.panning{cursor:grabbing}
  .edge{stroke:#B9BDB0;stroke-width:1.2;fill:none;transition:stroke-opacity .2s}
  .edge.cau{stroke:var(--signal)}
  .edge.com{stroke-dasharray:5 5}
  .edge.con{stroke:#B23A55;stroke-width:1.6}
  .edge.alt{stroke:#8A6DB0;stroke-dasharray:2 4}
  .gnode{cursor:pointer}
  .gnode circle{transition:transform .15s;transform-origin:center}
  .gnode:hover circle,.gnode:focus circle{stroke:var(--ink);stroke-width:2.4px}
  .gnode text.tag{font-family:var(--mono);font-size:8.5px;fill:#fff;font-weight:700;text-anchor:middle;pointer-events:none}
  .dim .edge{stroke-opacity:.08}
  .dim .gnode{opacity:.2}
  .gnode.hot,.gnode.nb{opacity:1}
  .edge.hot{stroke-opacity:1;stroke-width:2.2}
  .graphctl{position:absolute;right:14px;bottom:14px;display:flex;gap:6px}
  .gbtn{width:28px;height:28px;border-radius:8px;border:1px solid var(--line-strong);background:var(--card);
    cursor:pointer;font-family:var(--mono);font-size:14px;color:var(--ink)}
  .gbtn:hover{background:var(--paper)}
  .back{border:0;background:none;cursor:pointer;font-family:var(--mono);font-size:11.5px;
    letter-spacing:.06em;color:var(--muted);padding:0;margin-bottom:18px;display:inline-flex;gap:7px;align-items:center}
  .back:hover{color:var(--ink)}
  .badges{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:14px;align-items:center}
  .tag-id{font-family:var(--mono);font-size:12px;color:var(--muted)}
  .chip{font-size:11px;font-weight:600;padding:3px 9px;border-radius:20px;color:#fff;letter-spacing:.01em}
  .chip.line{background:none;border:1px solid var(--line-strong);color:var(--muted);font-weight:500}
  .chip.type{background:#25272E}
  h2.note{font-family:var(--serif);font-weight:700;font-size:25px;letter-spacing:-.02em;line-height:1.18;margin:0 0 18px;max-width:44ch}
  .body{font-size:15.5px;color:#26282E;max-width:66ch}
  .body p{margin:0 0 14px}
  .body ul{margin:0 0 14px;padding-left:22px}
  .body li{margin-bottom:6px}
  .body table{border-collapse:collapse;margin:6px 0 16px;font-size:14px;width:100%;max-width:620px}
  .body th,.body td{border:1px solid var(--line-strong);padding:7px 11px;text-align:left}
  .body th{background:var(--paper);font-weight:600;font-family:var(--serif)}
  .apply{background:#F6F4EC;border-left:3px solid var(--d-tipos);border-radius:0 8px 8px 0;
    padding:12px 16px;margin:18px 0;font-size:14.5px;max-width:66ch}
  .apply .k{font-family:var(--mono);font-size:10px;letter-spacing:.12em;text-transform:uppercase;color:#9a7b2e;display:block;margin-bottom:4px}
  .cols{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-top:26px}
  @media(max-width:820px){.cols{grid-template-columns:1fr}}
  .panel{background:var(--card);border:1px solid var(--line);border-radius:12px;padding:16px 18px}
  .panel h3{font-family:var(--mono);font-size:10.5px;letter-spacing:.13em;text-transform:uppercase;
    color:var(--muted);margin:0 0 12px;font-weight:400}
  .src{font-size:13.5px;margin-bottom:14px}
  .src .bk{font-weight:600;font-family:var(--serif)}
  .src .pg{font-family:var(--mono);color:var(--muted);font-size:12px}
  .src .q{margin-top:8px;padding-left:11px;border-left:2px solid var(--line-strong);
    color:var(--muted);font-style:italic;font-size:13px}
  .rel{display:flex;flex-direction:column;gap:8px}
  .relitem{border:0;background:none;text-align:left;cursor:pointer;padding:8px 10px;border-radius:9px;
    display:flex;flex-direction:column;gap:3px;width:100%}
  .relitem:hover{background:var(--paper)}
  .relitem .rrow{display:flex;gap:10px;align-items:baseline}
  .relitem .rt{font-family:var(--mono);font-size:9.5px;letter-spacing:.06em;text-transform:uppercase;
    padding:2px 6px;border-radius:5px;background:var(--paper);color:var(--muted);flex:none;border:1px solid var(--line)}
  .relitem .rt.causal{color:var(--signal);border-color:#e7b8b0}
  .relitem .rt.contradiz{color:#B23A55;border-color:#e7b0bd}
  .relitem .rt.alternativa-a{color:#8A6DB0;border-color:#d6c9ea}
  .relitem .rx{font-size:13.5px}
  .relitem .rx b{font-family:var(--mono);font-size:11px;color:var(--muted);font-weight:400;margin-right:6px}
  .relitem .rj{font-size:12px;color:var(--muted);font-style:italic;padding-left:2px}
  .sinais{display:flex;gap:6px;flex-wrap:wrap;margin-top:4px}
  .sig{font-family:var(--mono);font-size:10.5px;background:var(--paper);border:1px solid var(--line);
    padding:3px 7px;border-radius:6px;color:#4a4d54}
  .listhead{font-family:var(--serif);font-weight:700;font-size:22px;letter-spacing:-.02em;margin:2px 0 4px;display:flex;align-items:center;gap:11px}
  .listhead .dot{width:13px;height:13px;border-radius:4px}
  .listsub{color:var(--muted);font-size:13.5px;margin-bottom:20px}
  .cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:14px}
  .ncard{text-align:left;border:1px solid var(--line);background:var(--card);border-radius:12px;
    padding:15px 16px;cursor:pointer;display:flex;flex-direction:column;gap:9px}
  .ncard:hover{border-color:var(--line-strong);box-shadow:0 3px 14px rgba(20,20,20,.05)}
  .ncard .top{display:flex;justify-content:space-between;align-items:center;gap:8px}
  .ncard .cid{font-family:var(--mono);font-size:11px;color:var(--muted)}
  .ncard .tt{font-family:var(--serif);font-weight:600;font-size:14.5px;line-height:1.25}
  .ncard .mt{display:flex;gap:7px;align-items:center;margin-top:auto}
  .ncard .mini{font-size:10px;font-weight:600;padding:2px 7px;border-radius:20px;color:#fff}
  .ncard .miniline{font-size:10.5px;color:var(--muted);font-family:var(--mono)}
  .empty{color:var(--muted);font-size:14px;padding:30px 0}
  .revsection{margin-top:30px}
  .revhead{display:flex;align-items:center;gap:10px;font-family:var(--serif);font-weight:700;font-size:19px;letter-spacing:-.01em}
  .revdot{width:11px;height:11px;border-radius:50%;flex:none}
  .revdot.baixa-confianca{background:#C9A227}
  .revdot.conflito{background:#B23A55}
  .revdot.modelo-concorrente{background:#8A6DB0}
  .revcount{font-family:var(--mono);font-size:12px;color:var(--muted);font-weight:400;background:var(--paper);border:1px solid var(--line);border-radius:20px;padding:2px 9px}
  .revlist{display:flex;flex-direction:column;gap:12px;margin-top:14px}
  .revcard{background:var(--card);border:1px solid var(--line);border-radius:12px;padding:16px 18px}
  .revtop{display:flex;justify-content:space-between;align-items:center;gap:10px;flex-wrap:wrap;margin-bottom:8px}
  .revnotas{display:flex;gap:6px;flex-wrap:wrap}
  .relitem-mini{font-family:var(--mono);font-size:11px;border:1px solid var(--line-strong);background:var(--paper);
    color:var(--ink);border-radius:20px;padding:2px 9px;cursor:pointer}
  .relitem-mini:hover{background:var(--ink);color:#fff;border-color:var(--ink)}
  .revtitle{font-family:var(--serif);font-weight:600;font-size:15.5px;line-height:1.3;margin-bottom:8px}
  .revbody{font-size:14px;color:#33363D}
  .revbody p{margin:0 0 10px}
  .revflag{display:flex;align-items:center;gap:10px;flex-wrap:wrap;background:#FBF3DD;border:1px solid #E8D9A6;
    border-radius:10px;padding:10px 14px;margin:0 0 16px;font-size:13.5px;color:#6b5511}
  .revflag button{font-family:var(--mono);font-size:11.5px;border:0;background:none;cursor:pointer;color:#6b5511;text-decoration:underline;padding:0}
  @media(max-width:720px){.app{grid-template-columns:1fr}.rail{position:static;height:auto;border-right:0;border-bottom:1px solid var(--line)}.wrap{padding:26px 20px 60px}}
  @media(prefers-reduced-motion:reduce){*{transition:none!important}}
</style>
</head>
<body>
<div class="app">
  <aside class="rail">
    <div class="brand"><span class="k">Base de conhecimento</span>Ciclismo — feedback de treino</div>
    <input class="search" id="search" placeholder="Buscar nota, conceito, métrica…" autocomplete="off">
    <div>
      <button class="navlink active" id="nav-map" onclick="go({v:'home'})">Mapa de relações</button>
      <button class="navlink" id="nav-revisao" onclick="go({v:'revisao'})">Revisão pendente</button>
    </div>
    <div>
      <div class="lbl">Domínios</div>
      <div class="doms" id="doms"></div>
    </div>
    <div class="foot" id="foot"></div>
  </aside>
  <main class="main">
    <div class="wrap" id="view"></div>
  </main>
</div>

<script id="notas-data" type="application/json">__NOTAS_JSON__</script>
<script id="doms-data" type="application/json">__DOMS_JSON__</script>
<script id="dom-order-data" type="application/json">__DOM_ORDER_JSON__</script>
<script id="revisoes-data" type="application/json">__REVISOES_JSON__</script>

<script>
const NOTES = JSON.parse(document.getElementById('notas-data').textContent);
const DOMS = JSON.parse(document.getElementById('doms-data').textContent);
const DOM_ORDER = JSON.parse(document.getElementById('dom-order-data').textContent);
const REVISOES = JSON.parse(document.getElementById('revisoes-data').textContent);
const REV_LABELS = {'baixa-confianca':'Baixa confiança','conflito':'Conflito','modelo-concorrente':'Modelo concorrente'};

NOTES.forEach(n => { n.rel = n.relacionadas || []; n.tipo = n.tipo_nota; n.dom = n.dominio; n.conf = n.confianca; });

const EDGES = [];
NOTES.forEach(n => (n.rel||[]).forEach(r => EDGES.push({from:n.id, to:r.id, tipo:r.tipo, just:r.justificativa})));
const byId = Object.fromEntries(NOTES.map(n=>[n.id,n]));
function incoming(id){ return EDGES.filter(e=>e.to===id).map(e=>({from:e.from,tipo:e.tipo,just:e.just})); }

const TIPO = {
  "regra-interpretacao":"Regra de interpretação",
  "conceito":"Conceito","protocolo":"Protocolo","referencia":"Referência"
};

function domColor(d){ return DOMS[d]?DOMS[d].c:'#999'; }
function shortDom(d){ return DOMS[d]?DOMS[d].nm:d; }
function escapeHtml(s){ if(s===null||s===undefined) return ''; return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
function inlineMd(s){ s=escapeHtml(s); s=s.replace(/\*\*(.+?)\*\*/g,'<strong>$1</strong>'); s=s.replace(/`([^`]+)`/g,'<code>$1</code>'); return s; }
function renderTable(lines){
  const rows = lines.filter(l=>!/^\|[\s\-:|]+\|$/.test(l));
  if(!rows.length) return '';
  let html='<table>';
  rows.forEach((row,idx)=>{
    const cells = row.split('|').slice(1,-1).map(c=>c.trim());
    const tag = idx===0?'th':'td';
    html += '<tr>'+cells.map(c=>`<${tag}>${inlineMd(c)}</${tag}>`).join('')+'</tr>';
  });
  return html+'</table>';
}
function mdToHtml(md){
  if(!md) return '';
  const lines = md.split('\n'); let html='', i=0, para=[], items=[];
  function flushP(){ if(para.length){ html+='<p>'+inlineMd(para.join(' '))+'</p>'; para=[]; } }
  function flushL(){ if(items.length){ html+='<ul>'+items.map(li=>'<li>'+inlineMd(li)+'</li>').join('')+'</ul>'; items=[]; } }
  while(i<lines.length){
    const line=lines[i], t=line.trim();
    if(t===''){ flushP(); flushL(); i++; continue; }
    if(t.startsWith('|')){ flushP(); flushL(); const tl=[]; while(i<lines.length && lines[i].trim().startsWith('|')){ tl.push(lines[i].trim()); i++; } html+=renderTable(tl); continue; }
    if(t.startsWith('- ')||t.startsWith('* ')){ flushP(); items.push(t.slice(2)); i++; continue; }
    if(/^\d+\.\s/.test(t)){ flushP(); items.push(t.replace(/^\d+\.\s/,'')); i++; continue; }
    para.push(t); i++;
  }
  flushP(); flushL(); return html;
}
function splitBody(body){
  const marker = 'Aplicação ao feedback:';
  const idx = (body||'').indexOf(marker);
  if(idx===-1) return {main:body, apply:null};
  let main = body.slice(0, idx).trim();
  let apply = body.slice(idx+marker.length).trim();
  return {main, apply};
}

/* ---------------- LAYOUT DE FORCA (calculado uma vez, no carregamento) ---------------- */
let POS = {};
function computeLayout(){
  const nodes = NOTES;
  const n = nodes.length;
  const idx = {}; nodes.forEach((nd,i)=>idx[nd.id]=i);
  const domList = DOM_ORDER.filter(d => nodes.some(nd=>nd.dom===d));
  const domAngle = {}; domList.forEach((d,i)=> domAngle[d] = (i/domList.length)*2*Math.PI);
  const W=1800, H=1300, R=520;
  const pos = nodes.map(nd=>{
    const a = domAngle[nd.dom] || 0;
    const cx = W/2 + Math.cos(a)*R, cy = H/2 + Math.sin(a)*R;
    return {x: cx + (Math.random()-0.5)*180, y: cy + (Math.random()-0.5)*180};
  });
  const vel = nodes.map(()=>({x:0,y:0}));
  const edgeIdx = EDGES.map(e=>({a:idx[e.from], b:idx[e.to]})).filter(e=>e.a!==undefined && e.b!==undefined);
  const iterations = 200, k = 46;
  for(let it=0; it<iterations; it++){
    for(let i=0;i<n;i++){
      let fx=0, fy=0;
      for(let j=0;j<n;j++){
        if(i===j) continue;
        let dx=pos[i].x-pos[j].x, dy=pos[i].y-pos[j].y;
        let d2=dx*dx+dy*dy || 0.01, d=Math.sqrt(d2);
        let force=(k*k)/d2*0.5;
        fx+=(dx/d)*force; fy+=(dy/d)*force;
      }
      vel[i].x=(vel[i].x+fx)*0.82; vel[i].y=(vel[i].y+fy)*0.82;
    }
    edgeIdx.forEach(e=>{
      let dx=pos[e.b].x-pos[e.a].x, dy=pos[e.b].y-pos[e.a].y;
      let d=Math.sqrt(dx*dx+dy*dy)||0.01;
      let force=(d-k)/k*2.0;
      let fx=(dx/d)*force, fy=(dy/d)*force;
      vel[e.a].x+=fx; vel[e.a].y+=fy; vel[e.b].x-=fx; vel[e.b].y-=fy;
    });
    for(let i=0;i<n;i++){
      vel[i].x += (W/2-pos[i].x)*0.0012;
      vel[i].y += (H/2-pos[i].y)*0.0012;
      pos[i].x += vel[i].x*0.035;
      pos[i].y += vel[i].y*0.035;
    }
  }
  nodes.forEach((nd,i)=> POS[nd.id]=pos[i]);
}

/* grau (conexoes) por nota, para tamanho do circulo */
const DEGREE = {};
NOTES.forEach(n=>DEGREE[n.id]=0);
EDGES.forEach(e=>{ DEGREE[e.from]=(DEGREE[e.from]||0)+1; DEGREE[e.to]=(DEGREE[e.to]||0)+1; });

/* ---------------- RENDER ---------------- */
const view = document.getElementById('view');
let state = {v:'home'};
function go(s){ state=s; render(); window.scrollTo(0,0); syncNav(); }
function syncNav(){
  document.getElementById('nav-map').classList.toggle('active', state.v==='home');
  document.getElementById('nav-revisao').classList.toggle('active', state.v==='revisao');
}

function sidebar(){
  const counts={}; NOTES.forEach(n=>counts[n.dom]=(counts[n.dom]||0)+1);
  const box=document.getElementById('doms');
  box.innerHTML = DOM_ORDER.map(d=>{
    const c=counts[d]||0;
    return `<button class="dom" data-d="${d}" data-empty="${c?0:1}" ${c?`onclick="go({v:'dom',dom:'${d}'})"`:''}>
      <span class="dot" style="background:${DOMS[d].c}"></span>
      <span class="nm">${DOMS[d].nm}</span><span class="ct">${c}</span></button>`;
  }).join('');
  document.getElementById('foot').innerHTML =
    `Base de conhecimento atômica — <b>${NOTES.length} notas</b> extraídas do cânone de 4 obras sobre treino de ciclismo, organizadas por domínio, com relações explícitas entre si.`;
}

document.getElementById('search').addEventListener('input', e=>{
  const q=e.target.value.trim().toLowerCase();
  if(!q){ go({v:'home'}); return; }
  state={v:'search',q}; render();
});

function render(){
  if(state.v==='home') return renderHome();
  if(state.v==='revisao') return renderRevisao();
  if(state.v==='note') return renderNote(state.id);
  if(state.v==='dom')  return renderList(NOTES.filter(n=>n.dom===state.dom), shortDom(state.dom), domColor(state.dom), 'domínio');
  if(state.v==='search'){
    const q=state.q;
    const res=NOTES.filter(n=>(n.titulo+' '+n.id+' '+(n.sinais||[]).join(' ')+' '+(n.body||'')).toLowerCase().includes(q));
    return renderList(res, `Busca: "${state.q}"`, 'var(--ink)', 'busca');
  }
}
function chip(txt,bg,cls){ return `<span class="chip ${cls||''}" style="${bg?`background:${bg}`:''}">${txt}</span>`; }

let zoom = {s:1, tx:0, ty:0};
function renderHome(){
  view.innerHTML = `
    <div class="h-eyebrow">Mapa de relações</div>
    <h1>Como o conhecimento se conecta</h1>
    <p class="lede">Cada nó é uma nota — um conceito, uma regra ou uma referência tirada dos livros. As linhas mostram como elas se apoiam umas nas outras. É assim que a IA "caminha" de um conceito a outro para montar o feedback.</p>
    <p class="hint">Clique num nó para abrir a nota, arraste para mover o mapa, use a roda do mouse (ou os botões) para dar zoom.</p>
    <div class="graphcard">
      <div class="graphhead">
        <span class="t">${NOTES.length} notas · ${EDGES.length} vínculos</span>
        <div class="legend">
          <span><span class="lg-line pre"></span> pré-requisito</span>
          <span><span class="lg-line cau"></span> causal</span>
          <span><span class="lg-line com"></span> complementa</span>
          <span><span class="lg-line con"></span> contradiz</span>
          <span><span class="lg-line alt"></span> alternativa</span>
        </div>
      </div>
      <div class="graphwrap">
        ${graphSVG()}
        <div class="graphctl">
          <button class="gbtn" onclick="zoomBy(1.25)">+</button>
          <button class="gbtn" onclick="zoomBy(0.8)">−</button>
          <button class="gbtn" onclick="zoomReset()">⤾</button>
        </div>
      </div>
    </div>`;
  wireGraph();
}
function edgeCls(tipo){
  if(tipo==='causal') return 'cau';
  if(tipo==='complementa') return 'com';
  if(tipo==='contradiz') return 'con';
  if(tipo==='alternativa-a') return 'alt';
  return 'pre';
}
function graphSVG(){
  if(Object.keys(POS).length===0) computeLayout();
  const edges = EDGES.map((e,i)=>{
    const a=POS[e.from], b=POS[e.to]; if(!a||!b) return '';
    return `<line class="edge ${edgeCls(e.tipo)}" data-i="${i}" data-a="${e.from}" data-b="${e.to}"
      x1="${a.x.toFixed(1)}" y1="${a.y.toFixed(1)}" x2="${b.x.toFixed(1)}" y2="${b.y.toFixed(1)}"></line>`;
  }).join('');
  const nodes = NOTES.map(n=>{
    const p = POS[n.id]; if(!p) return '';
    const deg = DEGREE[n.id]||0;
    const r = Math.min(6 + deg*0.9, 16);
    const idnum = n.id.replace('nota-','').replace(/^0+/,'');
    return `<g class="gnode" data-id="${n.id}" tabindex="0" role="button"
        aria-label="${escapeHtml(n.titulo)}"
        onclick="go({v:'note',id:'${n.id}'})"
        onkeydown="if(event.key==='Enter')go({v:'note',id:'${n.id}'})">
      <title>${escapeHtml(n.titulo)}</title>
      <circle cx="${p.x.toFixed(1)}" cy="${p.y.toFixed(1)}" r="${r}" fill="${domColor(n.dom)}"></circle>
      ${r>=9?`<text class="tag" x="${p.x.toFixed(1)}" y="${(p.y+2.8).toFixed(1)}">${idnum}</text>`:''}
    </g>`;
  }).join('');
  return `<svg class="graph" id="graphSvg" viewBox="0 0 1800 1300" preserveAspectRatio="xMidYMid meet">
    <g id="viewport" transform="translate(${zoom.tx},${zoom.ty}) scale(${zoom.s})">
    <g>${edges}</g><g>${nodes}</g></g></svg>`;
}
function zoomBy(f){
  zoom.s = Math.max(0.35, Math.min(4, zoom.s*f));
  applyZoom();
}
function zoomReset(){ zoom={s:1,tx:0,ty:0}; applyZoom(); }
function applyZoom(){
  const vp = document.getElementById('viewport');
  if(vp) vp.setAttribute('transform', `translate(${zoom.tx},${zoom.ty}) scale(${zoom.s})`);
}
function wireGraph(){
  const svg=view.querySelector('svg.graph');
  if(!svg) return;
  const nodes=[...svg.querySelectorAll('.gnode')];
  const edges=[...svg.querySelectorAll('.edge')];
  nodes.forEach(g=>{
    g.addEventListener('mouseenter',()=>hot(g.dataset.id,true));
    g.addEventListener('mouseleave',()=>hot(null,false));
    g.addEventListener('focus',()=>hot(g.dataset.id,true));
    g.addEventListener('blur',()=>hot(null,false));
  });
  function hot(id,on){
    if(!on||!id){ svg.classList.remove('dim'); edges.forEach(e=>e.classList.remove('hot')); nodes.forEach(n=>n.classList.remove('hot','nb')); return; }
    svg.classList.add('dim');
    const nb=new Set([id]);
    edges.forEach(e=>{
      if(e.dataset.a===id||e.dataset.b===id){ e.classList.add('hot'); nb.add(e.dataset.a); nb.add(e.dataset.b); }
      else e.classList.remove('hot');
    });
    nodes.forEach(n=>n.classList.toggle('hot', nb.has(n.dataset.id)));
  }
  /* pan + zoom */
  let dragging=false, sx=0, sy=0, ostx=0, osty=0;
  svg.addEventListener('mousedown', e=>{ dragging=true; svg.classList.add('panning'); sx=e.clientX; sy=e.clientY; ostx=zoom.tx; osty=zoom.ty; });
  window.addEventListener('mouseup', ()=>{ dragging=false; svg.classList.remove('panning'); });
  window.addEventListener('mousemove', e=>{
    if(!dragging) return;
    zoom.tx = ostx + (e.clientX-sx)/zoom.s;
    zoom.ty = osty + (e.clientY-sy)/zoom.s;
    applyZoom();
  });
  svg.addEventListener('wheel', e=>{
    e.preventDefault();
    zoomBy(e.deltaY<0?1.1:0.9);
  }, {passive:false});
}

function renderRevisao(){
  const groups = {'baixa-confianca':[], 'conflito':[], 'modelo-concorrente':[]};
  REVISOES.forEach(r=>{ if(groups[r.tipo]) groups[r.tipo].push(r); });
  const labels = {'baixa-confianca':'Baixa confiança','conflito':'Conflitos','modelo-concorrente':'Modelos concorrentes'};
  const descs = {
    'baixa-confianca':'Notas mantidas no cânone mas com confiança rebaixada — geralmente por vir de estudo único, amostra pequena, ou depender de dado não coletável pelo Strava. Cada uma tem uma decisão humana pendente.',
    'conflito':'Divergências numéricas encontradas entre notas ou dentro da mesma fonte — registradas em vez de resolvidas unilateralmente.',
    'modelo-concorrente':'Frameworks conceituais que descrevem o mesmo fenômeno de formas diferentes, sem consenso único no cânone sobre qual usar.'
  };
  let html = `<div class="h-eyebrow">Revisão pendente</div>
    <h1>O que ainda não está fechado</h1>
    <p class="lede">Nem tudo no cânone é definitivo. Esta seção reúne o que foi extraído com ressalvas: notas de confiança baixa, números que se contradizem entre si, e modelos conceituais concorrentes — tudo aguardando decisão humana antes de virar regra automática de feedback.</p>`;
  ['baixa-confianca','conflito','modelo-concorrente'].forEach(tipo=>{
    const items = groups[tipo];
    if(!items.length) return;
    html += `<div class="revsection"><div class="revhead"><span class="revdot ${tipo}"></span>${labels[tipo]}<span class="revcount">${items.length}</span></div>
      <p class="hint">${descs[tipo]}</p>
      <div class="revlist">` +
      items.map(r=>`<div class="revcard">
        <div class="revtop">
          ${r.confianca!=null?`<span class="chip line">confiança ${r.confianca.toFixed(2).replace('.',',')}</span>`:'<span></span>'}
          <div class="revnotas">${r.notas.map(id=>`<button class="relitem-mini" onclick="go({v:'note',id:'${id}'})">${id.replace('nota-','#')}</button>`).join('')}</div>
        </div>
        <div class="revtitle">${escapeHtml(r.titulo)}</div>
        <div class="revbody">${mdToHtml(r.body)}</div>
      </div>`).join('') +
      `</div></div>`;
  });
  view.innerHTML = html;
}

function renderNote(id){
  const n=byId[id]; if(!n){ go({v:'home'}); return; }
  const inc=incoming(id);
  const revFlags = REVISOES.filter(r=>r.notas.includes(id));
  const relOut = (n.rel||[]).map(r=>relItem(r.id, r.tipo, r.justificativa)).join('') || '<div class="hint">Nenhuma.</div>';
  const relIn  = inc.map(r=>relItem(r.from, r.tipo, r.just)).join('') || '<div class="hint">Nenhuma.</div>';
  const {main, apply} = splitBody(n.body);
  const applyBlock = apply ? `<div class="apply"><span class="k">Aplicação ao feedback</span>${inlineMd(apply)}</div>` : '';
  const fontesHtml = (n.fontes||[]).map(f=>`<div class="src"><span class="bk">${escapeHtml(f.arquivo||'')}</span>${f.pagina?` · <span class="pg">p. ${escapeHtml(f.pagina)}</span>`:''}${f.trecho?`<div class="q">${escapeHtml(f.trecho)}</div>`:''}</div>`).join('') || '<div class="hint">—</div>';
  view.innerHTML = `
    <button class="back" onclick="go({v:'home'})">← mapa de relações</button>
    ${revFlags.length?`<div class="revflag">⚠ Marcada para revisão (${revFlags.map(r=>REV_LABELS[r.tipo]).join(', ')}). <button onclick="go({v:'revisao'})">ver detalhes →</button></div>`:''}
    <div class="badges">
      <span class="tag-id">${n.id}</span>
      ${chip(shortDom(n.dom), domColor(n.dom))}
      ${chip(TIPO[n.tipo]||n.tipo,'','type')}
      ${n.conf!=null?chip('confiança '+n.conf.toFixed(2).replace('.',','),'','line'):''}
      ${n.status?chip(n.status,'','line'):''}
    </div>
    <h2 class="note">${escapeHtml(n.titulo)}</h2>
    <div class="body">${mdToHtml(main)}</div>
    ${applyBlock}
    <div class="cols">
      <div class="panel">
        <h3>Fontes</h3>
        ${fontesHtml}
        <h3 style="margin-top:18px">Sinais do Strava</h3>
        <div class="sinais">${(n.sinais||[]).map(s=>`<span class="sig">${escapeHtml(s)}</span>`).join('')||'<span class="hint">—</span>'}</div>
      </div>
      <div class="panel">
        <h3>Esta nota se apoia em</h3>
        <div class="rel">${relOut}</div>
        <h3 style="margin-top:18px">É usada por</h3>
        <div class="rel">${relIn}</div>
      </div>
    </div>`;
}
function relItem(id,tipo,just){
  const t=byId[id]; const title = t?t.titulo:id;
  return `<button class="relitem" onclick="go({v:'note',id:'${id}'})">
    <div class="rrow"><span class="rt ${tipo}">${tipo}</span>
    <span class="rx"><b>${id.replace('nota-','#')}</b>${escapeHtml(title)}</span></div>
    ${just?`<div class="rj">${escapeHtml(just)}</div>`:''}
    </button>`;
}
function renderList(list,title,color,kind){
  const cards = list.length? list.map(n=>`
    <button class="ncard" onclick="go({v:'note',id:'${n.id}'})">
      <div class="top"><span class="cid">${n.id.replace('nota-','#')}</span>
        <span class="miniline">${TIPO[n.tipo]||n.tipo}</span></div>
      <div class="tt">${escapeHtml(n.titulo)}</div>
      <div class="mt"><span class="mini" style="background:${domColor(n.dom)}">${shortDom(n.dom)}</span></div>
    </button>`).join('') : `<div class="empty">Nada encontrado nesta ${kind}.</div>`;
  view.innerHTML = `
    <button class="back" onclick="go({v:'home'})">← mapa de relações</button>
    <div class="listhead"><span class="dot" style="background:${color}"></span>${title}</div>
    <div class="listsub">${list.length} nota(s).</div>
    <div class="cards">${cards}</div>`;
}

sidebar();
render();
</script>
</body>
</html>
"""


def main():
    parser = argparse.ArgumentParser(description="Gera o wiki HTML autocontido a partir das notas.")
    script_dir = Path(__file__).resolve().parent
    parser.add_argument("--notas-dir", default=str(script_dir.parent / "notas"),
                         help="Pasta contendo as notas (default: ../notas relativo a este script)")
    parser.add_argument("--revisao-dir", default=str(script_dir.parent / "_revisao"),
                         help="Pasta contendo as anotacoes de revisao (default: ../_revisao)")
    parser.add_argument("--saida", default=str(script_dir / "index.html"),
                         help="Arquivo HTML de saida (default: index.html nesta pasta)")
    args = parser.parse_args()

    notas_dir = Path(args.notas_dir)
    if not notas_dir.exists():
        print(f"Erro: pasta de notas nao encontrada: {notas_dir}", file=sys.stderr)
        sys.exit(1)

    notas = coletar_notas(notas_dir)
    if not notas:
        print(f"Aviso: nenhuma nota .md encontrada em {notas_dir}", file=sys.stderr)

    def id_key(n):
        m = re.search(r"(\d+)", n.get("id", "0"))
        return int(m.group(1)) if m else 0
    notas.sort(key=id_key)

    revisao_dir = Path(args.revisao_dir)
    revisoes = coletar_revisoes(revisao_dir)

    html = build_html(notas, revisoes)
    saida = Path(args.saida)
    saida.write_text(html, encoding="utf-8")
    print(f"OK: {len(notas)} notas e {len(revisoes)} anotacoes de revisao processadas. Wiki gerado em: {saida}")


if __name__ == "__main__":
    main()
