#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
auditar_migracao.py — compara, campo a campo, as notas/skills nos arquivos
.md contra o que esta no banco Supabase, e reporta qualquer divergencia.

Requer a policy temporaria de leitura ampliada (anon consegue ver notas
status=revisar tambem) — criada so para esta auditoria, remover depois.

Uso:
    python auditar_migracao.py
"""

import json
import sys
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from migrar_para_supabase import coletar_notas, coletar_skills

SUPABASE_URL = "https://ojftdbogrkfbceqnwjih.supabase.co"
ANON_KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qZnRkYm9ncmtmYmNlcW53amloIiwi"
    "cm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NjE4NzksImV4cCI6MjEwMTUzNzg3OX0.8eJyLYCIPb4Wygd83lCWZcwBCtB2DxjCVIbGdS6EcmM"
)


def fetch_all(path):
    req = urllib.request.Request(f"{SUPABASE_URL}/rest/v1/{path}")
    req.add_header("apikey", ANON_KEY)
    req.add_header("Authorization", f"Bearer {ANON_KEY}")
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())


def norm_num(x):
    if x is None:
        return None
    return round(float(x), 2)


def main():
    problemas = []

    notas_arq = {n["id"]: n for n in coletar_notas()}
    skills_arq = {s["id"]: s for s in coletar_skills()}

    notas_db = {r["id"]: r for r in fetch_all("notas?select=*&limit=2000")}
    skills_db = {r["id"]: r for r in fetch_all("skills?select=*&limit=2000")}
    fontes_db = fetch_all("notas_fontes?select=*&limit=2000")
    relacoes_db = fetch_all("notas_relacoes?select=*&limit=2000")

    print(f"Arquivo: {len(notas_arq)} notas, {len(skills_arq)} skills")
    print(f"Banco:   {len(notas_db)} notas, {len(skills_db)} skills, {len(fontes_db)} fontes, {len(relacoes_db)} relacoes")

    # --- notas: campo a campo ---
    for nid, n in notas_arq.items():
        r = notas_db.get(nid)
        if not r:
            problemas.append(f"[FALTA] {nid} existe no arquivo mas nao no banco")
            continue
        if r["titulo"] != n["titulo"]:
            problemas.append(f"[titulo] {nid}: arquivo={n['titulo']!r} banco={r['titulo']!r}")
        if r["dominio_slug"] != n["dominio"]:
            problemas.append(f"[dominio] {nid}: arquivo={n['dominio']!r} banco={r['dominio_slug']!r}")
        if r["aplicacao_slug"] != n["aplicacao"]:
            problemas.append(f"[aplicacao] {nid}: arquivo={n['aplicacao']!r} banco={r['aplicacao_slug']!r}")
        if r["tipo_nota_slug"] != n["tipo_nota"]:
            problemas.append(f"[tipo_nota] {nid}: arquivo={n['tipo_nota']!r} banco={r['tipo_nota_slug']!r}")
        if sorted(r["camadas"] or []) != sorted(n["camada"] or []):
            problemas.append(f"[camada] {nid}: arquivo={n['camada']!r} banco={r['camadas']!r}")
        if sorted(r["sinais"] or []) != sorted(n["sinais"] or []):
            problemas.append(f"[sinais] {nid}: arquivo={n['sinais']!r} banco={r['sinais']!r}")
        if norm_num(r["confianca"]) != norm_num(n["confianca"]):
            problemas.append(f"[confianca] {nid}: arquivo={n['confianca']!r} banco={r['confianca']!r}")
        status_esperado = "revisar" if n["status"] == "revisar" else "ativo"
        if r["status"] != status_esperado:
            problemas.append(f"[status] {nid}: arquivo(orig)={n['status']!r}->esperado={status_esperado!r} banco={r['status']!r}")
        if r["corpo"] != n["body"]:
            problemas.append(f"[corpo] {nid}: DIFERENTE (tamanhos arquivo={len(n['body'])} banco={len(r['corpo'])})")

        # fontes
        fontes_arq = sorted((f.get("arquivo"), str(f.get("pagina")), f.get("trecho")) for f in n["fontes"])
        fontes_banco = sorted(
            (f["arquivo"], f["pagina"], f["trecho"]) for f in fontes_db if f["nota_id"] == nid
        )
        if fontes_arq != fontes_banco:
            problemas.append(f"[fontes] {nid}: arquivo tem {len(fontes_arq)}, banco tem {len(fontes_banco)} — {'DIFERENTES' if len(fontes_arq)==len(fontes_banco) else 'CONTAGEM DIFERENTE'}")

        # relacionadas
        rel_arq = sorted((r2.get("id"), r2.get("tipo"), r2.get("justificativa")) for r2 in n["relacionadas"] if r2.get("id"))
        rel_banco = sorted(
            (rr["nota_destino_id"], rr["tipo"], rr["justificativa"]) for rr in relacoes_db if rr["nota_origem_id"] == nid
        )
        if rel_arq != rel_banco:
            problemas.append(f"[relacionadas] {nid}: arquivo tem {len(rel_arq)}, banco tem {len(rel_banco)}")

    for nid in notas_db:
        if nid not in notas_arq:
            problemas.append(f"[SOBRA] {nid} existe no banco mas nao no arquivo")

    # --- skills: campo a campo ---
    for sid, s in skills_arq.items():
        r = skills_db.get(sid)
        if not r:
            problemas.append(f"[FALTA] skill {sid} existe no arquivo mas nao no banco")
            continue
        if r["numero"] != (s["numero"] or None):
            problemas.append(f"[numero] {sid}: arquivo={s['numero']!r} banco={r['numero']!r}")
        if r["titulo"] != s["titulo"]:
            problemas.append(f"[titulo] {sid}: DIFERENTE")
        if r["dominio_slug"] != s["dominio"]:
            problemas.append(f"[dominio] {sid}: arquivo={s['dominio']!r} banco={r['dominio_slug']!r}")
        if r["corpo"] != s["body"]:
            problemas.append(f"[corpo] {sid}: DIFERENTE (tamanhos arquivo={len(s['body'])} banco={len(r['corpo'])})")
        if sorted(r["notas_usadas"] or []) != sorted(s["notas_usadas"] or []):
            problemas.append(f"[notas_usadas] {sid}: arquivo={s['notas_usadas']!r} banco={r['notas_usadas']!r}")
        if json.dumps(r["dados_necessarios"], sort_keys=True) != json.dumps(s["dados_necessarios"], sort_keys=True):
            problemas.append(f"[dados_necessarios] {sid}: DIFERENTE")
        if json.dumps(r["skills_relacionadas"], sort_keys=True) != json.dumps(s["skills_relacionadas"], sort_keys=True):
            problemas.append(f"[skills_relacionadas] {sid}: DIFERENTE")

    for sid in skills_db:
        if sid not in skills_arq and sid != "":
            problemas.append(f"[SOBRA] skill {sid} existe no banco mas nao no arquivo")

    print(f"\n{'='*60}")
    if problemas:
        print(f"DIVERGENCIAS ENCONTRADAS: {len(problemas)}")
        for p in problemas:
            print(f"  {p}")
    else:
        print("NENHUMA DIVERGENCIA — banco 100% fiel aos arquivos, campo a campo.")


if __name__ == "__main__":
    main()
