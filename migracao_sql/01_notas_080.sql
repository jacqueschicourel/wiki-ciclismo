BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10713$nota-0054$m10713$, $m10714$Analisar repetibilidade de uma série: comparar o 2º/3º intervalo com o último para medir a queda de potência$m10714$, $m10715$tipos-de-treino$m10715$,
  $m10716$direta$m10716$, $m10717$regra-interpretacao$m10717$,
  ARRAY[$m10718$diario$m10718$]::text[], ARRAY[$m10719$potência-por-lap$m10719$]::text[],
  0.7, $m10720$revisar$m10720$, $m10721$Para avaliar retrospectivamente a "repetibilidade" de uma série de intervalos já concluída (ex.: 12 subidas de ~1 minuto), os autores recomendam comparar a potência do 2º ou 3º intervalo (não o 1º, que é sempre mais forte por o atleta estar fresco) com a potência do último intervalo da série, para visualizar quanto a potência efetivamente caiu ao longo da sessão.

Exemplo do livro: um atleta com 5º intervalo em 403 W (usado aqui como referência) — uma queda de 10% ficaria perto de 360 W; o 11º intervalo dele ficou em 347 W (já abaixo desse piso), e ainda assim ele fez um 12º intervalo, alcançando 382 W.

**Atenção — possível inconsistência interna:** esta passagem usa uma queda de referência de **10%** para avaliar a série retrospectivamente, enquanto a regra prescritiva do Capítulo 5 (nota-0040) usa **5%** de queda a partir do 3º intervalo como critério para decidir parar a série durante o treino. Não fica claro no texto se são critérios propositalmente diferentes (um para decidir parar em tempo real, outro mais tolerante para analisar depois) ou uma inconsistência de edição. Marcada para revisão humana por essa divergência numérica dentro da mesma fonte.

Aplicação ao feedback: ao revisar uma série de intervalos já concluída, comparar a potência do 2º/3º intervalo com a do último para quantificar a queda real ao longo da sessão — essa queda retrospectiva pode usar um limiar mais tolerante (ex.: ~10%) do que o critério prescritivo de parada em tempo real (5%, nota-0040), já que aqui o objetivo é avaliar a sessão como um todo, não decidir se para no meio dela.$m10721$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10722$nota-0069$m10722$, $m10723$Treino de \"força-resistência\" (cadência baixa, marcha pesada) não aumenta força/hipertrofia de forma relevante$m10723$, $m10724$tipos-de-treino$m10724$,
  $m10725$direta$m10725$, $m10726$regra-interpretacao$m10726$,
  ARRAY[$m10727$semanal$m10727$]::text[], ARRAY[$m10728$potência-série-temporal$m10728$, $m10729$cadência$m10729$]::text[],
  0.8, $m10730$ativo$m10730$, $m10731$Intervalos de "força-resistência" (strength endurance), populares especialmente entre triatletas — pedalar por períodos longos (5–20 min) em cadência anormalmente baixa (45–75 rpm) e marcha pesada — são frequentemente promovidos com a alegação de que aumentam força/hipertrofia muscular específica para o ciclismo. Um estudo de laboratório na Nova Zelândia citado pelos autores não encontrou aumento nem de tamanho (antropometria) nem de força máxima (dinamometria isocinética) dos extensores de perna com esse tipo de treino.

Análise via AEPF: mesmo pedalando a 45 rpm (dobrando a AEPF necessária em comparação com cadência normal de 85–90 rpm para a mesma potência), a força efetiva usada nesses intervalos ainda ficava abaixo de 50% da força máxima do atleta — comparável, em termos de carga, a subir escadas com o próprio peso corporal, não a treinamento de força tradicional. O atleta do estudo de caso completou entre 1.125 e 1.800 "repetições" de pedalada nesses intervalos, uma carga incompatível com estímulo de hipertrofia/força.

Também não há evidência clara de que esse tipo de treino recrute mais fibras de contração rápida do que pedalar em cadência normal na mesma zona de potência — a AEPF durante o treino de força-resistência ficava tão distante da força máxima específica daquela velocidade quanto em cadência normal.

Aplicação ao feedback: ao avaliar um plano de treino que inclui blocos de "força-resistência" com expectativa de ganho de força muscular, é importante calibrar a expectativa — o principal benefício desse tipo de treino tende a não ser o ganho de força/hipertrofia (que a evidência citada não sustenta), mas talvez outros efeitos (ex.: familiarização com esforço em marcha pesada).$m10731$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10732$nota-0109$m10732$, $m10733$Protocolo de 'calibração de potência': associar RPE a wattagem específica para pacing em triathlon$m10733$, $m10734$tipos-de-treino$m10734$,
  $m10735$direta$m10735$, $m10736$protocolo$m10736$,
  ARRAY[$m10737$semanal$m10737$, $m10738$mensal$m10738$]::text[], ARRAY[$m10739$potência-média$m10739$, $m10740$esforço-relativo (Relative Effort)$m10740$]::text[],
  0.75, $m10741$ativo$m10741$, $m10742$Protocolo estruturado para treinar a associação entre esforço percebido (RPE) e potência real (wattagem), essencial para pacing em triathlon (onde a FC/RPE no dia da prova tende a ser mais baixa que no treino para o mesmo esforço real):

1. **Fase 1 (curta duração):** 3-4 intervalos de 10 minutos, com 5 minutos de recuperação entre eles, repetidos 5 vezes ao longo de 10 dias, em cada nível de intensidade-alvo.
2. **Fase 2 (duração média):** após repetir a Fase 1 pelo menos duas vezes em cada intensidade, alongar para dois intervalos de 20 minutos por intensidade.
3. **Fase 3 (duração longa):** alongar os esforços para 60 minutos, repetindo pelo menos mais duas vezes por nível de intensidade.

Regra crítica: fazer no máximo uma sessão de calibração por dia — mais de uma sessão no mesmo dia mistura as respostas físicas dos diferentes níveis e prejudica a internalização do RPE correto para cada wattagem. Idealmente repetir sempre na mesma estrada/percurso para minimizar variáveis externas, e registrar anotações após cada sessão.

Aplicação ao feedback: este protocolo é relevante para um produto de feedback que cruza esforço-relativo (Strava) com potência — se o atleta tiver completado uma sequência de sessões com esse padrão, o sistema pode reconhecer isso como um bloco de calibração de pacing e, mais tarde, usar a relação RPE-vs-potência aprendida para validar a estratégia de pacing em provas.$m10742$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;