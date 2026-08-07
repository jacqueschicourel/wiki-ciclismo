# Histórico de migrações — projeto Supabase `ojftdbogrkfbceqnwjih`

Lista completa das 22 migrações aplicadas até 2026-08-07, extraída diretamente do banco (`list_migrations`). O `schema.sql` e `rls_policies.sql` deste diretório representam o **resultado final** de aplicar todas elas em sequência — este arquivo é o changelog.

| # | Versão | Nome | O que fez |
|---|---|---|---|
| 1 | 20260805233204 | `001_taxonomia_e_metodologia` | Cria as tabelas de taxonomia (domínios, camadas, aplicações, tipos de nota/skill, sinais Strava). |
| 2 | 20260805233211 | `002_gabaritos_e_portao_conformidade` | Cria `gabaritos` e `portao_conformidade_checklist`. |
| 3 | 20260805233218 | `003_conteudo_notas` | Cria a tabela `notas`. |
| 4 | 20260805233231 | `004_conteudo_skills` | Cria a tabela `skills`. |
| 5 | 20260805233236 | `005_historico_versoes` | Cria `historico_versoes` (snapshot de cada promoção de conteúdo). |
| 6 | 20260805233246 | `006_esteira_ingestao` | Cria `ingestao_jobs`, `revisao_pendente`, `comentarios_revisao` — a fila de upload/extração/revisão. |
| 7 | 20260805233304 | `007_rls_policies` | Ativa RLS e cria as policies de leitura pública / restrito a `authenticated` em todas as tabelas. |
| 8 | 20260805233419 | `008_corrige_dominio_skill_reusa_taxonomia_dominios` | Corrige `skills.dominio_slug` para referenciar `taxonomia_dominios` (mesma taxonomia de notas, não uma tabela própria). |
| 9 | 20260805235208 | `009_policy_temporaria_migracao_conteudo` | Policy temporária de INSERT/UPDATE para `anon`, usada só para o backfill inicial de 291 notas + 26 skills. |
| 10 | 20260806001758 | `010_remove_policy_temporaria_migracao` | Remove a policy da migração 009 (limpeza pós-backfill). |
| 11 | 20260806002419 | `011_policy_temp_auditoria_leitura` | Policy temporária de leitura ampliada, usada na auditoria campo-a-campo DB vs. arquivos locais. |
| 12 | 20260806003257 | `012_remove_policy_temp_auditoria` | Remove a policy da migração 011. |
| 13 | 20260806004125 | `013_revisao_legado` | Cria `revisao_legado` e migra os 40 arquivos de `_revisao/` locais. |
| 14 | 20260806004242 | `014_storage_bucket_ingestao` | Cria os buckets privados `ingestao` e `fontes-ingestao`. |
| 15 | 20260806010449 | `015_remove_policy_temp_revisao_legado` | Remove uma policy temporária usada durante a migração de `revisao_legado`. |
| 16 | 20260806013333 | `016b_unique_chave_regras_sistema` | Adiciona constraint `unique` em `regras_sistema.chave`. |
| 17 | 20260806013340 | `016c_regra_verificacao_redundancia_ingestao` | Ajuste de regra de sistema relacionada à checagem de redundância na esteira de ingestão. |
| 18 | 20260806013357 | `017_promover_revisao_aprovada` | Cria a função `promover_revisao_aprovada()` e o trigger `trg_promover_revisao_aprovada` — o mecanismo que promove `revisao_pendente` aprovada para `notas`/`skills`. |
| 19 | 20260806013412 | `018_revoga_rpc_publico_trigger_promocao` | Fecha uma via de chamada pública da lógica de promoção — só o trigger (disparado por UPDATE autenticado) pode promover, não uma RPC exposta. |
| 20 | 20260806014940 | `019b_remove_storage_policies_nao_usadas` | Limpeza de policies de storage que não chegaram a ser usadas. |
| 21 | 20260807094955 | `020_add_fontes_relacionadas_notas` | Adiciona as colunas `fontes` (jsonb) e `relacionadas` (text[]) em `notas` — antes só existiam no frontmatter local dos `.md`. |
| 22 | 20260807094957 | `021_policy_temp_update_fontes_relacionadas` | Policy temporária de UPDATE para `anon`, usada pelo script `migrar_fontes_relacionadas_supabase.py` para popular as colunas da migração 020. |
| — | 20260807095920 | `022_remove_policy_temp_update_fontes_relacionadas` | Remove a policy da migração 021 (limpeza pós-backfill). |

## Padrão recorrente: policy temporária + limpeza

Cinco das 22 migrações (009/010, 011/012, 015, 021/022) seguem o mesmo padrão: abrir uma policy de escrita/leitura ampliada só para `anon` pelo tempo de um script de backfill ou auditoria específico, e fechá-la logo em seguida. É uma decisão operacional deliberada do projeto — nunca deixar uma policy de escrita aberta para `anon` em produção — não um descuido. Qualquer nova migração desse tipo deveria seguir o mesmo par (abre → roda o script → fecha), documentado aqui.

## Como reproduzir o schema do zero

```sql
-- na ordem: schema.sql → rls_policies.sql → funcoes_triggers.sql
\i schema.sql
\i rls_policies.sql
\i funcoes_triggers.sql
```

O conteúdo (291 notas, 26 skills, taxonomia, gabaritos, regras) não está neste diretório — ele vive no banco e nos arquivos locais `G:\Meu Drive\LRF\notas\` / `G:\Meu Drive\LRF\skills\`, que são a fonte editável. Ver `README.md` para o fluxo completo.
