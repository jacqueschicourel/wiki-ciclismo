#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
migrar_direto_supabase.py — mesma extracao de migrar_para_supabase.py, mas em
vez de gerar arquivos .sql para transcricao manual, envia os dados DIRETO pro
banco via API REST do Supabase (PostgREST), usando a chave publica "anon"
(protegida por RLS — nao e segredo, pode ficar no script).

Evita o risco de erro de transcricao manual de ~300 notas atraves do chat.

IMPORTANTE: as policies de INSERT/UPDATE temporarias em notas/skills/
notas_fontes/notas_relacoes para a role anon precisam existir no banco antes
de rodar este script (foram criadas so para esta migracao inicial e devem ser
removidas depois — avise no chat quando terminar de rodar).

Uso:
    python migrar_direto_supabase.py
"""

import json
import sys
import urllib.request
import urllib.error
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from migrar_para_supabase import coletar_notas, coletar_skills, avisos  # reaproveita o parser

SUPABASE_URL = "https://ojftdbogrkfbceqnwjih.supabase.co"
ANON_KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qZnRkYm9ncmtmYmNlcW53amloIiwi"
    "cm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NjE4NzksImV4cCI6MjEwMTUzNzg3OX0.8eJyLYCIPb4Wygd83lCWZcwBCtB2DxjCVIbGdS6EcmM"
)
BATCH = 50


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


def chunks(lst, n):
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def migrar_notas(notas):
    ok, falhas = 0, []
    for batch in chunks(notas, BATCH):
        payload = [
            {
                "id": n["id"], "titulo": n["titulo"], "dominio_slug": n["dominio"],
                "aplicacao_slug": n["aplicacao"], "tipo_nota_slug": n["tipo_nota"],
                "camadas": n["camada"], "sinais": n["sinais"], "confianca": n["confianca"],
                "status": n["status"], "corpo": n["body"],
            }
            for n in batch
        ]
        status, resp = rest_call(
            "POST", "notas?on_conflict=id", payload,
            prefer="resolution=merge-duplicates,return=minimal",
        )
        if status in (200, 201, 204):
            ok += len(batch)
        else:
            falhas.append(([n["id"] for n in batch], status, resp))
            print(f"[erro] lote de notas falhou: status={status} resp={resp}", file=sys.stderr)
    return ok, falhas


def migrar_fontes_relacoes(notas):
    fontes_payload = []
    relacoes_payload = []
    for n in notas:
        for f in n["fontes"]:
            fontes_payload.append({
                "nota_id": n["id"], "arquivo": f.get("arquivo"),
                "pagina": str(f.get("pagina")) if f.get("pagina") is not None else None,
                "trecho": f.get("trecho"),
            })
        for r in n["relacionadas"]:
            if r.get("id"):
                relacoes_payload.append({
                    "nota_origem_id": n["id"], "nota_destino_id": r.get("id"),
                    "tipo": r.get("tipo"), "justificativa": r.get("justificativa"),
                })

    # limpa as tabelas filhas antes (idempotente em re-execucoes)
    rest_call("DELETE", "notas_fontes?id=not.is.null")
    rest_call("DELETE", "notas_relacoes?id=not.is.null")

    ok_f = 0
    for batch in chunks(fontes_payload, BATCH):
        status, resp = rest_call("POST", "notas_fontes", batch, prefer="return=minimal")
        if status in (200, 201, 204):
            ok_f += len(batch)
        else:
            print(f"[erro] lote de fontes falhou: status={status} resp={resp}", file=sys.stderr)

    ok_r = 0
    for batch in chunks(relacoes_payload, BATCH):
        status, resp = rest_call("POST", "notas_relacoes", batch, prefer="return=minimal")
        if status in (200, 201, 204):
            ok_r += len(batch)
        else:
            print(f"[erro] lote de relacoes falhou: status={status} resp={resp}", file=sys.stderr)

    return ok_f, len(fontes_payload), ok_r, len(relacoes_payload)


def migrar_skills(skills):
    ok, falhas = 0, []
    for batch in chunks(skills, BATCH):
        payload = [
            {
                "id": s["id"], "numero": s["numero"], "titulo": s["titulo"],
                "dominio_slug": s["dominio"], "tipo_skill_slug": s["tipo_skill"],
                "notas_usadas": s["notas_usadas"],
                "confianca_herdada": (str(s["confianca_herdada"]) if s["confianca_herdada"] is not None else None),
                "condicao_nao_calculavel": s["condicao_nao_calculavel"],
                "dados_necessarios": s["dados_necessarios"],
                "skills_relacionadas": s["skills_relacionadas"],
                "log_de_teste": s["log_de_teste"], "status": s["status"], "corpo": s["body"],
            }
            for s in batch
        ]
        status, resp = rest_call(
            "POST", "skills?on_conflict=id", payload,
            prefer="resolution=merge-duplicates,return=minimal",
        )
        if status in (200, 201, 204):
            ok += len(batch)
        else:
            falhas.append((status, resp))
            print(f"[erro] lote de skills falhou: status={status} resp={resp}", file=sys.stderr)
    return ok, falhas


def main():
    notas = coletar_notas()
    skills = coletar_skills()

    print(f"Migrando {len(notas)} notas...")
    ok_n, falhas_n = migrar_notas(notas)
    print(f"  notas: {ok_n}/{len(notas)} OK, {len(falhas_n)} lote(s) com erro")

    print("Migrando fontes e relacionadas...")
    ok_f, tot_f, ok_r, tot_r = migrar_fontes_relacoes(notas)
    print(f"  fontes: {ok_f}/{tot_f} OK | relacoes: {ok_r}/{tot_r} OK")

    print(f"Migrando {len(skills)} skills...")
    ok_s, falhas_s = migrar_skills(skills)
    print(f"  skills: {ok_s}/{len(skills)} OK, {len(falhas_s)} lote(s) com erro")

    if avisos:
        print(f"\nAvisos de parsing ({len(avisos)}):")
        for a in avisos:
            print(f"  {a}")

    print("\nOK - migracao concluida. Avise no chat para eu verificar e remover as policies temporarias de escrita anonima.")


if __name__ == "__main__":
    main()
