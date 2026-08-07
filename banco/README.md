# Banco de dados do projeto LRF

Documentação do backend Supabase que alimenta a wiki interativa (`../app.html`) e serve como fonte auditável (com `md5()`/timestamp de servidor) para as análises de treino do cânone de ciclismo.

- **Projeto Supabase**: `ojftdbogrkfbceqnwjih`
- **URL**: `https://ojftdbogrkfbceqnwjih.supabase.co`
- **Documentado em**: 2026-08-07, a partir do estado vivo do banco (não dos arquivos locais — ver ressalva abaixo)

## Por que existe um banco, se o conteúdo já vive em arquivos `.md` locais?

O cânone (291 notas + 26 skills) nasceu como arquivos Markdown em `G:\Meu Drive\LRF\notas\` e `G:\Meu Drive\LRF\skills\`, e continua sendo a fonte editável primária. O banco existe por dois motivos:

1. **Prova de origem auditável.** Uma análise de treino pode citar `md5(corpo)` + timestamp de servidor de cada skill/nota usada, permitindo qualquer pessoa conferir de forma independente (rodando a mesma query) que o conteúdo citado é exatamente o que está em produção — algo que um arquivo local não oferece.
2. **App interativo.** `app.html` (upload de fonte nova, fila de extração/revisão, login) precisa de um backend real com controle de acesso — RLS resolve isso de um jeito que arquivos estáticos não resolvem.

Local continua sendo mais rápido para análise do dia a dia (ver comparação de tempo em `../analises/`); o banco é para quando o que importa é a prova de origem, não a velocidade.

## Arquivos deste diretório

| Arquivo | Conteúdo |
|---|---|
| `schema.sql` | `CREATE TABLE` das 16 tabelas, com colunas/tipos/defaults/checks/PKs/FKs |
| `rls_policies.sql` | As 22 políticas RLS ativas, com o modelo de segurança explicado |
| `funcoes_triggers.sql` | A função `promover_revisao_aprovada()` e o trigger que a dispara |
| `migracoes.md` | Changelog das 22 migrações aplicadas, na ordem |

## Visão geral das tabelas (16, todas com RLS habilitado)

**Taxonomia** (6 tabelas de referência, só leitura pública): `taxonomia_dominios`, `taxonomia_camadas`, `taxonomia_aplicacoes`, `taxonomia_tipos_nota`, `taxonomia_tipos_skill`, `taxonomia_sinais_strava`.

**Governança**: `regras_sistema` (16 linhas — as regras do `instrucoes.md` operacionalizadas), `gabaritos` (4 — exemplares de referência por tipo de nota), `portao_conformidade_checklist` (5 — checklist de conformidade).

**Conteúdo do cânone**: `notas` (291 linhas), `notas_fontes` (527 — citações normalizadas), `notas_relacoes` (323 — links entre notas), `skills` (26), `historico_versoes` (snapshot de cada promoção).

**Esteira de ingestão** (upload → extração → revisão → promoção): `ingestao_jobs`, `revisao_pendente`, `comentarios_revisao`.

**Legado**: `revisao_legado` (40 — os antigos arquivos `_revisao/*.md`, migrados 1x, somente leitura).

**Storage**: dois buckets privados, `ingestao` e `fontes-ingestao` (arquivos fonte enviados via app, nunca públicos).

## Modelo de segurança

Duas categorias, sem meio-termo:

- **Leitura pública** (`role public`/`anon`): todo o conteúdo do cânone (notas com `status='ativo'`, skills, taxonomia, gabaritos, regras ativas, histórico, revisão legada). A wiki estática e o app funcionam sem login para consulta.
- **Restrito a `authenticated`**: a esteira de ingestão inteira (`ingestao_jobs`, `revisao_pendente`, `comentarios_revisao`). Só o Jacques tem conta neste projeto Supabase — não há cadastro público.

**Não existe policy de INSERT/UPDATE direta em `notas` ou `skills`.** A única forma de conteúdo novo entrar nessas tabelas é via a trigger `promover_revisao_aprovada()` (`SECURITY DEFINER`), disparada quando uma linha de `revisao_pendente` muda para `status='aprovado'` por um usuário autenticado. Isso significa que mesmo com a conta do Jacques comprometida, não dá para escrever em `notas`/`skills` sem passar pelo fluxo de revisão — a promoção é sempre uma consequência de um UPDATE em `revisao_pendente`, nunca um INSERT direto.

A `anon key` usada em `app.html` e nos scripts Python de migração **é segura para expor publicamente** — é o design do Supabase: a chave não concede nada por si só, quem protege os dados é a RLS descrita acima. Nenhum `service_role key` (que bypassa RLS inteiramente) aparece em nenhum arquivo deste projeto — confirmado por busca antes de preparar este commit.

## Como os arquivos locais e o banco ficam consistentes

Não há sincronização automática/bidirecional. O fluxo real, hoje, é:

1. Conteúdo novo/editado é escrito primeiro nos arquivos `.md` locais (é onde a edição humana acontece).
2. Um script de migração pontual (`migrar_para_supabase.py`, `migrar_direto_supabase.py`, ou o mais recente `migrar_fontes_relacionadas_supabase.py`) reaproveita o parser de `gerar_wiki.py` (`coletar_notas()`) e faz o backfill via `execute_sql` ou REST.
3. A partir da esteira de ingestão (upload → extração → fila de revisão → aprovação), o caminho é outro: o conteúdo nasce direto no banco via `promover_revisao_aprovada()`, e precisaria ser exportado de volta para `.md` manualmente se o Jacques quiser manter os arquivos locais como espelho — isso **ainda não está automatizado** (ver limitação abaixo).

## Limitações conhecidas, registradas para não se perderem

- **Divergência pontual de `status`**: pelo menos `nota-0009` tem `status: auto-aprovado` no arquivo local e `status: ativo` no banco — vocabulário não reconciliado entre os dois lados (achado durante comparação local-vs-banco em 2026-08-06, não corrigido ainda).
- **Sem exportação banco→local automatizada**: conteúdo promovido pela esteira de ingestão fica só no banco até alguém decidir espelhar em `.md` manualmente.
- **`corpo` não inclui frontmatter**: ao contrário do arquivo `.md` (que tem tudo num só `Read`), a coluna `corpo` de `notas`/`skills` é só o texto — `confianca_herdada`, `condicao_nao_calculavel`, `dados_necessarios`, `status`, `notas_usadas`, `log_de_teste` são colunas separadas. Uma query que seleciona só `id, corpo` (otimização comum para reduzir payload) vem incompleta em relação ao que um `Read` local traria de graça — checar se os campos extras são necessários antes de restringir as colunas da query.
- **RLS + anon UPDATE, comportamento não totalmente explicado**: durante o backfill da migração 020/021, 33 das 291 notas falharam silenciosamente em atualizar via `PATCH` com a `anon key`, mesmo com a policy temporária usando `using(true)` (incondicional). As 33 correspondiam exatamente às notas com `status <> 'ativo'`. Contornado aplicando o UPDATE via `execute_sql` (privilegiado, bypassa RLS), mas a causa raiz não foi confirmada — revisitar se o padrão se repetir.

## Reproduzindo o schema do zero

Ver `migracoes.md` → seção "Como reproduzir o schema do zero".
