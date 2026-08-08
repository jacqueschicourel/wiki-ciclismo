BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34022$skill-entrega-curadoria-mensal$m34022$, $m34023$skill-0025$m34023$, $m34024$Curadoria mensal — selecionar o progresso de fase/macro do mês a partir das curadorias semanais, sequenciamento e perfil de potência de longo prazo$m34024$,
  $m34025$entrega-feedback$m34025$, $m34026$curador$m34026$,
  '{}'::text[],
  $m34027$dinâmica = mínimo das confianca_herdada de skill-0022 (0,5), skill-0001, skill-0010 (se usado) e das curadorias semanais (skill-0024) do mês — nunca mais confiável que a peça mais fraca$m34027$, $m34028$sem pelo menos 2-3 curadorias semanais (skill-0024) dentro do mês → o padrão mensal fica pouco sustentável, reportar Ausente para os pontos que dependem de tendência ao longo do mês; ainda assim reportar o que for calculável isoladamente (ex.: fase da temporada declarada, se houver). Sem nenhuma curadoria semanal no mês, reportar só isso como único ponto.$m34028$,
  $m34029$[{"campo": "curadorias_semanais_do_mes", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-entrega-curadoria-semanal rodada nas semanas do mês (idealmente 4, mínimo aceitável 2-3)"}, {"campo": "fase_e_sequenciamento", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-estrutural-fase-e-sequenciamento, se a fase da temporada foi declarada"}, {"campo": "perfil_potencia_longo_prazo", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-perfil-de-potencia-longo-prazo, só calculável com 6+ meses de histórico — na maioria dos meses iniciais do atleta, fica Ausente e a skill segue sem esse ponto"}, {"campo": "evento_alvo_declarado", "tipo": "manual", "obrigatorio": "false", "fonte": "data/tipo do próximo evento-alvo do atleta, se houver, para contextualizar quantas semanas faltam"}]$m34029$::jsonb, $m34030$[{"id": "skill-entrega-curadoria-semanal", "tipo": "pre-requisito"}, {"id": "skill-estrutural-fase-e-sequenciamento", "tipo": "pre-requisito"}, {"id": "skill-gerais-perfil-de-potencia-longo-prazo", "tipo": "pre-requisito"}, {"id": "skill-entrega-redacao-atleta", "tipo": "consumida-por"}]$m34030$::jsonb,
  $m34031$[]$m34031$::jsonb, $m34032$proposto$m34032$, $m34033$## O que faz

Agrega as curadorias semanais (`skill-entrega-curadoria-semanal`) de um mês e seleciona, no máximo, 3-4 pontos sobre o **progresso macro** — fase da temporada, evolução de fitness ao longo do mês, e quantas semanas faltam pro evento-alvo, se declarado. É o nível mais alto de agregação: não fala de sessão nem de semana isolada, fala de tendência.

## Quando usar

- No fechamento mensal do feedback ao atleta (WhatsApp e/ou e-mail).
- Só depois de pelo menos 2-3 semanas do mês já terem passado por `skill-entrega-curadoria-semanal`.

## Passo a passo

1. **Reunir as curadorias semanais** do mês e, se disponível, o output de `skill-estrutural-fase-e-sequenciamento` (fase declarada) e `skill-gerais-perfil-de-potencia-longo-prazo` (só se houver 6+ meses de histórico — na maior parte dos casos iniciais, fica Ausente, o que é esperado e não é erro).
2. **Ler a evolução de CTL ao longo do mês** (via as curadorias semanais, que já trazem CTL início→fim de cada semana) — reportar direção geral (subindo/estável/caindo), nunca comparar números brutos entre semanas muito diferentes sem contexto de fase.
3. **Cruzar com a fase da temporada declarada**, se houver: a carga do mês bateu com o esperado pra fase (construção, especialização, taper, etc.)?
4. **Se houver evento-alvo declarado**, calcular quantas semanas faltam e citar isso como contexto, nunca como pressão.
5. **Se houver perfil de potência de longo prazo calculável**, reportar 1 ponto sobre evolução real de capacidade (ex.: FTP mudou, novo pico de longo prazo) — só quando for um número de fato novo/mudou desde a última leitura, não repetir o mesmo dado todo mês.
6. **Selecionar no máximo 4 pontos**, priorizando: (a) progresso de fase (bateu ou não com o esperado); (b) tendência de fitness ao longo do mês (CTL); (c) contexto de evento-alvo, se houver; (d) evolução de capacidade de longo prazo, só se novo dado disponível.
7. **Nunca repetir pontos já comunicados nas curadorias semanais individuais** — o mês deve somar contexto, não empilhar as mesmas frases 4 vezes.
8. **Checar a condição de não-calculável** (ver frontmatter) antes de devolver a lista.

## Output

```
{
  "mes_referencia": "AAAA-MM",
  "pontos_selecionados": [
    {
      "ordem": <int, 1-4>,
      "categoria": "progresso_fase" | "tendencia_fitness_mes" | "contexto_evento_alvo" | "evolucao_capacidade_longo_prazo",
      "resumo_tecnico": "<1 frase técnica>",
      "fonte_skill": "skill-00XX",
      "fonte_campo": "<campo do output daquela skill, ou 'agregado_curadorias_semanais'>"
    }
  ],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Ausente ou parcial>",
  "notas_citadas": []
}
```$m34033$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;