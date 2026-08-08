BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m35019$skill-limiar-calibracao-rpe$m35019$, $m35020$skill-0018$m35020$, $m35021$Calibração de potência-RPE — reconhecer o protocolo de 3 fases e usar a relação aprendida para validar pacing$m35021$,
  $m35022$tipos-de-treino$m35022$, $m35023$detector$m35023$,
  ARRAY[$m35024$nota-0109$m35024$]::text[],
  $m35025$0.75$m35025$, $m35026$sem esforço-relativo (proxy de RPE do Strava) disponível nas sessões candidatas → não é possível associar a relação RPE-potência aprendida, reportar Ausente. Reconhecer o padrão das 3 fases exige um histórico de pelo menos ~10-20 dias de sessões estruturadas repetidas por intensidade — sem esse volume de dados, não há bloco de calibração a reconhecer, mesmo que sessões isoladas pareçam parecidas com o protocolo.$m35026$,
  $m35027$[{"campo": "esforco_relativo_rpe_serie", "tipo": "bruto", "obrigatorio": "true", "fonte": "Strava: esforço relativo (proxy de RPE) das sessões candidatas"}, {"campo": "historico_sessoes_estruturadas", "tipo": "bruto", "obrigatorio": "true", "fonte": "histórico de ~10-20 dias de sessões estruturadas repetidas por intensidade", "observacao": "sem esse volume, não há bloco de calibração a reconhecer"}]$m35027$::jsonb, $m35028$[{"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-subida-pacing", "tipo": "complementar"}, {"id": "skill-limiar-intervalos-repetibilidade", "tipo": "complementar"}]$m35028$::jsonb,
  $m35029$[]$m35029$::jsonb, $m35030$proposto$m35030$, $m35031$## O que faz

Reconhece, no histórico de treino, um bloco de sessões que segue o protocolo estruturado de calibração de potência-RPE (associar esforço percebido a uma wattagem específica, essencial para pacing em triathlon, onde FC/RPE no dia da prova tende a ficar mais baixo que no treino para o mesmo esforço real) e, quando identificado, usa a relação RPE-vs-potência aprendida para validar a estratégia de pacing do atleta numa prova subsequente.

## Quando usar

- Ao analisar um histórico de treino com sessões repetidas de duração/intensidade específicas ao longo de ~10-20 dias.
- Ao validar se o pacing de uma prova (especialmente triathlon) correspondeu à relação RPE-potência que o atleta já havia calibrado em treino.

## Passo a passo

1. **Identificar candidatos à Fase 1** (curta duração): sequência de sessões com 3-4 intervalos de 10 minutos (5 minutos de recuperação entre eles), repetidas ~5 vezes ao longo de ~10 dias, num mesmo nível de intensidade-alvo.
1a. **Checagem de qualidade por sessão (achado de auditoria adversarial, 2026-08-02)**: cada sessão individual de Fase 1 (3-4×10min) é, em estrutura, uma série de intervalos repetidos — rodar `skill-limiar-intervalos-repetibilidade` sobre ela para checar se a potência caiu de forma anormal entre o 1º e o último intervalo. Isto NÃO é critério de reconhecimento do bloco de calibração (que segue sendo definido só pela estrutura de nota-0109), mas informa a confiança da relação RPE-potência aprendida: se uma sessão de Fase 1 mostrar queda de potência acima do critério retrospectivo (~10%, nota-0054) entre intervalos, a leitura de RPE dessa sessão foi provavelmente contaminada por fadiga acumulada dentro da própria sessão — reduzir a confiança da wattagem associada àquele nível de RPE nessa sessão específica, sinalizando o alerta correspondente.
2. **Identificar Fase 2** (duração média): se a Fase 1 foi repetida pelo menos 2 vezes numa dada intensidade, procurar 2 esforços de 20 minutos naquela mesma intensidade.
3. **Identificar Fase 3** (duração longa): esforços de 60 minutos, repetidos pelo menos mais 2 vezes na mesma intensidade.
4. **Aplicar a regra crítica**: no máximo 1 sessão de calibração por dia. Se o histórico mostrar 2+ sessões de calibração no mesmo dia, sinalizar que a internalização do RPE para aquele bloco pode estar comprometida (respostas físicas de diferentes níveis se misturam) — reduzir a confiança da relação RPE-potência aprendida nesse trecho.
5. **Usar a relação aprendida**: quando um bloco de calibração for reconhecido com confiança razoável, usar a associação RPE↔potência resultante para cruzar/validar a estratégia de pacing do atleta numa prova subsequente — especialmente relevante em triathlon.
6. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer relação RPE-potência como aprendida.

## Output

```
{
  "bloco_calibracao_reconhecido": <bool>,
  "fases_completas": {"fase_1_10min": <bool>, "fase_2_20min": <bool>, "fase_3_60min": <bool>},
  "intensidades_calibradas": [{"nivel": "<texto>", "potencia_w": <float>, "rpe_associado": <float, null>}],
  "violacao_1_sessao_por_dia": <bool>,
  "relacao_rpe_potencia_aplicavel_a_pacing": <bool>,
  "alertas": ["multiplas_sessoes_calibracao_mesmo_dia_confianca_reduzida" | "queda_de_potencia_fase1_acima_de_10pct_confianca_reduzida" | null],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0109"]
}
```$m35031$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;