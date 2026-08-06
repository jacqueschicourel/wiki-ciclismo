#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
migrar_revisao_supabase.py — migra os 40 arquivos de _revisao/ (baixa-confianca,
conflitos, modelos-concorrentes) para a tabela revisao_legado no Supabase,
reusando a mesma logica de parsing (coletar_revisoes) do gerar_wiki.py — a
mesma que gera a view "Revisao pendente" do wiki estatico atual. Isso garante
que os dados no banco sejam byte-a-byte equivalentes ao que a wiki ja mostra.

Envia direto via API REST (anon key, protegida por RLS) — mesmo padrao usado
em migrar_direto_supabase.py, sem passar dados manualmente pelo chat.

IMPORTANTE: a policy temporaria de insert para anon em revisao_legado precisa
existir antes de rodar (ja criada na migracao 013_revisao_legado). Apos rodar
com sucesso, avisar no chat para remover essa policy temporaria.

Uso:
    python migrar_revisao_supabase.py
"""

import json
import sys
import urllib.request
import urllib.error
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gerar_wiki import coletar_revisoes  # reaproveita o parser exato da wiki atual

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
    revisao_dir = script_dir.parent / "_revisao"
    revisoes = coletar_revisoes(revisao_dir)

    print(f"Encontrados {len(revisoes)} registros em {revisao_dir}")

    # limpa antes (idempotente em re-execucoes)
    status, resp = rest_call("DELETE", "revisao_legado?id=gt.0")
    if status not in (200, 204):
        print(f"[aviso] limpeza previa falhou: status={status} resp={resp}", file=sys.stderr)

    payload = [
        {
            "tipo": r["tipo"],
            "titulo": r["titulo"],
            "notas": r["notas"],
            "corpo": r["body"],
            "confianca": r["confianca"],
        }
        for r in revisoes
    ]

    status, resp = rest_call("POST", "revisao_legado", payload, prefer="return=minimal")
    if status in (200, 201, 204):
        print(f"OK: {len(payload)}/{len(payload)} registros inseridos em revisao_legado")
    else:
        print(f"[erro] insercao falhou: status={status} resp={resp}", file=sys.stderr)
        sys.exit(1)

    print("\nOK - migracao de _revisao concluida. Avise no chat para eu verificar e remover a policy temporaria de insercao anonima.")


if __name__ == "__main__":
    main()
