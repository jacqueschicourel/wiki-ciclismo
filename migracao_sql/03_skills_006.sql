BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34058$skill-entrega-curadoria-semanal$m34058$, $m34059$skill-0024$m34059$, $m34060$Curadoria semanal — selecionar o padrão/tendência da semana (não sessão isolada) a partir das análises diárias e do PMC$m34060$,
  $m34061$entrega-feedback$m34061$, $m34062$curador$m34062$,
  '{}'::text[],
  $m34063$dinâmica = mínimo das confianca_herdada de skill-0001 (0,65), skill-0013, skill-0015 e das curadorias diárias (skill-0023) dos dias efetivamente usados — nunca mais confiável que a peça mais fraca da semana$m34063$, $m34064$sem TSS diário coletado para pelo menos a maioria dos dias da janela (idealmente os 7, mínimo aceitável 4-5 com atividade) → CTL/ATL/TSB da semana (skill-0001) fica pouco confiável, reportar Ausente para os pontos que dependem disso. Mesmo assim, pontos que só dependem das curadorias diárias já geradas (ex.: quantas sessões de qualidade teve) continuam calculáveis e devem ser reportados. Sem nenhuma sessão registrada na semana, reportar só isso como único ponto.$m34064$,
  $m34065$[{"campo": "curadorias_diarias_da_semana", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-entrega-curadoria-diaria rodada em cada sessão da janela (0 a 7 sessões)"}, {"campo": "pmc_da_semana", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-pmc (CTL/ATL/TSB) para a janela, incluindo tendência de TSB e ramp rate"}, {"campo": "classificacao_semana_recuperacao", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-classificacao-semana-recuperacao, se esta semana foi planejada como recuperação"}, {"campo": "semana_anterior_resumo", "tipo": "manual", "obrigatorio": "false", "fonte": "resumo curado da semana imediatamente anterior, para comparação de carga", "observacao": "sem isso, a skill não compara com a semana passada, só reporta a semana atual isoladamente"}]$m34065$::jsonb, $m34066$[{"id": "skill-entrega-curadoria-diaria", "tipo": "pre-requisito"}, {"id": "skill-gerais-pmc", "tipo": "pre-requisito"}, {"id": "skill-gerais-fadiga-carga-avancada", "tipo": "pre-requisito"}, {"id": "skill-classificacao-semana-recuperacao", "tipo": "pre-requisito"}, {"id": "skill-entrega-redacao-atleta", "tipo": "consumida-por"}]$m34066$::jsonb,
  $m34067$[]$m34067$::jsonb, $m34068$proposto$m34068$, $m34069$## O que faz

Agrega as curadorias diárias (`skill-entrega-curadoria-diaria`) e o PMC (`skill-gerais-pmc`) de uma janela de ~7 dias e seleciona, no máximo, 3-4 pontos sobre o **padrão da semana** — nunca repetindo o que já foi dito sessão a sessão. Responde perguntas do tipo "como foi minha semana", não "como foi meu treino de terça".

## Quando usar

- No fechamento semanal do feedback ao atleta (WhatsApp e/ou e-mail).
- Nunca antes de pelo menos 1 sessão da semana já ter passado por `skill-entrega-curadoria-diaria`.

## Passo a passo

1. **Reunir as curadorias diárias** de todas as sessões da semana e, se disponível, o output de `skill-gerais-pmc` para a janela (CTL início→fim, TSB início→fim, ramp rate, alertas de overreaching).
2. **Calcular a tendência de forma**: CTL subiu/manteve/caiu, TSB no fim da semana (e se está subindo ou descendo — nunca só o valor absoluto, nota-0094 via skill-0001).
3. **Contar o perfil de treino da semana**: quantas sessões foram "qualidade" (limiar/VO2máx/anaeróbio, via `tipo_sessao_provavel` de cada dia) vs. quantas foram base/recuperação/regenerativa.
4. **Checar se era semana de recuperação planejada** (`skill-classificacao-semana-recuperacao`) e se o teto de carga foi respeitado.
5. **Comparar com a semana anterior**, se o resumo dela estiver disponível — mais carga, menos carga, ou estável.
6. **Selecionar no máximo 4 pontos**, priorizando: (a) qualquer alerta de ramp rate/overreaching da semana, sempre em 1º; (b) 1 ponto sobre tendência de forma (CTL/TSB); (c) 1 ponto sobre o perfil de treino (quantidade/qualidade de sessões); (d) 1 ponto de comparação com a semana anterior, só se relevante.
7. **Nunca repetir um ponto já comunicado em uma curadoria diária individual da mesma semana** — o objetivo é agregar, não somar.
8. **Checar a condição de não-calculável** (ver frontmatter) antes de devolver a lista.

## Output

```
{
  "janela_referencia": {"inicio": "AAAA-MM-DD", "fim": "AAAA-MM-DD"},
  "pontos_selecionados": [
    {
      "ordem": <int, 1-4>,
      "categoria": "alerta_carga" | "tendencia_forma" | "perfil_treino" | "comparacao_semana_anterior",
      "resumo_tecnico": "<1 frase técnica>",
      "fonte_skill": "skill-00XX",
      "fonte_campo": "<campo do output daquela skill, ou 'agregado_curadorias_diarias'>"
    }
  ],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Ausente ou parcial>",
  "notas_citadas": []
}
```$m34069$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;