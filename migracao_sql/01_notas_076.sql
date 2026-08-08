BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10124$nota-0243$m10124$, $m10125$Terminologia de três degraus: Overload (planejado) → Overreaching (não planejado, recupera em dias/semanas) → Overtraining Syndrome (crônico); duas formas clínicas — simpática (rara) e parassimpática (comum)$m10125$, $m10126$recuperacao-e-fadiga$m10126$,
  $m10127$contexto$m10127$, $m10128$conceito$m10128$,
  ARRAY[$m10129$semanal$m10129$, $m10130$mensal$m10130$]::text[], '{}'::text[],
  0.65, $m10131$revisar$m10131$, $m10132$McArdle formaliza três degraus de severidade em vez da dicotomia simples "overreached vs. overtrained": (1) **Overload** — aumento planejado, sistemático e progressivo do treino para melhorar desempenho (o estímulo desejável); (2) **Overreaching** — sobrecarga excessiva e não planejada com recuperação inadequada, com queda de desempenho em treino e competição; recuperação bem-sucedida ocorre com intervenções de curto prazo (poucos dias até 1-2 semanas); (3) **Overtraining Syndrome (OTS)** — overreaching não tratado, produzindo queda de desempenho de longo prazo e capacidade de treino prejudicada, podendo exigir semanas a meses de recuperação e, em alguns casos, atenção médica.

O texto também descreve **duas formas clínicas** de overtraining, geralmente pouco distinguidas na linguagem popular: (1) **Forma simpática** (menos comum, chamada "basedowiana" em referência ao hipertireoidismo) — caracterizada por atividade simpática aumentada em repouso, hiperexcitabilidade, inquietação e queda de desempenho; associada a estresse psicológico/emocional excessivo. (2) **Forma parassimpática** (mais comum, chamada "addisoniana" em referência à insuficiência adrenal) — predomínio de atividade vagal em repouso e durante exercício, fadiga crônica em treinos e períodos de recuperação, sono e apetite alterados, infecções frequentes, alterações de humor (raiva, depressão, ansiedade) e mal-estar geral. É nesta forma que o "overreaching" descrito acima se manifesta nos estágios iniciais (a partir de apenas 10 dias de sobrecarga).

Prevalência estimada: 10 a 20% dos atletas experimentam overtraining ou "estagnação" (staleness) em algum momento.

Aplicação ao feedback: nota de contexto mecanístico/clínico — não gera regra de interpretação direta de um sinal isolado do Strava (a distinção simpática/parassimpática depende de sinais fisiológicos que o Strava não captura, como FC de repouso, cortisol, sono). Útil para calibrar a linguagem do feedback ao descrever um estado de fadiga prolongada detectado por outros sinais (ex.: TSB muito negativo por semanas, nota-0092): comunicar que existe um espectro de severidade (Overload desejável → Overreaching recuperável em dias/semanas → Overtraining Syndrome, que exige recuperação muito mais longa), evitando alarmismo prematuro mas também não banalizando quedas de desempenho persistentes.$m10132$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10133$nota-0244$m10133$, $m10134$Modelo de 'Desequilíbrio Crônico' de Lehmann et al. (1998) para a gênese da síndrome de overtraining: cinco vias de sobrecarga (neuromuscular, simpática, metabólica, psicológica, adrenal) convergindo para desempenho prejudicado$m10134$, $m10135$recuperacao-e-fadiga$m10135$,
  $m10136$contexto$m10136$, $m10137$conceito$m10137$,
  ARRAY[$m10138$mensal$m10138$]::text[], '{}'::text[],
  0.6, $m10139$revisar$m10139$, $m10140$McArdle reproduz o modelo de Lehmann et al. (1998, "Autonomic imbalance hypothesis and overtraining syndrome", Med Sci Sports Exerc 30:1140) para explicar a gênese da síndrome de overtraining em esportes de endurance com treino prolongado de alto volume. O modelo parte de um **"Desequilíbrio Crônico" (Chronic Imbalance)** entre três entradas — Carga de Treino (Training Load), Competição, e Fatores de Estresse Não Relacionados ao Treino (ex.: condições médicas preexistentes, carboidrato/hidratação inadequados, calor/umidade/altitude, pressões psicossociais como treino monótono, competições frequentes e conflitos pessoais) — somado a **Recuperação Inadequada**.

Esse desequilíbrio crônico se propaga por **cinco vias de sobrecarga** que operam em paralelo e se interconectam:
1. **Sobrecarga neuromuscular** → redução da função neuromuscular e da densidade de β-adrenoceptores → contribui para fadiga periférica.
2. **Sobrecarga do sistema simpático** → redução da atividade simpática intrínseca.
3. **Sobrecarga metabólica** → depleção de glicogênio e desequilíbrio de aminoácidos.
4. **Sobrecarga psicológica** → desequilíbrio de neurotransmissores cerebrais e alteração do estado de humor.
5. **Sobrecarga adrenal** → função hipotalâmico-hipofisária alterada → resposta de cortisol diminuída.

Essas cinco vias convergem em: função imune alterada, fadiga periférica, alteração do humor, fadiga central, função reprodutiva alterada — culminando em **desempenho de exercício prejudicado**.

Do ponto de vista hormonal, o desequilíbrio crônico se reflete em: (1) prejuízos funcionais nos eixos hipotálamo-hipófise-gonadal e adrenal e no sistema neuroendócrino simpático, refletidos por excreção urinária reduzida de norepinefrina e dessensibilização do sistema β2-adrenérgico; (2) aumentos induzidos por exercício de ACTH e hormônio do crescimento, com reduções de cortisol e insulina.

**Nota sobre o cânone:** este modelo é qualitativo/mecanístico — não fornece uma fórmula de cálculo (ex.: não é equivalente à fórmula de Monotonia/Strain de Foster, que continua sem fonte confirmada no cânone; ver nota-0193). Ele complementa, mas não resolve, a lacuna de uma métrica quantitativa de risco de overtraining a partir de dados de treino.

Aplicação ao feedback: nota de contexto mecanístico puro — não gera regra de interpretação direta de um sinal isolado do Strava (nenhuma das cinco vias é mensurável diretamente pelos dados disponíveis: ACTH, cortisol, densidade de β-adrenoceptores, neurotransmissores). Relevante para explicar, em linguagem educativa, por que overtraining é multifatorial (treino + competição + estresse de vida, não apenas volume/intensidade de treino) quando o produto precisar contextualizar um alerta de fadiga prolongada.$m10140$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;