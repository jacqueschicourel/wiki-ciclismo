BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2645$nota-0126$m2645$, $m2646$Estimando a contribuição aeróbia vs. anaeróbia e o MAOD (déficit máximo acumulado de O2) a partir da área sob a curva de potência$m2646$, $m2647$fisiologia$m2647$,
  $m2648$contexto$m2648$, $m2649$conceito$m2649$,
  ARRAY[$m2650$mensal$m2650$]::text[], ARRAY[$m2651$potência-série-temporal$m2651$]::text[],
  0.5, $m2652$revisar$m2652$, $m2653$Método (comparação de casos de dois atletas de perseguição de pista) para estimar a proporção de energia produzida por via aeróbia vs. anaeróbia num esforço máximo de poucos minutos:

1. Calcular a potência aeróbia máxima teórica do atleta a partir de VO2max e eficiência determinados em laboratório (linha "suave" de referência).
2. Medir a potência real do atleta durante o esforço (linha "irregular" do medidor de potência).
3. A **área sob a linha de potência aeróbia máxima teórica**, como percentual da **área total sob a curva de potência real**, representa a fração do trabalho realizada por via aeróbia; o restante veio de fontes anaeróbias (fosfocreatina/ATP e produção de lactato).
4. Convertendo a energia anaeróbia (percentual restante) em litros equivalentes de O2, obtém-se o **MAOD (déficit máximo acumulado de oxigênio)** — uma medida da capacidade anaeróbia total do atleta.

Exemplo do livro: dois atletas de perseguição com potência média e tempo de prova comparáveis tinham composições muito diferentes — um (masters, ciclista de estrada) com 80% aeróbio / MAOD 3,36 L; outra (pista, elite) com apenas 72% aeróbio / MAOD 5,27 L, apesar de VO2max 4% menor — sua maior capacidade anaeróbia compensava e até superava a diferença de VO2max. Isso levou a planos de treino diferentes: o atleta mais aeróbio focou em Nível 6 (Capacidade Anaeróbia); a atleta mais anaeróbia focou em Níveis 3-5 (Tempo/Limiar/VO2max) para desenvolver a base aeróbia relativamente mais fraca.

**Motivo da revisão:** requer dado de laboratório (VO2max medido, eficiência mecânica) que não é obtido de um medidor de potência isolado nem do Strava — não implementável diretamente com dados típicos de Strava sem uma estimativa substituta de VO2max. Mantido como contexto/cânone, não como funcionalidade direta do produto sem essa entrada adicional.

Aplicação ao feedback: não aplicável diretamente sem dado de VO2max de laboratório ou uma estimativa confiável equivalente; registrar como referência conceitual para eventual funcionalidade futura caso o produto incorpore estimativas de VO2max (ex.: de testes de campo).$m2653$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2654$nota-0136$m2654$, $m2655$A marcha (relação de transmissão) usada numa arrancada não altera a força que os músculos produzem numa dada cadência — só a velocidade de aceleração$m2655$, $m2656$fisiologia$m2656$,
  $m2657$contexto$m2657$, $m2658$conceito$m2658$,
  ARRAY[$m2659$mensal$m2659$]::text[], ARRAY[$m2660$cadência$m2660$, $m2661$potência-máx$m2661$]::text[],
  0.6, $m2662$ativo$m2662$, $m2663$Crença comum entre ciclistas de pista: usar uma marcha maior que a de prova numa arrancada (standing start) geraria uma sobrecarga extra no sistema neuromuscular, aumentando força/potência de treino. Pesquisa citada mostra que isso é **falso, dentro de limites razoáveis**: a força que os músculos produzem numa dada cadência é determinada pela relação força-velocidade intrínseca do músculo (propriedades contráteis), não pela marcha escolhida. A marcha apenas determina a rapidez com que o ciclista "percorre" essa curva força-velocidade durante a aceleração — não altera o pico de força disponível em cada cadência.

Aplicação ao feedback: nota de contexto fisiológico — relevante para não recomendar automaticamente "marcha maior = treino de força mais eficaz" em arrancadas; a variável de treino que realmente importa é a cadência/velocidade em si, não a relação de transmissão escolhida. Não diretamente mensurável a partir de dados típicos de Strava (exigiria dados de força/cadência de alta frequência), mas útil como princípio para explicações qualitativas sobre potência máxima em arrancadas.$m2663$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2664$nota-0153$m2664$, $m2665$Princípio do Tamanho de Henneman: recrutamento progressivo de unidades motoras (fibras tipo I primeiro, tipo II conforme intensidade aumenta)$m2665$, $m2666$fisiologia$m2666$,
  $m2667$contexto$m2667$, $m2668$conceito$m2668$,
  ARRAY[$m2669$mensal$m2669$]::text[], '{}'::text[],
  0.65, $m2670$ativo$m2670$, $m2671$A produção de força depende de dois mecanismos neurais: recrutamento de unidades motoras (quantas são ativadas) e frequência de disparo dos impulsos nervosos. O Princípio do Tamanho de Henneman descreve a ordem desse recrutamento: em esforços leves, predominam unidades motoras pequenas (fibras tipo I, oxidativas, resistentes à fadiga); conforme a intensidade aumenta, unidades motoras maiores (fibras tipo II, glicolíticas, mais potentes e menos resistentes) são progressivamente recrutadas.

Aplicação ao feedback: explica, no nível mecanístico, por que esforços de alta intensidade recrutam fibras mais fatigáveis e por que treinos de baixa intensidade não estimulam adequadamente a capacidade anaeróbia/neuromuscular — dá base fisiológica à necessidade de intervalos de alta intensidade para desenvolver potência máxima/anaeróbia, complementando (sem repetir) as notas de metodologia de treino do Livro 1 sobre tipos de treino por zona.$m2671$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2672$nota-0154$m2672$, $m2673$Os três sistemas de ressíntese de ATP: fosfagênio (~10s), glicolítico (30s-poucos min), oxidativo (longa duração) — atuam simultaneamente, nunca isolados$m2673$, $m2674$fisiologia$m2674$,
  $m2675$contexto$m2675$, $m2676$conceito$m2676$,
  ARRAY[$m2677$diario$m2677$]::text[], '{}'::text[],
  0.6, $m2678$ativo$m2678$, $m2679$Classificação didática dos três sistemas de regeneração de ATP, que na prática atuam sempre simultaneamente (a distinção é de contribuição relativa, não de exclusividade): (1) Fosfagênio (ATP-PCr) — produção extremamente rápida, predomina em esforços máximos de até ~10s (sprints, arrancadas, ataques explosivos), baixa capacidade total; (2) Glicolítico — usa glicose/glicogênio, produção rápida porém mais lenta que o fosfagênio, predomina entre ~30s e poucos minutos (subidas curtas, perseguições, XCO, critérios); (3) Oxidativo — usa carboidratos, gorduras e proteínas, produção mais lenta mas capacidade praticamente ilimitada, domina em provas de estrada, granfondos, ultraciclismo. Mesmo um sprint de 6s tem participação oxidativa, e mesmo uma prova de 6h tem picos anaeróbios em ataques.

Aplicação ao feedback: fundamenta, no nível mecanístico, a lógica por trás da segmentação de zonas/tipos de treino já usada no produto (ex.: por que intervalos curtos e explosivos visam o sistema fosfagênio e intervalos de VO2max visam o sistema glicolítico/oxidativo combinado) — não gera regra de interpretação direta de um dado isolado do Strava, mas serve de justificativa de fundo caso o feedback explique "por que" um tipo de treino foi recomendado.$m2679$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;