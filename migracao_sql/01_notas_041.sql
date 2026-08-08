BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5341$nota-0010$m5341$, $m5342$Medidor de potência no cubo (hub) lê 5–10 W a menos que manivela/pedal, por perda de transmissão$m5342$, $m5343$metricas-de-potencia$m5343$,
  $m5344$direta$m5344$, $m5345$regra-interpretacao$m5345$,
  ARRAY[$m5346$diario$m5346$]::text[], ARRAY[$m5347$potência-série-temporal$m5347$]::text[],
  0.85, $m5348$ativo$m5348$, $m5349$Medidores de potência baseados no cubo traseiro medem a potência que efetivamente chega à roda, depois de passar pela corrente/transmissão — por isso registram tipicamente 5–10 W a menos do que um medidor equivalente instalado na manivela, coroa ou pedal, onde a perda mecânica de transmissão ainda não ocorreu.

Aplicação ao feedback: ao comparar dados de potência entre sessões/períodos, verificar se houve troca do tipo/posição do medidor de potência (cubo vs. manivela/pedal) — essa diferença sistemática de 5–10 W pode ser confundida com mudança real de fitness (ex.: FTP aparentemente mais baixo) se não for levada em conta.$m5349$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5350$nota-0011$m5350$, $m5351$Assimetria de força entre pernas (~5%) pode enviesar medidores unilaterais em ~15 W a 300 W de FTP$m5351$, $m5352$metricas-de-potencia$m5352$,
  $m5353$direta$m5353$, $m5354$regra-interpretacao$m5354$,
  ARRAY[$m5355$diario$m5355$]::text[], ARRAY[$m5356$potência-série-temporal$m5356$, $m5357$FTP$m5357$]::text[],
  0.8, $m5358$ativo$m5358$, $m5359$A maioria dos adultos apresenta uma discrepância de força entre as pernas de aproximadamente 5%. Isso é pouco relevante em medidores bilaterais (que somam as duas pernas), mas é crítico em medidores unilaterais (que medem só um lado, ex.: manivela esquerda ou eixo do movimento central) e assumem simetria para dobrar o valor: um viés de 5% equivale a cerca de 15 W de erro quando o FTP é 300 W (proporcionalmente, ~5% do FTP em qualquer faixa).

Aplicação ao feedback: ao interpretar potência/FTP de um atleta cujo equipamento é um medidor unilateral, considerar que os valores podem estar sistematicamente desviados (para cima ou para baixo) em torno de 5%, dependendo de qual perna é mais forte — isso é relevante ao comparar com testes feitos em equipamento bilateral ou ao avaliar mudanças de FTP ao longo do tempo se houver troca de equipamento.$m5359$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5360$nota-0012$m5360$, $m5361$Taxa de gravação (recording rate) deve ser a máxima possível (idealmente 1 s); \"smart recording\" prejudica dados de potência$m5361$, $m5362$metricas-de-potencia$m5362$,
  $m5363$direta$m5363$, $m5364$regra-interpretacao$m5364$,
  ARRAY[$m5365$diario$m5365$]::text[], ARRAY[$m5366$potência-série-temporal$m5366$, $m5367$tempo-movimento$m5367$]::text[],
  0.85, $m5368$ativo$m5368$, $m5369$A taxa de gravação (com que frequência o head unit grava um ponto de dado) deve ser configurada no máximo possível — tipicamente 1 registro por segundo. O modo padrão "smart recording" de alguns head units (ex.: Garmin), otimizado para GPS (grava menos pontos em linha reta, mais em curvas), é inadequado para potência porque descarta grande volume de variação real do sinal de potência entre um ponto e outro.

Aplicação ao feedback: se uma sessão foi gravada com "smart recording" ou taxa reduzida, métricas derivadas que dependem de granularidade fina do sinal (ex.: potência normalizada/NP, pico de 5s, detecção de picos espúrios) podem estar distorcidas ou suavizadas artificialmente — vale sinalizar essa limitação de qualidade de dado antes de interpretar variabilidade ou picos de potência da atividade.$m5369$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5370$nota-0013$m5370$, $m5371$Taxa de exibição (display) recomendada: média móvel de 3–5 s no treino, até 10 s em contrarrelógio$m5371$, $m5372$metricas-de-potencia$m5372$,
  $m5373$direta$m5373$, $m5374$protocolo$m5374$,
  ARRAY[$m5375$diario$m5375$]::text[], ARRAY[$m5376$potência-série-temporal$m5376$]::text[],
  0.85, $m5377$ativo$m5377$, $m5378$Taxa de exibição (display rate) é diferente de taxa de gravação: é a média móvel usada apenas para suavizar o número mostrado na tela do head unit durante o pedal, não afeta o dado bruto gravado. Recomendação dos autores: usar média móvel de 3 ou 5 segundos para cerca de 90% do treino (permite pacing sem "perseguir" cada oscilação instantânea de potência); em contrarrelógio, uma média móvel de 10 segundos pode ser mais útil para manter um ritmo mais constante.

Esta é uma recomendação de configuração de equipamento/prática, não altera os dados armazenados — a gravação em si deve continuar na taxa mais alta possível (ver nota sobre taxa de gravação).

Aplicação ao feedback: por não alterar o dado bruto gravado, a taxa de exibição não interfere na interpretação retrospectiva da atividade — é relevante apenas como orientação de boa prática a repassar ao atleta (ex.: ajustar para média móvel mais curta em treinos intervalados e mais longa em contrarrelógio/provas), não como fator de qualidade de dado a sinalizar em feedback.$m5378$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5379$nota-0014$m5379$, $m5380$Zeragem/calibração do medidor antes de cada saída e após impactos evita erro sistemático de offset em toda a atividade$m5380$, $m5381$metricas-de-potencia$m5381$,
  $m5382$direta$m5382$, $m5383$regra-interpretacao$m5383$,
  ARRAY[$m5384$diario$m5384$]::text[], ARRAY[$m5385$potência-série-temporal$m5385$]::text[],
  0.85, $m5386$ativo$m5386$, $m5387$Medidores de potência precisam ser "zerados" (no jargão de alguns fabricantes como Garmin, chamado de "calibração") antes de cada saída e após qualquer impacto/trauma (ex.: retirar a roda para transportar a bike, queda, batida do pedal/manivela no chão). Se o medidor não for zerado, todo o arquivo da atividade fica deslocado por um valor constante (offset) — os autores citam um exemplo real de um deslocamento de +23 W em toda a sessão por esquecimento de zeragem.

Aplicação ao feedback: um recorde pessoal de potência (pico, média, NP) que se destoa muito do histórico do atleta — sem explicação de contexto (ex.: teste, prova) — deve levantar suspeita de erro de calibração/zeragem antes de ser interpretado como ganho real de fitness. Esse é um erro sistemático (afeta toda a atividade igualmente), diferente de picos isolados de amostra única (ver nota sobre não confiar em amostra única).$m5387$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;