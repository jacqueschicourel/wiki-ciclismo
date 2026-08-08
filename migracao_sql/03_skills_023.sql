BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m35067$skill-limiar-intervalos-repetibilidade$m35067$, $m35068$skill-0017$m35068$, $m35069$Repetibilidade de intervalos — regra de parada em tempo real (5% do 3º intervalo) vs. avaliação retrospectiva (~10% até o último)$m35069$,
  $m35070$tipos-de-treino$m35070$, $m35071$detector$m35071$,
  ARRAY[$m35072$nota-0017$m35072$, $m35073$nota-0040$m35073$, $m35074$nota-0054$m35074$]::text[],
  $m35075$0.7$m35075$, $m35076$sem marcações de lap na atividade → Potência-por-lap (Calc#15) não é calculável, toda a skill fica Ausente. Séries com menos de 3 intervalos completos → a regra de parada baseada no 3º intervalo (nota-0040) não é aplicável; reportar Ausente para esse eixo, mas a comparação retrospectiva 2º/último (nota-0054) ainda pode ser tentada se houver pelo menos 2 intervalos. A regra de descarte dos 2 primeiros esforços (nota-0040) não se aplica da mesma forma a intervalos muito longos (poucas repetições totais) nem a atletas muito experientes que já conhecem sua potência sustentável de saída — sinalizar isso como contexto, não aplicar cegamente.$m35076$,
  $m35077$[{"campo": "marcacoes_lap", "tipo": "bruto", "obrigatorio": "true", "fonte": "laps marcados manualmente na atividade (Calc#15)", "observacao": "sem isso, toda a skill fica Ausente"}, {"campo": "numero_intervalos_completos", "tipo": "calculado", "obrigatorio": "false", "fonte": "derivado das marcações de lap", "observacao": "regra de parada em tempo real exige ≥3 intervalos"}]$m35077$::jsonb, $m35078$[{"id": "skill-classificacao-tipo-de-sessao", "tipo": "pre-requisito"}, {"id": "skill-limiar-calibracao-rpe", "tipo": "complementar"}]$m35078$::jsonb,
  $m35079$[]$m35079$::jsonb, $m35080$proposto$m35080$, $m35081$## O que faz

Avalia a repetibilidade de uma série de intervalos marcados por lap, sob dois critérios distintos do cânone que **não foram reconciliados entre si**: um critério prescritivo para decidir em tempo real quando parar a série (3º intervalo como referência "repetível", parar quando a potência cair 5% abaixo dele), e um critério retrospectivo para avaliar, depois da sessão concluída, o quanto a potência efetivamente caiu (comparando o 2º/3º intervalo com o último, usando um limiar de referência de ~10%). Esta skill relata os dois separadamente, nunca escolhendo um só silenciosamente.

## Quando usar

- Ao avaliar, durante ou logo após uma sessão de intervalos repetidos (ex.: 5×5min, 8×2min), se a série foi bem dimensionada.
- Ao gerar feedback pós-treino explicando se o atleta poderia ter feito mais ou menos repetições.
- Nunca aplicar isoladamente sem declarar qual dos dois critérios (5% prescritivo ou 10% retrospectivo) está sendo usado.

## Passo a passo

1. **Calcular a potência-por-lap** de cada intervalo marcado da série, usando as marcações de lap da atividade (nota-0017).
2. **Aplicar a regra de parada em tempo real (prescritiva)**: descartar os 2 primeiros intervalos (o atleta está fresco, não é uma potência repetível ao longo da série); usar a potência média do **3º intervalo completo** como referência; `potência_de_parada = potência_3º_intervalo × 0,95`. Identificar em que ponto da série (se houver) a potência de um intervalo caiu abaixo desse piso — esse seria o ponto correto de parada segundo o critério prescritivo (nota-0040).
3. **Nuance de aplicabilidade**: esta regra vale principalmente para intervalos de até ~3min; para intervalos muito longos com só 2 repetições totais, ou para atletas muito experientes que já sabem de saída sua potência sustentável, não aplicar cegamente — sinalizar como contexto que reduz a confiança da leitura (nota-0040).
4. **Aplicar a avaliação retrospectiva**: comparar a potência do 2º ou 3º intervalo (referência, não o 1º) com a potência do **último** intervalo da série, calculando a queda percentual real observada ao longo de toda a sessão (nota-0054).
5. **Reportar a divergência explicitamente**: nunca escolher um só dos dois critérios (5% ou 10%) como "o" critério — relatar ambos os resultados lado a lado, identificados por nome (parada-em-tempo-real vs. avaliação-retrospectiva), e mencionar que o cânone não resolve essa divergência (nota-0054, status "revisar").
6. **Concluir**: se a queda real observada (passo 4) for menor que ambos os limiares, a série provavelmente poderia ter tido mais repetições; se exceder claramente os dois, a série foi bem dimensionada ou até poderia ter parado antes; se cair entre os dois limiares (entre 5% e 10%), reportar como uma zona ambígua sem veredito forte, dada a divergência não resolvida do cânone.
7. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer veredito.

## Output

```
{
  "intervalos_w": [<float>],
  "potencia_3o_intervalo_w": <float, null>,
  "piso_parada_tempo_real_w": <float, null>,
  "intervalo_onde_cruzou_piso_5pct": <int, null>,
  "potencia_referencia_retrospectiva_w": <float, null>,
  "potencia_ultimo_intervalo_w": <float, null>,
  "queda_retrospectiva_pct": <float, null>,
  "veredito": "poderia_ter_mais_repeticoes" | "bem_dimensionada" | "zona_ambigua_5_a_10pct" | "nao_calculavel",
  "alertas": ["menos_de_3_intervalos_regra_nao_aplicavel" | "divergencia_5_vs_10_pct_nao_resolvida_no_canone" | null],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0017", "nota-0040", "nota-0054"]
}
```$m35081$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;