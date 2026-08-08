BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m35144$skill-vo2max-janela-e-volume$m35144$, $m35145$skill-0019$m35145$, $m35146$VO2máx — janela de duração eficaz, quase-platô de campo, HIIT vs. contínuo, protocolo 4×4 padrão-ouro, volume total > duração isolada, micro-burst$m35146$,
  $m35147$tipos-de-treino$m35147$, $m35148$detector$m35148$,
  ARRAY[$m35149$nota-0042$m35149$, $m35150$nota-0125$m35150$, $m35151$nota-0220$m35151$, $m35152$nota-0221$m35152$, $m35153$nota-0222$m35153$, $m35154$nota-0044$m35154$, $m35155$nota-0043$m35155$, $m35156$nota-0199$m35156$, $m35157$nota-0246$m35157$, $m35158$nota-0250$m35158$]::text[],
  $m35159$0.6$m35159$, $m35160$sem série temporal de potência e/ou FC → a janela de duração por repetição e a estimativa de quase-platô não são calculáveis, reportar Ausente. Esta skill assume que a sessão já foi roteada como candidata a VO2máx por skill-classificacao-tipo-de-sessao — não deve ser aplicada isoladamente sem esse roteamento prévio, sob risco de aplicar as regras finas de VO2máx a uma sessão de outro tipo.$m35160$,
  $m35161$[{"campo": "potencia_serie_temporal", "tipo": "bruto", "obrigatorio": "true", "fonte": "stream de potência da atividade"}, {"campo": "fc_serie_temporal", "tipo": "bruto", "obrigatorio": "false", "fonte": "sensor de FC (cruzamento com potência)"}, {"campo": "classificacao_tipo_sessao", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-classificacao-tipo-de-sessao (roteamento prévio como candidata a VO2máx)"}]$m35161$::jsonb, $m35162$[{"id": "skill-classificacao-tipo-de-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}]$m35162$::jsonb,
  $m35163$[]$m35163$::jsonb, $m35164$proposto$m35164$, $m35165$## O que faz

Aplica as regras finas de estímulo de VO2máx a uma sessão já roteada como candidata a esse tipo por `skill-classificacao-tipo-de-sessao`: verifica se a duração de cada repetição caiu na janela eficaz (3-8min), estima a potência real de VO2máx via o "quase-platô" de campo, fundamenta por que HIIT é preferível a treino contínuo moderado para esse objetivo, reconhece o protocolo 4×4min como referência de padrão-ouro validado, prioriza o volume total acumulado de trabalho em alta intensidade sobre a duração isolada de uma repetição, e reconhece o padrão micro-burst como estímulo alternativo.

## Quando usar

- Depois que `skill-classificacao-tipo-de-sessao` já classificou a sessão (ou um bloco dela) como candidata a VO2máx.
- Ao avaliar se um bloco de intervalos foi eficaz para o objetivo declarado de elevar VO2máx/potência aeróbia máxima.
- Ao estimar a potência de VO2máx do atleta a partir de um esforço máximo de campo, sem teste de laboratório.

## Passo a passo

1. **Confirmar o roteamento**: esta skill só deve ser aplicada a sessões/blocos já classificados como candidatos a VO2máx.
2. **Verificar a janela de duração eficaz**: cada repetição deve durar entre 3 e 8 minutos a 106-120% do FTP (Nível 5 de Coggan) para gerar estímulo adequado de VO2máx — fora dessa janela (mesmo na intensidade certa), o sistema predominantemente treinado tende a ser outro (capacidade anaeróbia, se muito curto; limiar, se a intensidade cair para sustentar mais tempo) (nota-0042). Repetições de **≤2 minutos em intensidade claramente supra-máxima (>120%FTP)** não são VO2máx, são **Capacidade Anaeróbia** (Nível 6) — sistema energético distinto que exige mais de 100% do VO2máx do atleta, não deve ser contabilizado no volume de VO2máx do passo 6 (nota-0043).
3. **Estimar a potência de VO2máx pelo quase-platô**: em esforços máximos de 3+ minutos bem executados, identificar o ponto (tipicamente entre 1,5-2,5min) onde a potência para de cair rapidamente e estabiliza — esse patamar é uma boa aproximação de campo da potência real de VO2máx do atleta (nota-0125). Ressalva: um aquecimento insuficiente antes do esforço máximo pode subestimar esse platô — aquecimento estruturado melhora desempenho intenso em 2-3% via cinética de VO2 mais rápida (nota-0250, status "revisar") — considerar esse fator antes de tratar um quase-platô baixo como definitivo, especialmente em esforços feitos "a frio".
4. **Justificar a priorização de HIIT**: ao recomendar intervalado de alta intensidade em vez de mais volume contínuo em Z2 para o objetivo de elevar VO2máx, citar a evidência de meta-análise (+5,5 mL/kg/min HIIT vs. +4,9 contínuo moderado, vantagem de 1,2 mL/kg/min) — efeito ampliado em atletas mais velhos, com aptidão de base mais baixa, ou com intervenções/repetições mais longas (nota-0220).
5. **Reconhecer o protocolo 4×4min como padrão-ouro**: 4 séries de 4min a 90-95%FCmáx com 3min de recuperação ativa a 70%FCmáx entre elas — evidência comparativa direta mostra +8,8% de VO2máx em 8 semanas, superando 15s-on/15s-off (+6,4%) e treino contínuo (~+2%, não significativo), com o mesmo gasto energético total (nota-0221).
6. **Priorizar volume total sobre duração isolada**: ao avaliar se uma sessão "valeu a pena" para VO2máx, somar o tempo total acumulado em alta intensidade (todas as repetições), não avaliar apenas a duração de uma repetição isolada — esse volume total é o maior preditor de ganho. Intervalos curtos/sprint só contam se forem verdadeiramente "all-out"; intervalos mais longos podem ser submáximos mas ainda muito difíceis (nota-0222).
7. **Detectar padrão micro-burst** (15s a ~150%FTP / 15s a ~50%FTP em blocos de ~10min) — reconhecer antes de aplicar outra métrica de zona. **Correção (2026-08-02, achado de auditoria adversarial): nota-0044 classifica este protocolo apenas como Nível 7 (neuromuscular) ou, numa variação com bursts de 10s dentro de um bloco de Tempo baixo, Nível 4 (limiar) — a fonte nunca o classifica como Nível 5/VO2máx.** Não contabilizar micro-burst no volume total de VO2máx do passo 6; é um estímulo distinto (neuromuscular ou limiar, conforme o contexto do bloco), não uma variante de VO2máx.
8. **Reconhecer o formato contra o catálogo do Manual**: comparar a estrutura observada (nº de repetições × duração) contra os formatos prescritos de VO2máx — 5×5min, 6×4min, 4×8min, 30-30 (nota-0199) — além do 4×4min já coberto no passo 5, para nomear o protocolo reconhecido de forma mais específica que apenas "VO2máx genérico".
9. **Avaliar a razão trabalho:recuperação (contexto, cautela)**: para intervalos de alta intensidade prolongados (a faixa mais próxima ao formato de VO2máx no McArdle é 60-90s, razão 1:1 a 1:1,5), uma recuperação muito mais longa que isso pode não acumular estresse cardiovascular suficiente entre repetições — usar como referência direcional, não como limiar rígido, pois os números originais são calibrados para corrida/natação, não potência de ciclismo (nota-0246, status "revisar").
10. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer estimativa.

## Output

```
{
  "repeticoes": [{"duracao_s": <int>, "dentro_da_janela_3_8min": <bool>, "potencia_media_w": <float>}],
  "vo2max_watts_estimado_quase_plato": <float, null>,
  "volume_total_alta_intensidade_s": <float, null>,
  "protocolo_reconhecido": "4x4min_padrao_ouro" | "5x5min" | "6x4min" | "4x8min" | "30-30" | "microburst" | "outro" | "indeterminado",
  "justificativa_hiit_vs_continuo": "<texto ou null>",
  "razao_trabalho_recuperacao": <float, null>,
  "alertas": [
    "repeticao_fora_da_janela_3_8min" | "repeticao_curta_e_supra_maxima_e_capacidade_anaerobia_nao_vo2max" | "volume_total_baixo_apesar_de_repeticoes_longas" | "protocolo_4x4_reconhecido" | "microburst_detectado" | "aquecimento_insuficiente_possivel_subestimativa_quase_plato" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0042", "nota-0125", "nota-0220", "nota-0221", "nota-0222", "nota-0044", "nota-0043", "nota-0199", "nota-0246", "nota-0250"]
}
```$m35165$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;