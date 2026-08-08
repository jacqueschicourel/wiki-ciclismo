BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5530$nota-0015$m5530$, $m5531$Picos espúrios de potência (amostra única) devem ser identificados e interpolados antes de usar o pico de 5 s$m5531$, $m5532$metricas-de-potencia$m5532$,
  $m5533$direta$m5533$, $m5534$regra-interpretacao$m5534$,
  ARRAY[$m5535$diario$m5535$]::text[], ARRAY[$m5536$potência-série-temporal$m5536$]::text[],
  0.8, $m5537$ativo$m5537$, $m5538$Erros de leitura pontuais (amostra única) são comuns em medidores de potência — por exemplo, perda momentânea do sinal de cadência, ativação múltipla acidental do sensor de reed switch parado (track stand no farol) ou retomada de pedalada após descida em roda livre. Isso se manifesta como um pico isolado de potência muito acima de qualquer valor fisiologicamente plausível para o atleta (ex.: sequência 213, 234, 242, **1876**, 254, 260, 267 W). A correção recomendada é interpolar o valor espúrio pela média dos pontos vizinhos (no exemplo, ~248 W).

Aplicação ao feedback: antes de usar o pico de potência de 5 segundos (usado como indicador de capacidade neuromuscular/sprint) ou qualquer "recorde" de potência de curtíssima duração, verificar se não se trata de artefato de amostra única — um valor isolado muito acima do padrão do restante do arquivo é sinal de alerta, não necessariamente um esforço real. Diferente do erro de zeragem (nota-0014), que desloca a atividade inteira, este é um erro pontual, de 1 amostra.$m5538$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5539$nota-0016$m5539$, $m5540$Cálculo de médias: potência deve incluir zeros (parado/roda livre); cadência deve excluir zeros$m5540$, $m5541$metricas-de-potencia$m5541$,
  $m5542$direta$m5542$, $m5543$regra-interpretacao$m5543$,
  ARRAY[$m5544$diario$m5544$]::text[], ARRAY[$m5545$potência-média$m5545$, $m5546$cadência$m5546$, $m5547$tempo-movimento$m5547$]::text[],
  0.85, $m5548$ativo$m5548$, $m5549$Regra de cálculo de médias que evita distorções na interpretação: a **potência média** de uma atividade/intervalo deve incluir os períodos em zero watts (parado, roda livre) — isso é informação relevante sobre o padrão real de esforço, incluindo os momentos sem pedalada. Já a **cadência média** deve ser calculada excluindo os períodos sem pedalada (cadência zero), porque incluir esses zeros distorce artificialmente a média para baixo e não reflete a cadência real enquanto o atleta efetivamente pedalava (exemplo do livro: um intervalo de 5 min a 90 rpm com 30 s de roda livre no meio dá média de 81 rpm se os zeros forem incluídos, contra 90 rpm real se excluídos).

Aplicação ao feedback: ao interpretar potência média (para NP/IF/TSS) e cadência média de uma mesma sessão, tratar os dois sinais com convenções diferentes — potência conta tudo, cadência só conta enquanto o atleta pedala.$m5549$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5550$nota-0018$m5550$, $m5551$Cinco métodos de hardware para medir potência e onde cada um mede a força$m5551$, $m5552$metricas-de-potencia$m5552$,
  $m5553$contexto$m5553$, $m5554$conceito$m5554$,
  ARRAY[$m5555$mensal$m5555$]::text[], '{}'::text[],
  0.8, $m5556$ativo$m5556$, $m5557$Os medidores de potência para ciclismo usam cinco abordagens de hardware distintas: (1) sistemas integrados na manivela (spider/eixo, braço da manivela ou coroa) — medem torção no ponto de aplicação da força, mais próximo de onde a potência é gerada; (2) sistemas integrados no cubo traseiro — medem a potência que chega efetivamente à roda, após a transmissão; (3) sensores no eixo do movimento central (bottom bracket) — geralmente unilaterais (só o lado esquerdo torce de forma mensurável); (4) sistemas de "forças opostas" (ex.: PowerPod) — medem resistência do ar/inclinação/peso e inferem a potência aplicada em vez de medi-la diretamente; (5) sensores de força no pedal — medem no ponto exato de transferência entre pé e bicicleta, e são tipicamente bilaterais (esquerda/direita independentes).

Cada abordagem tem implicações práticas de precisão e comparabilidade (posição de medição afeta se o valor inclui ou não perdas de transmissão; medição unilateral vs. bilateral afeta a exposição ao viés de assimetria entre pernas) — ver notas específicas de cada implicação.$m5557$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5558$nota-0019$m5558$, $m5559$Definição de FTP (Functional Threshold Power)$m5559$, $m5560$metricas-de-potencia$m5560$,
  $m5561$direta$m5561$, $m5562$conceito$m5562$,
  ARRAY[$m5563$diario$m5563$, $m5564$semanal$m5564$, $m5565$mensal$m5565$]::text[], ARRAY[$m5566$potência-média$m5566$, $m5567$FTP$m5567$]::text[],
  0.9, $m5568$ativo$m5568$, $m5569$FTP (Functional Threshold Power) é a maior potência que um ciclista consegue manter em quase-estado-estável (quasi-steady state) sem fadigar, o que na prática corresponde a cerca de 1 hora de esforço máximo sustentável em ciclistas bem treinados. Acima do FTP, a fadiga ocorre muito mais rápido; um pouco abaixo do FTP, o esforço pode ser sustentado por bem mais tempo.

FTP é a expressão em watts do limiar de lactate (lactate threshold, LT) — a intensidade em que o lactato sanguíneo começa a se acumular — que é considerado o determinante fisiológico isolado mais importante do desempenho de resistência, porque reflete a fração do VO2máx que o atleta consegue efetivamente sustentar (integra VO2máx, % de VO2máx sustentável e eficiência de pedalada). É por isso que os autores definem todas as zonas de treino como percentual do FTP, e não como percentual do VO2máx ou da FC máxima.

FTP funciona como a referência central (0% a >150%+) a partir da qual todas as zonas de potência do livro (Tabela 3.1) e diversas outras métricas (IF, TSS) são calculadas.

Aplicação ao feedback: usar o FTP cadastrado/estimado do atleta como referência central para classificar a intensidade de qualquer atividade (zonas, IF, TSS) — sem um FTP atualizado, a interpretação de potência de qualquer sessão perde precisão.$m5569$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;