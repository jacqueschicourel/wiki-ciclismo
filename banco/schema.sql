-- ============================================================================
-- LRF — schema completo do banco (Supabase / Postgres)
-- Projeto: ojftdbogrkfbceqnwjih
-- Gerado a partir do estado VIVO do banco em 2026-08-07 (via list_tables/execute_sql),
-- não reconstruído a partir de arquivos locais — reflete o schema real em produção,
-- incluindo mudanças aplicadas direto via migração (ex.: fontes/relacionadas em notas).
--
-- Este arquivo é documentação/reprodução do schema, não um script de migração
-- incremental — para o histórico real de como o schema evoluiu, ver migracoes.md.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. TAXONOMIA — tabelas de referência (domínios, camadas, aplicações, tipos)
-- ----------------------------------------------------------------------------

create table public.taxonomia_dominios (
  slug        text primary key,
  nome        text not null,
  descricao   text,
  ordem       integer not null default 0,
  ativo       boolean not null default true
);

create table public.taxonomia_camadas (
  slug  text primary key,
  nome  text not null,
  ordem integer not null default 0
);

create table public.taxonomia_aplicacoes (
  slug      text primary key,
  nome      text not null,
  descricao text
);

create table public.taxonomia_tipos_nota (
  slug      text primary key,
  nome      text not null,
  descricao text
);

create table public.taxonomia_tipos_skill (
  slug      text primary key,
  nome      text not null,
  descricao text
);

create table public.taxonomia_sinais_strava (
  slug      text primary key,
  nome      text not null,
  categoria text,
  descricao text
);

-- ----------------------------------------------------------------------------
-- 2. GOVERNANÇA — regras do sistema, gabaritos, portão de conformidade
-- ----------------------------------------------------------------------------

create table public.regras_sistema (
  id        uuid primary key default gen_random_uuid(),
  chave     text not null unique,
  titulo    text not null,
  conteudo  text not null,
  versao    integer not null default 1,
  ativo     boolean not null default true,
  criado_em timestamptz not null default now()
);

create table public.gabaritos (
  id                   uuid primary key default gen_random_uuid(),
  tipo_nota_slug       text not null references public.taxonomia_tipos_nota(slug),
  nome_exemplar        text not null,
  conteudo_completo    text not null,
  campos_obrigatorios  jsonb not null default '[]'::jsonb,
  versao               integer not null default 1,
  ativo                boolean not null default true,
  criado_em            timestamptz not null default now()
);

create table public.portao_conformidade_checklist (
  id         uuid primary key default gen_random_uuid(),
  ordem      integer not null,
  descricao  text not null,
  aplica_a   text not null default 'todas',
  ativo      boolean not null default true
);

-- ----------------------------------------------------------------------------
-- 3. CONTEÚDO DO CÂNONE — notas e skills
-- ----------------------------------------------------------------------------

create table public.notas (
  id            text primary key,
  titulo        text not null,
  dominio_slug  text not null references public.taxonomia_dominios(slug),
  aplicacao_slug text not null references public.taxonomia_aplicacoes(slug),
  tipo_nota_slug text not null references public.taxonomia_tipos_nota(slug),
  camadas       text[] not null default '{}',
  sinais        text[] not null default '{}',
  confianca     numeric check (confianca >= 0 and confianca <= 1),
  status        text not null default 'ativo' check (status = any (array['ativo','revisar'])),
  corpo         text not null,
  -- colunas adicionadas na migração 020 (2026-08-07) — antes só existiam no frontmatter local:
  fontes        jsonb, -- citação exata da fonte primária (arquivo/página/trecho), migrada 1x do .md local
  relacionadas  text[], -- lista de nota-XXXX relacionadas, migrada 1x do .md local
  criado_em     timestamptz not null default now(),
  atualizado_em timestamptz not null default now()
);
comment on column public.notas.fontes is 'Citação exata da fonte primária (arquivo/página/trecho), migrada do frontmatter local dos .md — não recalculada, só carregada 1x por migrar_fontes_relacionadas_supabase.py.';
comment on column public.notas.relacionadas is 'Lista de nota-XXXX relacionadas, migrada do frontmatter local dos .md.';

-- nota: fontes/relacionadas também existem normalizadas nas duas tabelas abaixo
-- (notas_fontes / notas_relacoes) — usadas pelo app interativo para joins e pela
-- trigger promover_revisao_aprovada() ao promover uma revisão aprovada. As colunas
-- jsonb/array em notas são uma cópia de conveniência para leitura direta (ex.: via
-- execute_sql sem join), carregada pela migração 020/021.

create table public.notas_fontes (
  id      uuid primary key default gen_random_uuid(),
  nota_id text not null references public.notas(id),
  arquivo text not null,
  pagina  text,
  trecho  text
);

create table public.notas_relacoes (
  id              uuid primary key default gen_random_uuid(),
  nota_origem_id  text not null references public.notas(id),
  nota_destino_id text not null references public.notas(id),
  tipo            text not null,
  justificativa   text
);

create table public.skills (
  id                      text primary key,
  numero                  text unique,
  titulo                  text not null,
  dominio_slug            text not null references public.taxonomia_dominios(slug),
  tipo_skill_slug         text references public.taxonomia_tipos_skill(slug),
  notas_usadas            text[] not null default '{}',
  confianca_herdada       text,
  condicao_nao_calculavel text,
  dados_necessarios       jsonb not null default '[]'::jsonb,
  skills_relacionadas     jsonb not null default '[]'::jsonb,
  log_de_teste            jsonb not null default '[]'::jsonb,
  status                  text not null default 'proposto'
                            check (status = any (array['proposto','validado_com_ressalvas','validado','descontinuado'])),
  corpo                   text not null,
  criado_em               timestamptz not null default now(),
  atualizado_em           timestamptz not null default now()
);

create table public.historico_versoes (
  id                 uuid primary key default gen_random_uuid(),
  entidade_tipo      text not null check (entidade_tipo = any (array['nota','skill','regra_sistema'])),
  entidade_id        text not null,
  versao             integer not null,
  conteudo_snapshot  jsonb not null,
  motivo             text,
  alterado_por       text not null default 'sistema',
  alterado_em        timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 4. ESTEIRA DE INGESTÃO — upload de fonte nova, extração, fila de revisão
-- ----------------------------------------------------------------------------

create table public.ingestao_jobs (
  id                    uuid primary key default gen_random_uuid(),
  arquivo_nome          text not null,
  arquivo_storage_path  text not null,
  status                text not null default 'pendente'
                          check (status = any (array['pendente','processando','aguardando_revisao','concluido','erro'])),
  etapa_atual           text,
  log                   jsonb not null default '[]'::jsonb,
  enviado_por           text not null,
  criado_em             timestamptz not null default now(),
  atualizado_em         timestamptz not null default now()
);

create table public.revisao_pendente (
  id                        uuid primary key default gen_random_uuid(),
  ingestao_job_id           uuid references public.ingestao_jobs(id),
  tipo_item                 text not null check (tipo_item = any (array['nota','skill'])),
  entidade_relacionada_id   text,
  categoria_revisao         text not null
                              check (categoria_revisao = any (array['padrao','baixa_confianca','conflito','modelo_concorrente','categoria_nova'])),
  conteudo_proposto         jsonb not null,
  confianca                 numeric,
  justificativa             text not null,
  status                    text not null default 'pendente' check (status = any (array['pendente','aprovado','reprovado'])),
  decidido_por              text,
  decidido_em               timestamptz,
  criado_em                 timestamptz not null default now()
);

create table public.comentarios_revisao (
  id          uuid primary key default gen_random_uuid(),
  revisao_id  uuid not null references public.revisao_pendente(id),
  autor       text not null,
  comentario  text not null,
  criado_em   timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 5. REVISÃO LEGADA — migração 1x dos 40 arquivos de _revisao/ locais
-- ----------------------------------------------------------------------------

create table public.revisao_legado (
  id        bigint generated always as identity primary key,
  tipo      text not null check (tipo = any (array['baixa-confianca','conflito','modelo-concorrente'])),
  titulo    text not null,
  notas     text[] not null default '{}',
  corpo     text not null,
  confianca numeric,
  criado_em timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 6. STORAGE BUCKETS (ambos privados — acesso só via app autenticado)
-- ----------------------------------------------------------------------------
-- insert into storage.buckets (id, name, public) values ('ingestao', 'ingestao', false);
-- insert into storage.buckets (id, name, public) values ('fontes-ingestao', 'fontes-ingestao', false);
