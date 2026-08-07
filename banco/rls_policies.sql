-- ============================================================================
-- LRF — políticas RLS ativas (Row Level Security)
-- Extraídas do estado vivo do banco via pg_policies em 2026-08-07.
--
-- Modelo de segurança em 2 frases:
--   1. Tudo que é conteúdo do cânone (notas ativas, skills, taxonomia, gabaritos,
--      regras, histórico) é de LEITURA PÚBLICA (role public/anon) — o app e a
--      wiki estática funcionam sem login para navegar/consultar.
--   2. A fila de ingestão/revisão (upload de fonte nova, decidir aprovar/reprovar
--      um item extraído) exige role "authenticated" — só o Jacques tem conta
--      neste projeto Supabase. Não há policy de INSERT/UPDATE para notas/skills
--      diretamente: a única forma de content entrar em notas/skills é via a
--      trigger promover_revisao_aprovada() (SECURITY DEFINER), disparada quando
--      uma linha de revisao_pendente muda pra status='aprovado'.
--
-- Todas as tabelas abaixo têm RLS habilitado (rls_enabled=true na list_tables).
-- ============================================================================

-- ---- leitura pública (role public), sem exceção -----------------------------

create policy "leitura publica" on public.taxonomia_dominios
  for select to public using (true);

create policy "leitura publica" on public.taxonomia_camadas
  for select to public using (true);

create policy "leitura publica" on public.taxonomia_aplicacoes
  for select to public using (true);

create policy "leitura publica" on public.taxonomia_tipos_nota
  for select to public using (true);

create policy "leitura publica" on public.taxonomia_tipos_skill
  for select to public using (true);

create policy "leitura publica" on public.taxonomia_sinais_strava
  for select to public using (true);

create policy "leitura publica" on public.skills
  for select to public using (true);

create policy "leitura publica" on public.notas_fontes
  for select to public using (true);

create policy "leitura publica" on public.notas_relacoes
  for select to public using (true);

create policy "leitura publica" on public.historico_versoes
  for select to public using (true);

-- ---- leitura pública com filtro (só linhas "ativas") -------------------------

create policy "leitura publica" on public.notas
  for select to public using (status = 'ativo');

create policy "leitura publica" on public.gabaritos
  for select to public using (ativo);

create policy "leitura publica" on public.regras_sistema
  for select to public using (ativo);

create policy "leitura publica" on public.portao_conformidade_checklist
  for select to public using (ativo);

-- revisao_legado é o único caso com role explícita {anon, authenticated} em vez
-- de "public" — efeito prático idêntico (ambas as roles cobertas), diferença é
-- só de como a policy foi escrita originalmente.
create policy "leitura publica revisao_legado" on public.revisao_legado
  for select to anon, authenticated using (true);

-- ---- restrito a authenticated (só o Jacques) ---------------------------------

create policy "autenticado le tudo" on public.ingestao_jobs
  for select to authenticated using (true);

create policy "autenticado sobe job" on public.ingestao_jobs
  for insert to authenticated with check (true);

create policy "autenticado atualiza job" on public.ingestao_jobs
  for update to authenticated using (true);

create policy "autenticado le revisao" on public.revisao_pendente
  for select to authenticated using (true);

create policy "autenticado decide revisao" on public.revisao_pendente
  for update to authenticated using (true);

create policy "autenticado le comentarios" on public.comentarios_revisao
  for select to authenticated using (true);

create policy "autenticado comenta" on public.comentarios_revisao
  for insert to authenticated with check (true);

-- ============================================================================
-- Nota de manutenção: em pelo menos duas ocasiões (migração 009/010 e 011/012,
-- 021/022) uma policy de UPDATE temporária foi criada pra role "anon" pra
-- permitir um script de backfill/auditoria rodar com a anon key, e removida
-- logo depois. Isso é um padrão operacional deliberado do projeto (nunca deixar
-- uma policy de escrita aberta pra anon em produção) — ver migracoes.md.
-- ============================================================================
