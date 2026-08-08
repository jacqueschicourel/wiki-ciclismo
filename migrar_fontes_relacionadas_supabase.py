#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
migrar_fontes_relacionadas_supabase.py — carrega os campos `fontes` (citação
exata de arquivo/página/trecho da fonte primária) e `relacionadas` (links
cruzados entre notas) do frontmatter local das 291 notas em notas/ para as
colunas `fontes` (jsonb) e `relacionadas` (text[]) recém-criadas na tabela
`notas` do Supabase (migração 020_add_fontes_relacionadas_notas).

Reusa coletar_notas() de gerar_wiki.py — o mesmo parser que a wiki estática
já usa para exibir "fontes"/"relacionadas" na página de cada nota — para
garantir que o valor migrado é byte-a-byte o que a wiki local já mostra,
sem reinterpretar o YAML na mão.

Pré-requisito (já aplicado via MCP Supabase nesta sessão):
  - migração 020_add_fontes_relacionadas_notas (colunas fontes/relacionadas)
  - migração 021_policy_temp_update_fontes_relacionadas (policy temporária
    de UPDATE para a role anon, restrita a este backfill — remover depois
    de confirmar que a carga funcionou; avisar no chat quando terminar)

Uso:
    python migrar_fontes_relacionadas_supabase.py
"""

import json
import sys
import urllib.request
import urllib.error
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gerar_wiki import coletar_notas  # reaproveita o parser exato da wiki atual

SUPABASE_URL = "https://ojftdbogrkfbceqnwjih.supabase.co"
ANON_KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qZnRkYm9ncmtmYmNlcW53amloIiwi"
    "cm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NjE4NzksImV4cCI6MjEwMTUzNzg3OX0.8eJyLYCIPb4Wygd83lCWZcwBCtB2DxjCVIbGdS6EcmM"
)


def rest_call(method, path, body=None, prefer=None):
    url = f"{SUPABASE_URL}/rest/v1/{path}"
    data = json.dumps(body).encode("utf-8") if body is not None else None
    req = urllib.request.Request(url, data=data, method=method)
    req.add_header("apikey", ANON_KEY)
    req.add_header("Authorization", f"Bearer {ANON_KEY}")
    req.add_header("Content-Type", "application/json")
    if prefer:
        req.add_header("Prefer", prefer)
    try:
        with urllib.request.urlopen(req) as resp:
            raw = resp.read()
            return resp.status, (json.loads(raw) if raw else None)
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", errors="replace")
        return e.code, raw


def main():
    script_dir = Path(__file__).resolve().parent
    notas_dir = script_dir.parent / "notas"
    notas = coletar_notas(notas_dir)

    print(f"Encontradas {len(notas)} notas em {notas_dir}")

    ok, falhou = 0, []
    for n in notas:
        nid = n.get("id")
        if not nid:
            continue
        payload = {
            "fontes": n.get("fontes") or [],
            "relacionadas": n.get("relacionadas") or [],
        }
        status, resp = rest_call(
            "PATCH", f"notas?id=eq.{nid}", payload, prefer="return=minimal"
        )
        if status in (200, 204):
            ok += 1
        else:
            falhou.append((nid, status, resp))

    print(f"\nOK: {ok}/{len(notas)} notas atualizadas com fontes/relacionadas")
    if falhou:
        print(f"[erro] {len(falhou)} falharam:", file=sys.stderr)
        for nid, status, resp in falhou[:10]:
            print(f"  {nid}: status={status} resp={resp}", file=sys.stderr)
        sys.exit(1)

    print(
        "\nOK - migração de fontes/relacionadas concluída. Avise no chat para eu "
        "verificar as contagens e remover a policy temporária de UPDATE (anon)."
    )


if __name__ == "__main__":
    main()
