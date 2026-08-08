BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6946$nota-0078$m6946$, $m6947$FRC (Functional Reserve Capacity): capacidade em joules acima do FTP; fórmula e exemplo numérico completo$m6947$, $m6948$metricas-de-potencia$m6948$,
  $m6949$direta$m6949$, $m6950$referencia$m6950$,
  ARRAY[$m6951$mensal$m6951$]::text[], ARRAY[$m6952$potência-máx$m6952$, $m6953$FTP$m6953$]::text[],
  0.85, $m6954$ativo$m6954$, $m6955$FRC (Functional Reserve Capacity) é a quantidade total de trabalho (em joules) que o atleta consegue realizar continuamente acima do FTP até a exaustão — diferente da maioria das métricas de potência (que são taxas, watts = joules/segundo), FRC é uma medida de **capacidade** (quantidade fixa de energia), não de taxa. É análoga à Capacidade Anaeróbia do Power Profile clássico, mas reconhece que a fronteira entre sistemas aeróbio/anaeróbio não é discreta.

Analogia usada pelo livro: FRC funciona como a bateria de um carro híbrido — o motor a gasolina (sistema aeróbio/FTP) fornece a maior parte da energia continuamente, e a bateria (FRC) complementa quando necessário, mas descarrega rápido; com repouso (ou esforço abaixo do FTP), a "bateria" recarrega, mas não instantaneamente — recarrega mais devagar se o descanso for logo abaixo do FTP, e mais rápido se for descanso completo.

**Fórmula prática: potência sustentável acima do FTP = FRC (J) ÷ duração do esforço (s).** Potência total sustentável = FTP + (FRC ÷ duração).

Exemplo numérico completo do livro (FTP = 300 W, FRC = 20.000 J):
- Esforço de 30 s: 20.000 ÷ 30 = 666,7 W acima do FTP → sustenta 300 + 667 ≈ 967 W
- Esforço de 120 s: 20.000 ÷ 120 = 166,7 W acima do FTP → sustenta 300 + 167 = 467 W
- Esforço de 180 s: 20.000 ÷ 180 = 111 W acima do FTP → sustenta 300 + 111 = 411 W
- Esforço de 30 min: 20.000 ÷ 1800 ≈ 11 W acima do FTP → sustenta apenas 300 + 11 = 311 W

Conclusão prática direta do exemplo: quanto mais longa a duração do esforço, menor a contribuição relativa da FRC — para esforços de mais de poucos minutos, treinar para aumentar o FTP compensa muito mais do que treinar para aumentar a FRC.

Aplicação ao feedback: usar a FRC (quando modelada) para estimar quanto de potência acima do FTP um atleta ainda consegue sustentar para uma duração-alvo específica (ex.: planejar quantos watts acima do FTP são viáveis num ataque de 30s vs. 3min) — mais preciso do que assumir uma queda percentual fixa para todas as durações.$m6955$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6956$nota-0079$m6956$, $m6957$mFTP (no modelo Potência-Duração): o ponto onde a curva se achata — não necessariamente aos 60 minutos exatos$m6957$, $m6958$metricas-de-potencia$m6958$,
  $m6959$direta$m6959$, $m6960$conceito$m6960$,
  ARRAY[$m6961$mensal$m6961$]::text[], ARRAY[$m6962$potência-máx$m6962$, $m6963$FTP$m6963$]::text[],
  0.8, $m6964$ativo$m6964$, $m6965$No modelo Potência-Duração, o **mFTP (modeled FTP)** é definido como o nível de potência no qual a curva ajustada se achata horizontalmente (o "platô" da curva) — não é definido por uma janela de tempo fixa de exatamente 60 minutos. Esse ponto de achatamento pode corresponder, dependendo do atleta e de sua fitness, a um esforço máximo de ~45, ~60 ou até ~75 minutos — mas, em média, para a maioria dos atletas, ainda fica em torno de 1 hora.

Contexto histórico sobre por que a convenção de 60 minutos existiu: antes do Power Profile e do modelo Potência-Duração, "limiar" era um termo vago com mais de 30 definições cientificamente validadas na literatura (limiar de lactato, limiar anaeróbio, limiar ventilatório, etc.), o que gerava confusão. Fixar o FTP como "a potência sustentável por ~1 hora" resolveu 3 problemas práticos: eliminou a necessidade de teste laboratorial, padronizou a definição de limiar entre praticantes, e tornou o "limiar" uma métrica de desempenho prática e mensurável. A Potência Crítica (CP, ver nota-0026) é um método alternativo relacionado, com valor de potência próximo ao FTP mas tipicamente sustentável por 40–75 minutos.

Aplicação ao feedback: se o mFTP de um atleta (ponto de achatamento real da curva) corresponde a uma duração bem diferente de 60 minutos, isso é uma característica individualizante válida (não um erro) — pode ser usado, junto com outras métricas do modelo Potência-Duração, para descrever o perfil único daquele atleta (ver nota-0080 sobre Time to Exhaustion).$m6965$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6966$nota-0080$m6966$, $m6967$TTE (Time to Exhaustion): quanto tempo o atleta sustenta o próprio mFTP — dois atletas com mFTP igual podem ter TTE muito diferente$m6967$, $m6968$metricas-de-potencia$m6968$,
  $m6969$direta$m6969$, $m6970$conceito$m6970$,
  ARRAY[$m6971$mensal$m6971$]::text[], ARRAY[$m6972$potência-média$m6972$, $m6973$FTP$m6973$]::text[],
  0.8, $m6974$ativo$m6974$, $m6975$TTE (Time to Exhaustion) é a duração que o atleta consegue de fato sustentar seu próprio mFTP antes de fadigar completamente. É uma métrica complementar ao mFTP: dois atletas podem ter Pmax e mFTP praticamente idênticos, mas TTEs bem diferentes — exemplo do livro: dois ciclistas com Pmax ~1.300 W e mFTP ~320 W, um com TTE de 34:23 e o outro de 52:40. O primeiro tem uma curva Potência-Duração que cai mais rápido e mais cedo depois do platô do mFTP; o segundo sustenta o mesmo nível de potência por bem mais tempo.

Aplicação ao feedback: dois atletas com o "mesmo FTP" (no sentido tradicional) podem ter capacidades de resistência à fadiga muito diferentes em provas longas — TTE captura essa diferença que o FTP sozinho não revela, sendo relevante para prever/explicar performance em eventos de duração próxima ou superior ao mFTP do atleta.$m6975$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6976$nota-0081$m6976$, $m6977$Stamina: % de resistência à fadiga em esforços sub-FTP prolongados; maioria dos atletas fica entre 75-85%$m6977$, $m6978$metricas-de-potencia$m6978$,
  $m6979$direta$m6979$, $m6980$referencia$m6980$,
  ARRAY[$m6981$mensal$m6981$]::text[], ARRAY[$m6982$potência-média$m6982$, $m6983$FTP$m6983$]::text[],
  0.75, $m6984$ativo$m6984$, $m6985$Stamina, no modelo Potência-Duração, é uma métrica de resistência à fadiga em exercício prolongado de intensidade moderada (abaixo do FTP) — corresponde à "cauda" da Curva de Potência-Duração além do ponto de mFTP, onde a curva se achata uma segunda vez. Expressa como percentual: 100% indicaria (teoricamente) que o atleta nunca fadigaria em intensidade sub-FTP; um score abaixo de 50% indica fadiga rápida mesmo em intensidade sub-limiar. A maioria dos ciclistas fica na faixa de **75–85%**.

Aplicação ao feedback: acompanhar o Stamina ao longo do tempo serve para monitorar se a capacidade do atleta de manter esforços sub-FTP prolongados (relevante para provas longas, fundo, ultraendurance) está melhorando ou piorando — é uma métrica distinta de FTP/mFTP/TTE, focada especificamente na cauda longa da curva de duração.$m6985$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;