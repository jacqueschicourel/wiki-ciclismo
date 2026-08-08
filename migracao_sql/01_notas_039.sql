BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4952$nota-0247$m4952$, $m4953$Protocolo de polimento (taper): redução exponencial de volume de 40-60% por 1-3 semanas mantendo a intensidade produz ganho de desempenho de 0,5 a 6,0%$m4953$, $m4954$metodologia-e-periodizacao$m4954$,
  $m4955$direta$m4955$, $m4956$protocolo$m4956$,
  ARRAY[$m4957$mensal$m4957$]::text[], ARRAY[$m4958$TSS$m4958$, $m4959$tempo-movimento$m4959$, $m4960$IF$m4960$]::text[],
  0.65, $m4961$revisar$m4961$, $m4962$McArdle resume evidência sobre o período de polimento (taper) pré-competitivo: um taper de **1 a 3 semanas** que reduz o volume de treino de forma **exponencial em 40 a 60%**, mantendo a **intensidade** em nível moderado a alto, representa a estratégia mais eficiente para maximizar ganhos de desempenho. Um taper de **4 a 7 dias** já é suficiente para permitir reposição máxima de glicogênio muscular e hepático, suporte nutricional ótimo, alívio de dor muscular residual e cicatrização de pequenas lesões.

Resultado esperado: melhora de desempenho de **0,5 a 6,0%** com polimento adequado. O taper não está associado a mudanças substanciais no estresse oxidativo induzido pelo exercício.

Achado complementar (mesma seção, mesmo estudo com corredores): comparando repouso total, corrida de baixa intensidade (60% VO2máx) e corrida de alta intensidade com volume reduzido durante o taper, a condição de **alta intensidade com volume reduzido** produziu os melhores resultados (maior volume plasmático, massa de hemácias, conteúdo de glicogênio muscular, atividade mitocondrial e desempenho em prova de 1500m) — reforçando que **reduzir volume enquanto mantém intensidade** supera reduzir ambos ou apenas descansar.

Pouca melhora ocorre nos sistemas aeróbios durante a temporada competitiva propriamente dita; o objetivo do treino nessa fase é evitar deterioração fisiológica e de desempenho, não gerar novos ganhos — o taper é a ferramenta para "colher" as adaptações já acumuladas.

Aplicação ao feedback: regra acionável na camada mensal ao se aproximar de uma competição-alvo — verificar se o TSS/volume (tempo-movimento) semanal está sendo reduzido em 40-60% na semana(s) final(is) antes do evento, enquanto o IF médio das sessões remanescentes permanece moderado a alto (não caindo junto com o volume). Se o atleta mantém volume alto até poucos dias antes da prova, ou reduz intensidade junto com volume, o feedback pode sinalizar que o padrão de taper não corresponde ao protocolo com melhor evidência de ganho de desempenho (0,5-6,0%).$m4962$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4963$nota-0249$m4963$, $m4964$Treino concorrente: sessão de endurance intensa inibe o desempenho de força na sessão subsequente — recomenda-se 20-30 min de recuperação entre componentes aeróbio e de força$m4964$, $m4965$metodologia-e-periodizacao$m4965$,
  $m4966$contexto$m4966$, $m4967$conceito$m4967$,
  ARRAY[$m4968$diario$m4968$, $m4969$semanal$m4969$]::text[], '{}'::text[],
  0.5, $m4970$revisar$m4970$, $m4971$Existe debate na literatura sobre se o treino concorrente (resistência + aeróbio) produz menor ganho de força e potência muscular do que treinar apenas força. Parte da evidência aponta para mecanismos moleculares antagônicos entre os dois modos de exercício em nível de sinalização intracelular, que poderiam prejudicar a resposta adaptativa do músculo ao treino de força; o treino de endurance também pode inibir a sinalização para a maquinaria de síntese proteica muscular.

Mais diretamente relevante: um **bout agudo de atividade de endurance intensa inibe o desempenho em atividades de força subsequentes na mesma sessão**. Como ainda não está definido se esse efeito agudo sobre a produção máxima de força limita a capacidade de sobrecarregar o músculo de forma ótima a ponto de prejudicar o desenvolvimento de força a longo prazo, os autores sugerem como precaução prática: **20 a 30 minutos de recuperação entre os componentes aeróbio e de força** de uma sessão combinada, o que pode melhorar a qualidade do treino de força subsequente.

Nota (achado em direção oposta, mesmo capítulo): outro estudo mostrou que resistance exercise realizado *após* exercício de endurance (1h de ciclismo a ~65% VO2máx seguido de 6 séries de leg press a 70-80% 1RM) na verdade **amplificou** a sinalização adaptativa de biogênese mitocondrial em comparação com endurance isolado — sugerindo que treino concorrente pode beneficiar a adaptação oxidativa muscular. Ou seja, a direção do efeito de interferência (negativo para força vs. potencialmente positivo para adaptação aeróbia) parece depender do desfecho medido, reforçando cautela contra generalizações simples sobre "treino concorrente é sempre prejudicial".

Aplicação ao feedback: nota de contexto — não gera regra de interpretação de sinal isolado do Strava (o app não distingue automaticamente sessões de força), mas é relevante caso o produto amplie o escopo para orientar o sequenciamento de sessões combinadas de bike + academia no mesmo dia: se o objetivo prioritário do dia é ganho de força, recomenda-se não fazer a sessão de força imediatamente após um treino de bike intenso sem pelo menos 20-30 min de intervalo (ou preferencialmente em dias/períodos separados).$m4971$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4972$nota-0264$m4972$, $m4973$Pré-resfriamento corporal (imersão em água ~23,5°C por até 60min ou resfriamento da pele em 5-6°C) antes de exercício no calor aumenta a resistência subsequente$m4973$, $m4974$metodologia-e-periodizacao$m4974$,
  $m4975$contexto$m4975$, $m4976$protocolo$m4976$,
  ARRAY[$m4977$semanal$m4977$]::text[], '{}'::text[],
  0.55, $m4978$ativo$m4978$, $m4979$Estratégia de pré-resfriamento corporal antes de exercício em calor, com dois protocolos distintos citados no McArdle:

1. **Imersão em água fria (pré-resfriamento de core)**: até 60 minutos de imersão em água a 23,5°C (74°F) antes do exercício reduz a temperatura central em ~0,7°C, o que aumenta o tempo até exaustão subsequente em ambiente quente e úmido. O tempo até exaustão se relaciona inversamente com a temperatura corporal inicial (quanto mais baixa ao início, mais tempo até exaustão) e diretamente com a taxa de acúmulo de calor durante o exercício.

2. **Resfriamento apenas da pele (sem reduzir o core)**: resfriar a pele em 5-6°C (sem alterar a temperatura central) também reduziu o estresse térmico e **aumentou a distância percorrida em 30 minutos de ciclismo** em condições quentes e úmidas — resultado específico de ciclismo.

Ressalva importante: nem toda forma de pré-resfriamento funciona — aplicar toalhas frias/chuveiro frio na testa e abdômen durante o exercício melhorou a transferência de calor apenas ligeiramente; e o pré-resfriamento não mostrou benefício em um triathlon simulado nem em protocolo de atividades específicas de futebol em condições ambientais normais (não quentes). Ou seja, o benefício parece específico a ambientes de calor significativo, não universal.

Aplicação ao feedback: como o Strava não permite verificar se o atleta fez pré-resfriamento antes da atividade, este protocolo não pode ser detectado automaticamente — mas é conteúdo educativo válido a sugerir como estratégia pré-prova para eventos de ciclismo em calor (`temperatura` prevista alta), especialmente contrarrelógios ou provas de intensidade sustentada onde ganhos de poucos minutos importam.$m4979$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;