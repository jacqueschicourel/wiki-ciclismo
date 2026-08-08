BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m33933$skill-classificacao-tipo-de-sessao$m33933$, $m33934$skill-0014$m33934$, $m33935$Classificação do tipo de sessão — roteador (tempo-em-zona/estrutura, não média geral) para os 7 níveis de Coggan e o catálogo de objetivos do Manual$m33935$,
  $m33936$metodologia-e-periodizacao$m33936$, $m33937$classificador$m33937$,
  ARRAY[$m33938$nota-0022$m33938$, $m33939$nota-0017$m33939$, $m33940$nota-0029$m33940$, $m33941$nota-0060$m33941$, $m33942$nota-0030$m33942$, $m33943$nota-0039$m33943$, $m33944$nota-0042$m33944$, $m33945$nota-0052$m33945$, $m33946$nota-0007$m33946$, $m33947$nota-0125$m33947$, $m33948$nota-0151$m33948$, $m33949$nota-0199$m33949$, $m33950$nota-0044$m33950$, $m33951$nota-0041$m33951$, $m33952$nota-0131$m33952$, $m33953$nota-0141$m33953$, $m33954$nota-0142$m33954$]::text[],
  $m33955$0.55$m33955$, $m33956$sem série temporal de potência (só resumo/potência-média da atividade) → não é possível classificar pela estrutura real, reportar Ausente e avisar que uma classificação pela média isolada é pouco confiável (nota-0030). Sem Zonas de potência calculadas (depende do FTP, ver skill-gerais-ftp-e-zonas) → tempo-em-zona não é calculável, delegar primeiro para essa skill. O detector de cadência baixa em limiar (nota-0007) nunca gera recomendação automática, apenas hipótese de baixa confiança.$m33956$,
  $m33957$[{"campo": "potencia_serie_temporal", "tipo": "bruto", "obrigatorio": "true", "fonte": "stream de potência da atividade", "observacao": "sem isso, classificação cai para Ausente/baixa confiança pela média"}, {"campo": "zonas_potencia", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-ftp-e-zonas"}, {"campo": "marcacoes_lap", "tipo": "bruto", "obrigatorio": "false", "fonte": "laps marcados manualmente na atividade", "observacao": "para Potência-por-lap (Calc#15)"}, {"campo": "cadencia_serie", "tipo": "bruto", "obrigatorio": "false", "fonte": "sensor de cadência", "observacao": "usada apenas como sinal de contexto de baixa confiança (nota-0007/nota-0151); para o alerta de cadência baixa em limiar, precisa da série completa (não só valor pontual) para checar se a queda <70rpm durou mais de 5min consecutivos"}]$m33957$::jsonb, $m33958$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-limiar-intervalos-repetibilidade", "tipo": "despachada-para"}, {"id": "skill-limiar-calibracao-rpe", "tipo": "despachada-para"}, {"id": "skill-vo2max-janela-e-volume", "tipo": "despachada-para"}, {"id": "skill-subida-pacing", "tipo": "despachada-para"}]$m33958$::jsonb,
  $m33959$[]$m33959$::jsonb, $m33960$proposto$m33960$, $m33961$## O que faz

Classifica o tipo provável de uma sessão de treino (Base Aeróbia, Endurance, Tempo, Limiar, VO2máx, Anaeróbio, Neuromuscular, ou padrão especial como micro-burst) a partir da estrutura real de tempo-em-zona/blocos — nunca pela potência-média geral do arquivo inteiro — cruzando os 7 níveis clássicos de Coggan com o catálogo de sessões por objetivo do Manual. É o **roteador**: decide o tipo antes de despachar para a skill específica que aplica as regras finas daquele tipo (limiar, VO2máx, subida-pacing).

## Quando usar

- Sempre que for necessário nomear/rotular o "tipo" de uma sessão antes de aplicar uma skill específica por tipo de treino.
- Ao gerar feedback pós-treino que precise contextualizar se a execução correspondeu ao padrão esperado daquele tipo de sessão.
- Ao comparar duas sessões que têm potência-média parecida mas podem ser fisiologicamente muito diferentes (ex.: prova vs. treino solo).

## Passo a passo

1. **Pré-requisito**: garantir que as Zonas de potência (7 níveis de Coggan, nota-0022) já foram calculadas via `skill-gerais-ftp-e-zonas` — sem isso, tempo-em-zona não é calculável.
2. **Calcular Tempo-em-zona** (Calc#14) a partir da potência-série-temporal e das zonas. Se houver marcações de lap, calcular também **Potência-por-lap** (Calc#15, nota-0017) para isolar cada trecho prescrito.
3. **Nunca classificar pela potência-média geral**: examinar a distribuição de tempo-em-zona/blocos para achar o estímulo predominante. Ex.: 30min aquecimento (N1) + 60min Tempo (N3) + 30min volta à calma (N1) tem média geral em N2, mas é uma sessão de **Tempo** (nota-0030).
4. **Detectar padrão micro-burst** (alternância regular de ~15s a ~150%FTP / ~15s a ~50%FTP em blocos de ~10min) antes de aplicar qualquer outra métrica de zona — reclassificar como estímulo neuromuscular ou limiar conforme o contexto do bloco, não como "intervalos tradicionais" (nota-0044).
5. **Ao avaliar aderência a um intervalo prescrito**, comparar contra a faixa-alvo (ex.: 300-320W), não um valor exato — a potência ao ar livre é estocástica por natureza do terreno/vento (nota-0039).
6. **Cautela com "tempo em zona" em padrões intermitentes**: a potência não tem a inércia fisiológica da FC, então "30min acumulados em Nível 5" pode vir de bursts curtos que nunca estressaram de fato o sistema daquele nível continuamente — checar a duração de cada incursão individual, não só o total acumulado (nota-0052).
7. **Candidatar a VO2máx** quando houver blocos de **3-8min** dentro de 106-120%FTP (Nível 5) — janela mínima necessária para estímulo eficaz (nota-0042). Em esforços máximos de 3+min, usar o "quase-platô" de potência que se forma entre 1,5-2,5min como estimativa de campo da potência real de VO2máx do atleta, sem precisar de teste de laboratório (nota-0125).
8. **Nomear o tipo** cruzando a estrutura observada contra o catálogo do Manual: Base Aeróbia (3h30-5h em Z2, baixa variabilidade), Limiar (2×20min/3×15min/4×10min perto de LT2/FTP), VO2máx (5×5min/6×4min/4×8min/30-30), Anaeróbio (8×1min/10×30s), Neuromuscular (sprints 6-12s, foco em qualidade não volume), Regenerativa (intensidade muito baixa, curta) (nota-0199). Antes de rotular um bloco sustentado como "Tempo alto" ou "Limiar baixo", checar se ele cai em **88-94% do FTP** — nesse caso é **Sweet Spot**, zona funcional distinta que não é um dos 7 níveis clássicos mas é uma das mais usadas na periodização do Livro 1 (nota-0041). Reconhecer também três formatos estruturais específicos, independente da zona média: **30-30-30** (ciclos de 30s a 150%FTP / 30s roda livre / 30s corrida, em blocos de ~10min — ciclocross, nota-0131); **Kitchen Sink** (sessão longa, 3-5h+, com blocos de múltiplos sistemas energéticos deliberadamente misturados — não rotular como "mal estruturada"/"sem foco", nota-0141); **Pirâmide** (duração decrescente com intensidade crescente até um pico central, depois padrão simétrico invertido — nota-0142).
9. **Ao interpretar sessão de prova (mass-start)**, lembrar que a mesma zona de potência média tem estresse fisiológico maior em prova do que em treino solo, por causa da maior variabilidade (VI mais alto) — não equiparar diretamente sem checar VI (nota-0029). Calcular VI = NP ÷ potência média (nota-0060) e usar **VI > 1,05** como limiar operacional do alerta: esse corte fica entre o teto da faixa de treino de potência constante/isopower (1,00-1,02, Tabela 7.1) e o piso das provas mais amenas da mesma tabela (prova de estrada plana/CR plano/CR de subida, 1,00-1,04 a 1,00-1,06) — não é um valor novo, é o ponto de corte que a própria tabela do cânone já implica entre "treino constante" e "prova típica". VI ≤ 1,05 → não disparar o alerta (padrão mais próximo de treino constante).
10. **Cadência como sinal de contexto (cautela)**: cadência <70rpm em potência de limiar só dispara a hipótese de baixa confiança se a queda durar **mais de 5 minutos consecutivos** — esse requisito de duração está no próprio trecho-fonte de nota-0007 ("cadence dropped below 70 rpm for more than five minutes") e precisa ser checado a partir da série bruta de cadência (`cadencia_serie`), não só do valor pontual. Quedas breves/pontuais abaixo de 70rpm não devem disparar o alerta. Mesmo com o filtro de duração satisfeito, isto continua sendo hipótese de baixa confiança (nota-0007, N=1, status "revisar") — nunca gerar recomendação automática de troca de marcha, só sinalizar para revisão humana. Faixas de cadência por contexto (80-95rpm moderado / >110rpm sprint / <75rpm subida, nota-0151) são heurística frouxa adicional, não regra de alerta.
11. **Despachar** para a skill específica do tipo classificado (`skill-limiar-*`, `skill-vo2max-janela-e-volume`, `skill-subida-pacing`) para aplicar as regras finas daquele tipo.
12. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer classificação.

## Output

```
{
  "tipo_sessao_provavel": "base_aerobia" | "endurance" | "tempo" | "sweet_spot" | "limiar" | "vo2max" | "anaerobio" | "neuromuscular" | "regenerativa" | "microburst" | "30_30_30_ciclocross" | "kitchen_sink" | "piramide" | "indeterminado",
  "metodo_classificacao": "estrutura_tempo_em_zona" | "media_geral_baixa_confianca",
  "blocos_identificados": [{"inicio_s": <int>, "fim_s": <int>, "nivel_coggan": <int 1-7>, "potencia_media_w": <float>}],
  "vo2max_watts_estimado_quase_plato": <float, null>,
  "vi_calculado": <float, null>,
  "vi_acima_de_1_05": <bool, null>,
  "alertas": [
    "classificado_so_pela_media_baixa_confianca" | "padrao_microburst_detectado" | "cadencia_baixa_limiar_hipotese_n1_revisar" | "prova_vs_treino_mesma_zona_estresse_diferente" | null
  ],
  "skill_despachada_para": "<id da skill específica por tipo, ou null se indeterminado>",
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0022", "nota-0017", "nota-0029", "nota-0060", "nota-0030", "nota-0039", "nota-0042", "nota-0052", "nota-0007", "nota-0125", "nota-0151", "nota-0199", "nota-0044", "nota-0041", "nota-0131", "nota-0141", "nota-0142"]
}
```$m33961$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;