BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34684$skill-gerais-pmc$m34684$, $m34685$skill-0001$m34685$, $m34686$Performance Manager Chart (CTL/ATL/TSB) — cálculo e leitura de forma$m34686$,
  $m34687$metricas-de-potencia$m34687$, $m34688$calculadora+detector$m34688$,
  ARRAY[$m34689$nota-0062$m34689$, $m34690$nota-0083$m34690$, $m34691$nota-0084$m34691$, $m34692$nota-0085$m34692$, $m34693$nota-0087$m34693$, $m34694$nota-0090$m34694$, $m34695$nota-0092$m34695$, $m34696$nota-0094$m34696$, $m34697$nota-0091$m34697$]::text[],
  $m34698$0.65$m34698$, $m34699$histórico de TSS diário com menos de 42 dias de profundidade → CTL enviesado pelo efeito de 'warm-up' do EWMA (a série ainda não convergiu); reportar CTL/TSB como Estimado com essa ressalva explícita, nunca como Medido. Sem FTP válido no perfil do atleta, TSS não pode ser calculado (pré-requisito de tudo aqui) → toda a skill fica Ausente.$m34699$,
  $m34700$[{"campo": "tss_diario_serie", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-tss-sessao (TSS de cada sessão, somado por dia; dias sem atividade = 0)"}, {"campo": "evento_alvo_declarado", "tipo": "manual", "obrigatorio": "false", "fonte": "declarado pelo atleta (duração/tipo do evento-alvo, para ajustar a constante do ATL)", "observacao": "sem isso, assume padrão de 7 dias e sinaliza a suposição"}, {"campo": "profundidade_historico_tss", "tipo": "bruto", "obrigatorio": "true", "fonte": "contagem de dias com TSS disponível no histórico do atleta", "observacao": "menos de 42 dias produz viés de warm-up do EWMA — ver condicao_nao_calculavel"}]$m34700$::jsonb, $m34701$[{"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-classificacao-semana-recuperacao", "tipo": "consumida-por"}, {"id": "skill-estrutural-fase-e-sequenciamento", "tipo": "consumida-por"}, {"id": "skill-estrutural-taper", "tipo": "consumida-por"}, {"id": "skill-gerais-fadiga-carga-avancada", "tipo": "consumida-por"}]$m34701$::jsonb,
  $m34702$[{"data": "2026-07-19", "caso": "43 dias reais (2026-05-17 a 2026-06-28) do Jacques, de Base de treinamento/activities.csv (dado bruto do export Strava), até a Letape Serra Negra", "resultado": "CTL/ATL/TSB calculados dia a dia (ver exemplos/exemplo-02-dado-real-serra-negra.md). TSB véspera da prova (06-27) = -8,45, com tendência de subida nos 5 dias anteriores (taper) — bate com o padrão da nota-0094. Ramp rate disparou alerta numa única semana (05-31→06-07, +13,24 TSS/dia/semana), autocorrigido pela semana de descanso seguinte — overreaching (nota-0092) corretamente não disparou.", "veredito": "Mecânica do EWMA e dos detectores confirmada com dado real. Duas ressalvas pendentes: (1) NP foi aproximado pela potência média da atividade — não o algoritmo exato de 30s/^4/média/raiz-4ª da nota-0059 — porque o sandbox desta sessão não teve acesso à pasta do projeto para decodificar os .fit.gz brutos nem ao MCP do Strava sem estourar limite de tokens; isso subestima a TSS em pedaladas de esforço variável (ex.: Serra Negra tem descidas longas quase sem pedalar). (2) 43 dias é o mínimo exigido pela condicao_nao_calculavel, mas ainda insuficiente para o EWMA convergir plenamente (precisa de vários múltiplos de 42 dias) — CTL0=ATL0=0 no início da série ainda produz viés de warm-up. Reabrir esta skill para 'validado' pleno quando (a) houver acesso a .fit.gz bruto decodificado ou export com potência por segundo, e (b) houver ≥90-120 dias de histórico real."}]$m34702$::jsonb, $m34703$validado_com_ressalvas$m34703$, $m34704$## O que faz

Calcula a série de CTL (fitness crônica), ATL (fadiga aguda) e TSB (forma = fitness − fadiga) do atleta a partir do histórico diário de TSS, e interpreta essa série contra 4 regras do cânone: taxa de subida segura do CTL (ramp rate), risco de overreaching não funcional, se o TSB precisa ser positivo ou só estar subindo, e se a constante de tempo padrão do ATL (7 dias) deveria ser ajustada para o evento-alvo do atleta.

Não inventa nem estima TSS — assume que a série diária de TSS já foi calculada por `skill-gerais-tss-sessao` (nota-0062) a partir de potência bruta. Esta skill só aplica o EWMA e as regras de leitura em cima dela.

## Quando usar

- Sempre que houver TSS diário de pelo menos os 42 dias anteriores à data de referência (feedback diário/semanal/mensal).
- Antes de qualquer skill de `por-tipo-de-treino/` ou `classificacao/` que dependa de saber se o atleta está fresco, fadigado ou em risco de overreaching — esta é uma skill de `gerais/`, roda antes e alimenta as demais.
- Ao avaliar prontidão para prova/teste (cruzar tendência do TSB, não só o valor absoluto — nota-0094; e calibrar o TSB-alvo esperado pelo tipo/duração do evento — nota-0091, detalhado em skill-gerais-fadiga-carga-avancada).
- Ao decidir se uma semana de treino pesado está dentro de uma taxa de progressão segura (nota-0090).

## Passo a passo

1. **Reunir a série de TSS diário.** Pré-requisito de `skill-gerais-tss-sessao`. Dias sem atividade = TSS 0 (não pular dias — o EWMA precisa da série contínua para não distorcer a constante de tempo).
2. **Definir a constante de tempo do ATL.** Padrão = 7 dias (nota-0084). Se o atleta tiver um evento-alvo declarado: evento curto/explosivo (pista, subidas curtas) → 10-14 dias; evento longo/aeróbio (maratona MTB) → 3-5 dias (nota-0087). Sem evento-alvo declarado, manter o padrão de 7 e sinalizar a suposição.
3. **Calcular CTL do dia:** `CTL_hoje = CTL_ontem + (TSS_hoje − CTL_ontem) × (1 − e^(−1/42))` (nota-0083). Constante de suavização: `λ_CTL = 1 − e^(−1/42) ≈ 0,023528` (corrigido em 2026-08-02, achado de auditoria adversarial — valor anterior, 0,023546, tinha erro no 4º dígito decimal; sempre calcular via a fórmula, esta constante é só auxílio de memória, nunca decorada no lugar do cálculo real).
4. **Calcular ATL do dia:** `ATL_hoje = ATL_ontem + (TSS_hoje − ATL_ontem) × (1 − e^(−1/τ))`, onde τ é a constante definida no passo 2 (nota-0084). Para τ=7: `λ_ATL ≈ 0,133122`.
5. **Calcular TSB do dia:** `TSB = CTL − ATL` (nota-0085).
6. **Aplicar os detectores de leitura:**
   - Ramp rate: taxa de variação do CTL nas últimas 1-4 semanas vs. tabela de referência por idade de treino/CTL atual (nota-0090). Sinalizar se > 7 TSS/dia/semana por mais de 4 semanas seguidas.
   - Overreaching: TSB fortemente negativo e não retornando à neutralidade por período prolongado (nota-0092).
   - Tendência de TSB: reportar a direção (subindo/caindo) dos últimos 3-7 dias, não só o valor do dia (nota-0094) — TSB negativo mas subindo pode ser tão favorável quanto positivo, dependendo do evento.
   - TSB-alvo por tipo de evento: se houver evento-alvo declarado, sinalizar que o TSB "ideal" no dia da prova varia por duração/tipo (curto/anaeróbio → TSB bem positivo; longo/aeróbio → TSB neutro/levemente negativo é tolerável, nota-0091, status "revisar" — tratar como heurística qualitativa, não limiar numérico rígido). Esta skill apenas sinaliza a existência da calibração; a leitura completa é feita por `skill-gerais-fadiga-carga-avancada`.
7. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer número como Medido/Estimado.

## Output

```
{
  "data_referencia": "AAAA-MM-DD",
  "ctl": <float>,
  "atl": <float, constante_usada: 7|10-14|3-5>,
  "tsb": <float>,
  "tendencia_tsb_7d": "subindo" | "caindo" | "estavel",
  "ramp_rate_ctl_4sem": <float, TSS/dia/semana>,
  "alertas": [
    "ramp_rate_excessivo" | "overreaching_nao_funcional" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0083", "nota-0084", "nota-0085", "nota-0091", ...]
}
```

O output nunca deve ser reportado ao atleta sem o campo `provenance` — é o que impede a skill de apresentar um CTL calculado sobre 10 dias de histórico (viés de warm-up) como se fosse tão confiável quanto um calculado sobre 90 dias.$m34704$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;