BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m409$nota-0032$m409$, $m410$As quatro durações-índice do Power Profile e a capacidade fisiológica que cada uma reflete$m410$, $m411$avaliacao-e-testes$m411$,
  $m412$direta$m412$, $m413$conceito$m413$,
  ARRAY[$m414$mensal$m414$]::text[], ARRAY[$m415$potência-máx$m415$]::text[],
  0.85, $m416$ativo$m416$, $m417$O Power Profile usa 4 durações de esforço máximo como proxy (índice) de 4 capacidades fisiológicas diferentes:

- **5 segundos** → potência neuromuscular
- **1 minuto** → capacidade anaeróbia (embora não seja um esforço puramente anaeróbio: ~40–45% da energia gasta nesse esforço vem de fontes aeróbias, e a capacidade anaeróbia geralmente requer 1,5–2,5 min para se esgotar completamente)
- **5 minutos** → VO2máx (embora não seja exatamente 100% do VO2máx: a maioria dos atletas consegue sustentar por 5 min uma potência que exigiria 105–110% do seu VO2máx)
- **potência no FTP** → limiar de lactato (LT)

Essas durações foram escolhidas por correlacionarem bem com medições mais diretas dessas capacidades, além de serem práticas e reprodutíveis para coleta de dados de campo (sem precisar de laboratório).

Aplicação ao feedback: ao interpretar os picos de potência de 5 s, 1 min e 5 min de uma atividade ou de um histórico, mapear cada duração para a capacidade fisiológica correspondente listada acima antes de tirar conclusões sobre pontos fortes/fracos do atleta.$m417$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m418$nota-0034$m418$, $m419$Protocolo de teste de campo para o Power Profile (5 s, 1 min, 5 min all-out)$m419$, $m420$avaliacao-e-testes$m420$,
  $m421$direta$m421$, $m422$protocolo$m422$,
  ARRAY[$m423$mensal$m423$]::text[], ARRAY[$m424$potência-máx$m424$]::text[],
  0.8, $m425$ativo$m425$, $m426$Protocolo de teste de campo para preencher o Power Profile (junto com o resultado do teste de FTP do Capítulo 3): realizar em um trecho de estrada sem interrupções (sinais, cruzamentos) que possa ser reutilizado em retestes futuros, em condições semelhantes (vento, clima, fase de treino) e de preferência logo após uma semana de descarga (fresco e relativamente em forma).

Aquecimento: mesma rotina sempre, majoritariamente em Nível 2/3 (Endurance/Tempo), com pelo menos 10 minutos de pedalada leve antes do primeiro esforço. Esforços de teste: sem se preocupar com cadência, FC ou qualquer outro dado — o único objetivo é produzir o máximo de watts possível durante cada intervalo cronometrado (registrar cada esforço como um "intervalo" marcado no medidor de potência). Volta à calma: pelo menos 300–500 kJ de trabalho em Nível 2.

Depois de baixar os dados, extrair a melhor potência média para cada uma das durações testadas (5 s, 1 min, 5 min) e localizar os valores na Tabela 4.1 (Power Profile, nota-0031) junto com o FTP (do teste do Capítulo 3).

Aplicação ao feedback: ao identificar no arquivo do Strava os melhores picos de potência de 5 s, 1 min e 5 min de uma sessão de teste dedicada (marcada como tal pelo atleta ou inferida por contexto), usar esses valores para atualizar o Power Profile do atleta — não confundir esforços de teste com picos incidentais de uma sessão de treino/prova comum.$m426$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m427$nota-0038$m427$, $m428$Revisar o Power Profile a cada 4–6 semanas$m428$, $m429$avaliacao-e-testes$m429$,
  $m430$direta$m430$, $m431$regra-interpretacao$m431$,
  ARRAY[$m432$mensal$m432$]::text[], ARRAY[$m433$potência-máx$m433$]::text[],
  0.75, $m434$ativo$m434$, $m435$Os autores recomendam revisar o Power Profile (Tabela 4.1) a cada 4–6 semanas, comparando com o bloco de treino anterior, para verificar se o treino está de fato produzindo mudanças nas áreas pretendidas. Cadência um pouco mais frequente do que a recomendação de reteste de FTP isolado (6–8 semanas, nota-0021), já que o Power Profile cobre 4 durações diferentes e pode capturar progresso mais cedo em capacidades específicas (ex.: neuromuscular, anaeróbia) mesmo antes de uma mudança perceptível de FTP.

Aplicação ao feedback: ao gerar feedback mensal, verificar se já se passaram 4–6 semanas desde a última atualização do Power Profile do atleta e, se sim, sinalizar a necessidade de retestá-lo (ou recalculá-lo a partir dos melhores picos recentes de 5s/1min/5min/FTP) para capturar progresso específico por capacidade.$m435$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m436$nota-0051$m436$, $m437$Estimar a FC de limiar (FTHR) pelo degrau no gráfico de distribuição de frequência cardíaca$m437$, $m438$avaliacao-e-testes$m438$,
  $m439$direta$m439$, $m440$protocolo$m440$,
  ARRAY[$m441$mensal$m441$]::text[], ARRAY[$m442$FC$m442$]::text[],
  0.75, $m443$ativo$m443$, $m444$Assim como é possível estimar o FTP pelo "degrau" no gráfico de distribuição de tempo por faixa de potência (nota-0025), é possível estimar a FC de limiar funcional (FTHR) de forma análoga: analisar um conjunto de dados grande o suficiente que inclua tempo gasto em e acima do FTP, configurar o gráfico de distribuição de FC em faixas (bins) de 3 a 5 batimentos por minuto, e procurar o ponto de queda brusca na quantidade de tempo — esse é o valor aproximado da FTHR.

Aplicação ao feedback: quando não houver teste de FC de limiar dedicado, mas houver histórico suficiente de FC durante esforços de intensidade alta, esse método permite estimar a FTHR sem teste formal, complementando a estimativa de FTP.$m444$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;