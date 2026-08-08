#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
migrar_para_supabase.py — le as 291 notas (notas/**/*.md) e as 26 skills
(skills/**/skill.md) e gera arquivos .sql prontos para rodar contra o banco
Supabase criado para o projeto LRF (ver tabelas notas/notas_fontes/
notas_relacoes/skills em public).

Nao se conecta ao banco diretamente (evita lidar com senha/connection string
neste script) — so gera arquivos .sql em wiki/migracao_sql/, em 3 fases (rodar
nesta ordem, cada arquivo e uma transacao):

  01_notas_*.sql              -> so a tabela `notas` (sem dependencias)
  02_fontes_relacoes_*.sql    -> `notas_fontes` + `notas_relacoes` (depende de
                                  TODAS as notas ja estarem inseridas, por isso
                                  vem depois da fase 01 completa)
  03_skills_*.sql             -> tabela `skills`

Reaproveita o parser de frontmatter ja validado em gerar_wiki.py (mesmo
arquivo, mesma pasta) em vez de reescrever do zero.

Uso:
    python migrar_para_supabase.py

Depois, no chat, peca para eu ler e rodar cada arquivo gerado (via Supabase
MCP) na ordem 01 -> 02 -> 03.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gerar_wiki import parse_frontmatter  # reaproveita o parser ja validado

BASE_DIR = Path(__file__).parent.parent  # LRF/
NOTAS_DIR = BASE_DIR / "notas"
SKILLS_DIR = BASE_DIR / "skills"
OUT_DIR = Path(__file__).parent / "migracao_sql"
BATCH_SIZE = 25

DOMINIOS_VALIDOS = {
    "fisiologia", "limiares-e-lactato", "metricas-de-potencia",
    "metodologia-e-periodizacao", "tipos-de-treino", "avaliacao-e-testes",
    "nutricao-e-energia", "recuperacao-e-fadiga", "contexto-atleta",
    "templates-feedback", "entrega-feedback",
}
APLICACOES_VALIDAS = {"direta", "contexto"}
TIPOS_NOTA_VALIDOS = {"regra-interpretacao", "conceito", "protocolo", "referencia"}
TIPOS_SKILL_VALIDOS = {
    "calculadora", "detector", "calculadora+detector",
    "classificador", "classificador+detector", "curador", "redator",
}
STATUS_SKILL_VALIDOS = {"proposto", "validado_com_ressalvas", "validado", "descontinuado"}

avisos = []
_tag_counter = [0]


def sql_str_or_null(value):
    """Dollar-quoting com tag unica por valor — evita qualquer problema de
    escaping (aspas simples, acentos, quebras de linha) sem depender de driver."""
    if value is None:
        return "NULL"
    s = str(value)
    if s == "":
        return "NULL"
    _tag_counter[0] += 1
    tag = f"$m{_tag_counter[0]}$"
    return f"{tag}{s}{tag}"


def sql_text_array(items):
    if not items:
        return "'{}'::text[]"
    return "ARRAY[" + ", ".join(sql_str_or_null(i) for i in items) + "]::text[]"


def sql_num_or_null(value):
    if value is None:
        return "NULL"
    try:
        return repr(float(value))
    except (TypeError, ValueError):
        return "NULL"


# --------------------------------------------------------------------------
# Parse de notas (usando so parse_frontmatter, sem as coercoes de gerar_wiki
# que nao servem pro schema do banco)
# --------------------------------------------------------------------------

def parse_nota_arquivo(path: Path):
    text = path.read_text(encoding="utf-8")
    parts = text.split("---", 2)
    if len(parts) < 3:
        avisos.append(f"[nota] {path} sem frontmatter valido, ignorada.")
        return None
    data = parse_frontmatter(parts[1])
    data["body"] = parts[2].strip()
    data["_arquivo"] = str(path)

    nid = data.get("id")
    if not nid:
        avisos.append(f"[nota] {path} sem campo id, ignorada.")
        return None

    dominio = data.get("dominio", "")
    if dominio not in DOMINIOS_VALIDOS:
        avisos.append(f"[nota] {nid}: dominio '{dominio}' fora da taxonomia atual — nao migrada, revisar manualmente.")
        return None

    aplicacao = data.get("aplicacao", "")
    if aplicacao not in APLICACOES_VALIDAS:
        avisos.append(f"[nota] {nid}: aplicacao '{aplicacao}' invalida — nao migrada, revisar manualmente.")
        return None

    tipo_nota = data.get("tipo_nota", "")
    if tipo_nota not in TIPOS_NOTA_VALIDOS:
        avisos.append(f"[nota] {nid}: tipo_nota '{tipo_nota}' invalido — nao migrada, revisar manualmente.")
        return None

    try:
        confianca = float(data.get("confianca"))
        if not (0 <= confianca <= 1):
            raise ValueError
    except (TypeError, ValueError):
        avisos.append(f"[nota] {nid}: confianca ausente/invalida — nao migrada, revisar manualmente.")
        return None

    status_raw = (data.get("status") or "").strip()
    status = "revisar" if status_raw == "revisar" else "ativo"
    if status_raw not in ("auto-aprovado", "revisar"):
        avisos.append(f"[nota] {nid}: status '{status_raw}' nao reconhecido, tratado como 'ativo'.")

    camada = data.get("camada") or []
    sinais = data.get("sinais") or []
    fontes = data.get("fontes") or []
    relacionadas = data.get("relacionadas") or []

    return {
        "id": nid, "titulo": data.get("titulo", nid), "dominio": dominio,
        "aplicacao": aplicacao, "tipo_nota": tipo_nota, "camada": camada,
        "sinais": sinais, "confianca": confianca, "status": status,
        "body": data["body"], "fontes": fontes, "relacionadas": relacionadas,
    }


def coletar_notas():
    notas = []
    for md_path in sorted(NOTAS_DIR.rglob("*.md")):
        n = parse_nota_arquivo(md_path)
        if n:
            notas.append(n)
    return notas


# --------------------------------------------------------------------------
# Parse de skills
# --------------------------------------------------------------------------

def parse_skill_arquivo(path: Path):
    text = path.read_text(encoding="utf-8")
    parts = text.split("---", 2)
    if len(parts) < 3:
        avisos.append(f"[skill] {path} sem frontmatter valido, ignorada.")
        return None
    data = parse_frontmatter(parts[1])
    data["body"] = parts[2].strip()

    sid = data.get("id") or path.parent.name
    numero = data.get("numero") or None

    dominio = data.get("dominio", "")
    if dominio not in DOMINIOS_VALIDOS:
        avisos.append(f"[skill] {sid}: dominio '{dominio}' fora da taxonomia atual — nao migrada, revisar manualmente.")
        return None

    tipo_skill = data.get("tipo_skill") or None
    if tipo_skill and tipo_skill not in TIPOS_SKILL_VALIDOS:
        avisos.append(f"[skill] {sid}: tipo_skill '{tipo_skill}' desconhecido — migrada sem tipo_skill_slug.")
        tipo_skill = None

    status_raw = (data.get("status") or "").strip()
    status = status_raw if status_raw in STATUS_SKILL_VALIDOS else "proposto"
    if status_raw not in STATUS_SKILL_VALIDOS:
        avisos.append(f"[skill] {sid}: status '{status_raw}' nao reconhecido, tratado como 'proposto'.")

    notas_usadas = data.get("notas_usadas") or []
    if notas_usadas and isinstance(notas_usadas[0], dict):
        notas_usadas = [d.get("id") for d in notas_usadas if d.get("id")]

    return {
        "id": sid, "numero": numero, "titulo": data.get("titulo", sid),
        "dominio": dominio, "tipo_skill": tipo_skill,
        "notas_usadas": notas_usadas,
        "confianca_herdada": data.get("confianca_herdada"),
        "condicao_nao_calculavel": data.get("condicao_nao_calculavel"),
        "dados_necessarios": data.get("dados_necessarios") or [],
        "skills_relacionadas": data.get("skills_relacionadas") or [],
        "log_de_teste": data.get("log_de_teste") or [],
        "status": status, "body": data["body"],
    }


def coletar_skills():
    skills = []
    if not SKILLS_DIR.exists():
        return skills
    for md_path in sorted(SKILLS_DIR.rglob("skill.md")):
        if md_path.name != "skill.md":
            continue
        s = parse_skill_arquivo(md_path)
        if s:
            skills.append(s)
    return skills


# --------------------------------------------------------------------------
# Geracao de SQL
# --------------------------------------------------------------------------

def gerar_sql_notas(batch):
    linhas = ["BEGIN;"]
    for n in batch:
        linhas.append(
            "INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, "
            "camadas, sinais, confianca, status, corpo) VALUES (\n"
            f"  {sql_str_or_null(n['id'])}, {sql_str_or_null(n['titulo'])}, {sql_str_or_null(n['dominio'])},\n"
            f"  {sql_str_or_null(n['aplicacao'])}, {sql_str_or_null(n['tipo_nota'])},\n"
            f"  {sql_text_array(n['camada'])}, {sql_text_array(n['sinais'])},\n"
            f"  {n['confianca']}, {sql_str_or_null(n['status'])}, {sql_str_or_null(n['body'])}\n"
            ")\n"
            "ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, "
            "aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, "
            "camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, "
            "status=excluded.status, corpo=excluded.corpo, atualizado_em=now();"
        )
    linhas.append("COMMIT;")
    return "\n".join(linhas)


def gerar_sql_fontes_relacoes(batch):
    linhas = ["BEGIN;"]
    ids = [n["id"] for n in batch]
    linhas.append(
        "DELETE FROM notas_fontes WHERE nota_id IN (" + ", ".join(sql_str_or_null(i) for i in ids) + ");"
    )
    linhas.append(
        "DELETE FROM notas_relacoes WHERE nota_origem_id IN (" + ", ".join(sql_str_or_null(i) for i in ids) + ");"
    )
    for n in batch:
        for f in n["fontes"]:
            linhas.append(
                "INSERT INTO notas_fontes (nota_id, arquivo, pagina, trecho) VALUES ("
                f"{sql_str_or_null(n['id'])}, {sql_str_or_null(f.get('arquivo'))}, "
                f"{sql_str_or_null(f.get('pagina'))}, {sql_str_or_null(f.get('trecho'))});"
            )
        for r in n["relacionadas"]:
            linhas.append(
                "INSERT INTO notas_relacoes (nota_origem_id, nota_destino_id, tipo, justificativa) VALUES ("
                f"{sql_str_or_null(n['id'])}, {sql_str_or_null(r.get('id'))}, "
                f"{sql_str_or_null(r.get('tipo'))}, {sql_str_or_null(r.get('justificativa'))})\n"
                "ON CONFLICT DO NOTHING;"
            )
    linhas.append("COMMIT;")
    return "\n".join(linhas)


def jsonb_literal(value):
    import json
    return sql_str_or_null(json.dumps(value, ensure_ascii=False)) + "::jsonb"


def gerar_sql_skills(batch):
    linhas = ["BEGIN;"]
    for s in batch:
        linhas.append(
            "INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, "
            "confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, "
            "log_de_teste, status, corpo) VALUES (\n"
            f"  {sql_str_or_null(s['id'])}, {sql_str_or_null(s['numero'])}, {sql_str_or_null(s['titulo'])},\n"
            f"  {sql_str_or_null(s['dominio'])}, {sql_str_or_null(s['tipo_skill'])},\n"
            f"  {sql_text_array(s['notas_usadas'])},\n"
            f"  {sql_str_or_null(s['confianca_herdada'])}, {sql_str_or_null(s['condicao_nao_calculavel'])},\n"
            f"  {jsonb_literal(s['dados_necessarios'])}, {jsonb_literal(s['skills_relacionadas'])},\n"
            f"  {jsonb_literal(s['log_de_teste'])}, {sql_str_or_null(s['status'])}, {sql_str_or_null(s['body'])}\n"
            ")\n"
            "ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, "
            "dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, "
            "notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, "
            "condicao_nao_calculavel=excluded.condicao_nao_calculavel, "
            "dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, "
            "log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, "
            "atualizado_em=now();"
        )
    linhas.append("COMMIT;")
    return "\n".join(linhas)


def batches(lst, n):
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def batches_por_tamanho(items, gerar_sql_fn, limite_chars=9000):
    """Agrupa itens em lotes cujo SQL gerado fique abaixo de limite_chars —
    evita gerar arquivos grandes demais para ler/transcrever com seguranca
    (o Read tool usado na migracao tem um teto de tokens por chamada)."""
    lote = []
    for item in items:
        candidato = lote + [item]
        if lote and len(gerar_sql_fn(candidato)) > limite_chars:
            yield lote
            lote = [item]
        else:
            lote = candidato
    if lote:
        yield lote


def main():
    import hashlib
    import json

    OUT_DIR.mkdir(exist_ok=True)
    for f in OUT_DIR.glob("*.sql"):
        f.unlink()

    notas = coletar_notas()
    skills = coletar_skills()

    for i, batch in enumerate(batches_por_tamanho(notas, gerar_sql_notas), start=1):
        (OUT_DIR / f"01_notas_{i:03d}.sql").write_text(gerar_sql_notas(batch), encoding="utf-8")
    for i, batch in enumerate(batches_por_tamanho(notas, gerar_sql_fontes_relacoes), start=1):
        (OUT_DIR / f"02_fontes_relacoes_{i:03d}.sql").write_text(gerar_sql_fontes_relacoes(batch), encoding="utf-8")
    for i, batch in enumerate(batches_por_tamanho(skills, gerar_sql_skills), start=1):
        (OUT_DIR / f"03_skills_{i:03d}.sql").write_text(gerar_sql_skills(batch), encoding="utf-8")

    # Manifesto de integridade: hash do corpo de cada nota/skill, para conferir depois que
    # o SQL foi executado que nada foi truncado/duplicado/sobrescrito na transcricao.
    manifesto = {
        "notas": {n["id"]: hashlib.md5(n["body"].encode("utf-8")).hexdigest() for n in notas},
        "skills": {s["id"]: hashlib.md5(s["body"].encode("utf-8")).hexdigest() for s in skills},
    }
    (OUT_DIR / "manifest.json").write_text(json.dumps(manifesto, ensure_ascii=False, indent=1), encoding="utf-8")

    if avisos:
        (OUT_DIR / "AVISOS.txt").write_text("\n".join(avisos), encoding="utf-8")

    print(f"OK: {len(notas)} notas e {len(skills)} skills convertidas em SQL, gravadas em {OUT_DIR}")
    print(f"Avisos: {len(avisos)} (ver AVISOS.txt)" if avisos else "Sem avisos.")
    print(f"Manifesto de integridade: {OUT_DIR / 'manifest.json'}")


if __name__ == "__main__":
    main()
