-- ============================================================================
-- LRF — funções e triggers do banco
-- Extraídas via pg_get_functiondef() / information_schema.triggers em 2026-08-07.
-- ============================================================================

-- promover_revisao_aprovada(): quando uma linha de revisao_pendente muda pra
-- status='aprovado', promove o conteudo_proposto (jsonb) pra uma linha real em
-- notas ou skills (upsert por id), recria as linhas normalizadas em
-- notas_fontes/notas_relacoes quando é uma nota, grava um snapshot em
-- historico_versoes, e fecha o ingestao_job se não sobrar nenhuma revisão
-- pendente daquele job. SECURITY DEFINER porque quem aprova (role authenticated,
-- só o Jacques) não tem policy de INSERT direta em notas/skills — a promoção só
-- acontece através desta função, nunca por escrita direta do cliente.

CREATE OR REPLACE FUNCTION public.promover_revisao_aprovada()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  c jsonb;
  alvo_id text;
begin
  if NEW.status = 'aprovado' and (OLD.status is distinct from 'aprovado') then
    c := NEW.conteudo_proposto;
    alvo_id := coalesce(NEW.entidade_relacionada_id, c->>'id');

    if NEW.tipo_item = 'nota' then
      insert into notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo)
      values (
        alvo_id, c->>'titulo', c->>'dominio', c->>'aplicacao', c->>'tipo_nota',
        coalesce((select array_agg(x) from jsonb_array_elements_text(coalesce(c->'camada','[]'::jsonb)) x), '{}'),
        coalesce((select array_agg(x) from jsonb_array_elements_text(coalesce(c->'sinais','[]'::jsonb)) x), '{}'),
        (c->>'confianca')::numeric,
        coalesce(c->>'status','ativo'),
        c->>'corpo'
      )
      on conflict (id) do update set
        titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug,
        tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais,
        confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();

      delete from notas_fontes where nota_id = alvo_id;
      insert into notas_fontes (nota_id, arquivo, pagina, trecho)
      select alvo_id, f->>'arquivo', f->>'pagina', f->>'trecho'
      from jsonb_array_elements(coalesce(c->'fontes','[]'::jsonb)) f;

      delete from notas_relacoes where nota_origem_id = alvo_id;
      insert into notas_relacoes (nota_origem_id, nota_destino_id, tipo, justificativa)
      select alvo_id, r->>'id', r->>'tipo', r->>'justificativa'
      from jsonb_array_elements(coalesce(c->'relacionadas','[]'::jsonb)) r;

    elsif NEW.tipo_item = 'skill' then
      insert into skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, status, corpo)
      values (
        alvo_id, c->>'numero', c->>'titulo', c->>'dominio', c->>'tipo_skill',
        coalesce((select array_agg(x) from jsonb_array_elements_text(coalesce(c->'notas_usadas','[]'::jsonb)) x), '{}'),
        c->>'confianca_herdada', c->>'condicao_nao_calculavel',
        coalesce(c->'dados_necessarios','[]'::jsonb), coalesce(c->'skills_relacionadas','[]'::jsonb),
        coalesce(c->>'status','proposto'), c->>'corpo'
      )
      on conflict (id) do update set
        numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug,
        tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas,
        confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel,
        dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas,
        status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
    end if;

    insert into historico_versoes (entidade_tipo, entidade_id, versao, conteudo_snapshot, motivo, alterado_por)
    values (NEW.tipo_item, alvo_id, 1, c, 'Promovido via aprovação de revisão de ingestão (job '||NEW.ingestao_job_id||')', coalesce(NEW.decidido_por,'desconhecido'));

    update ingestao_jobs set status = 'concluido', atualizado_em = now()
    where id = NEW.ingestao_job_id
      and not exists (select 1 from revisao_pendente rp where rp.ingestao_job_id = NEW.ingestao_job_id and rp.status = 'pendente');
  end if;
  return NEW;
end;
$function$;

CREATE TRIGGER trg_promover_revisao_aprovada
  AFTER UPDATE ON public.revisao_pendente
  FOR EACH ROW EXECUTE FUNCTION public.promover_revisao_aprovada();
