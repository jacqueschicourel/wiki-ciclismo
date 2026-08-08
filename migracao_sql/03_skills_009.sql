BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34221$skill-gerais-checklist-pos-treino$m34221$, $m34222$skill-0012$m34222$, $m34223$Checklist pós-treino/pós-prova — kJ→kcal, matches queimados, scatterplots diagnósticos, roteiro agregador$m34223$,
  $m34224$avaliacao-e-testes$m34224$, $m34225$calculadora+detector$m34225$,
  ARRAY[$m34226$nota-0002$m34226$, $m34227$nota-0055$m34227$, $m34228$nota-0057$m34228$, $m34229$nota-0058$m34229$]::text[],
  $m34230$0.75$m34230$, $m34231$sem trabalho-kJ registrado na atividade → estimativa de kcal fica Ausente. Sem FTP válido no perfil (pré-requisito: skill-gerais-ftp-e-zonas) → contagem de matches não é calculável (depende do FTP como referência dos limiares da Tabela 6.2). Sem cadência ou balanço esquerda/direita disponíveis no arquivo → os respectivos scatterplots não podem ser gerados, reportar Ausente só para esses eixos. Sem canal de velocidade disponível ou com velocidade GPS degradada (ex.: sinal fraco em floresta/túnel, muitas paradas/lacunas na série) → o scatterplot cadência×velocidade especificamente fica Ausente (nota-0057), mesmo que cadência esteja disponível — não gerar esse eixo com dado de velocidade não confiável. Caso de borda incomum na prática (velocidade GPS quase sempre presente no Strava), mas tratado explicitamente por completude. O eixo 'pós-prova' do checklist (matches, ponto de quebra) só se aplica quando a atividade é classificada como prova — ver skill-classificacao-contexto-atividade; em treino solo estruturado, usar apenas o eixo 'pós-treino'.$m34231$,
  $m34232$[{"campo": "trabalho_kj", "tipo": "bruto", "obrigatorio": "false", "fonte": "Strava: trabalho mecânico (kJ) da atividade", "observacao": "sem isso, estimativa de kcal fica Ausente"}, {"campo": "ftp_vigente", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-ftp-e-zonas (limiares da Tabela 6.2 para contagem de matches)"}, {"campo": "cadencia_serie", "tipo": "bruto", "obrigatorio": "false", "fonte": "sensor de cadência", "observacao": "sem isso, scatterplot potência×cadência não é gerado"}, {"campo": "balanco_esquerda_direita_serie", "tipo": "bruto", "obrigatorio": "false", "fonte": "medidor bilateral", "observacao": "sem isso, scatterplot balanço E/D×potência não é gerado"}, {"campo": "velocidade_serie", "tipo": "bruto", "obrigatorio": "false", "fonte": "Strava: velocidade GPS da atividade", "observacao": "sem isso, ou com sinal degradado/muitas lacunas, o scatterplot cadência×velocidade fica Ausente"}, {"campo": "classificacao_prova_ou_treino", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-classificacao-contexto-atividade", "observacao": "define se o eixo 'pós-prova' do checklist se aplica"}]$m34232$::jsonb, $m34233$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-forca-e-pedalada", "tipo": "complementar"}, {"id": "skill-classificacao-contexto-atividade", "tipo": "complementar"}]$m34233$::jsonb,
  $m34234$[]$m34234$::jsonb, $m34235$proposto$m34235$, $m34236$## O que faz

Aplica o roteiro padrão de revisão pós-treino/pós-prova do cânone: converte o trabalho mecânico (kJ) em estimativa de gasto calórico para checar reabastecimento; conta e localiza no tempo os "matches" queimados (esforços decisivos acima do FTP); gera scatterplots diagnósticos (potência×cadência, balanço esquerda/direita, cadência×velocidade) que revelam padrões que a média isolada esconde; e percorre o checklist agregador de perguntas-padrão — um roteiro para treino, outro para prova.

## Quando usar

- Ao gerar o feedback pós-treino ou pós-prova de qualquer atividade com dados de potência.
- Ao investigar por que um atleta foi "descolado" numa prova, ou se um treino teve volume/intensidade adequados.
- Ao avaliar se a reposição nutricional pós-sessão foi condizente com o gasto energético real.

## Passo a passo

1. **Calcular kJ→kcal**: usar o trabalho mecânico total (kJ) da atividade diretamente como estimativa de kcal (aproximação ~1:1, os fatores de eficiência individual se cancelam) — reportar junto ao TSS da sessão para apoiar recomendações de reabastecimento, especialmente em atividades longas (nota-0002).
2. **Contar matches**: identificar esforços que excedem os limiares decrescentes por duração em relação ao FTP (1min ≥120%FTP; 5min 114-120%; 10min 108-114%; 20min 100-108%), e localizar cada um no tempo da atividade (nota-0055).
3. **Gerar scatterplots diagnósticos**, conforme os canais disponíveis no arquivo: potência×cadência (identificar em qual cadência o atleta produz seus picos, e o limite superior de cadência para gerar potência alta); balanço esquerda/direita×potência (identificar favorecimento de perna por faixa de intensidade); cadência×velocidade (identificar o ponto de troca de marcha, relevante em ciclocross) (nota-0057).
4. **Percorrer o checklist agregador — eixo treino**: kJ totais vs. reabastecimento (passo 1); Quadrant Analysis da sessão comparada com Quadrant Analysis de provas-alvo (via `skill-gerais-forca-e-pedalada`), para checar especificidade; ponto em que a potência começou a cair na sessão e quantos kJ já haviam sido gastos até ali; comparação de intervalos entre si por overlay — quantas repetições até uma queda relevante de potência, e se o número total de intervalos foi adequado (nem de menos, nem de mais) (nota-0058).
5. **Percorrer o checklist agregador — eixo prova** (só se a atividade for classificada como prova, via `skill-classificacao-contexto-atividade`): matches queimados e sua localização (passo 2), para entender a real demanda de esforços decisivos daquele tipo de prova; localização dos picos de potência no arquivo; se o atleta foi "descolado", que tipo de esforço precisou fazer antes disso, com quantos watts, e onde exatamente ocorreu o ponto de quebra (nota-0058).
6. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer eixo do checklist como concluído.

## Output

```
{
  "gasto_calorico_kcal_estimado": <float, null>,
  "matches": [{"inicio_s": <int>, "duracao_s": <int>, "potencia_media_w": <float>, "pct_ftp": <float>}],
  "scatterplots_disponiveis": {"potencia_x_cadencia": <bool>, "balanco_ed_x_potencia": <bool>, "cadencia_x_velocidade": <bool>},
  "checklist_treino": {
    "kj_vs_reabastecimento": "<texto ou null>",
    "quadrant_analysis_vs_prova": "<texto ou null>",
    "ponto_de_queda": {"tempo_s": <int, null>, "kj_acumulados_ate_ali": <float, null>},
    "overlay_intervalos": "<texto ou null>"
  },
  "checklist_prova": {
    "matches_resumo": "<texto ou null>",
    "localizacao_picos": "<texto ou null>",
    "ponto_de_quebra": {"tempo_s": <int, null>, "potencia_w": <float, null>, "esforco_precedente": "<texto ou null>"}
  },
  "alertas": [null],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0002", "nota-0055", "nota-0057", "nota-0058"]
}
```$m34236$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;