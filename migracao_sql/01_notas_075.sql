BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10054$nota-0232$m10054$, $m10055$EPOC (consumo excessivo de oxigênio pós-exercício): componente rápido resolve em 2-4min após esforço leve; componente lento pode levar até 24h após esforço supermáximo intermitente$m10055$, $m10056$recuperacao-e-fadiga$m10056$,
  $m10057$contexto$m10057$, $m10058$conceito$m10058$,
  ARRAY[$m10059$diario$m10059$]::text[], '{}'::text[],
  0.7, $m10060$ativo$m10060$, $m10061$Após o exercício, o consumo de oxigênio não retorna instantaneamente ao nível de repouso — esse excesso de consumo de oxigênio na recuperação é o **EPOC (excess postexercise oxygen consumption)**, termo atual para o que classicamente se chamava "dívida de oxigênio". EPOC = oxigênio total consumido na recuperação − oxigênio que seria consumido em repouso no mesmo período.

EPOC tem dois componentes com dinâmicas muito diferentes:

1. **Componente rápido**: após atividade aeróbia leve e de curta duração, cerca de metade do EPOC total é "pago" nos primeiros 30 segundos, com recuperação completa em **2-4 minutos** — decaimento exponencial de componente único.
2. **Componente lento**: após atividade extenuante (grande acúmulo de lactato, elevação de temperatura corporal e de hormônios termogênicos), existe uma segunda fase de recuperação mais lenta que, dependendo da intensidade/duração do esforço anterior, **pode levar até 24 horas** para retornar ao consumo de oxigênio pré-exercício. Mesmo blocos intermitentes curtos de esforço "supermáximo" (ex.: três blocos de 2min a 108% do VO2max com 3min de descanso entre eles) mantêm o consumo de oxigênio de recuperação elevado por **1 hora ou mais**.

Atletas treinados apresentam uma taxa de recuperação do consumo de oxigênio mais rápida (tanto em intensidade absoluta quanto relativa) do que não treinados — provavelmente as mesmas adaptações que aceleram o "steady-rate" no início do exercício (nota-0229) também aceleram a recuperação.

Este é um mecanismo fisiológico que depende de medição laboratorial de VO2 (não disponível no Strava), por isso permanece como nota de contexto — mas fundamenta por que esforços muito intensos (ex.: séries de VO2max, provas curtas e extenuantes) geram um "custo metabólico residual" que pode se estender por horas além do fim da atividade registrada, distinto do simples TSS/carga mecânica do treino.$m10061$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10062$nota-0233$m10062$, $m10063$Recuperação ativa em intensidade baixa (~30-40% VO2max) remove lactato sanguíneo mais rápido que repouso passivo; recuperação em alta intensidade (>65% VO2max) não traz vantagem e pode prolongar a remoção$m10063$, $m10064$recuperacao-e-fadiga$m10064$,
  $m10065$contexto$m10065$, $m10066$conceito$m10066$,
  ARRAY[$m10067$diario$m10067$]::text[], '{}'::text[],
  0.6, $m10068$revisar$m10068$, $m10069$Estudo em cicloergômetro com homens treinados, após 6 minutos de exercício supermáximo: comparando recuperação ativa (40 min de pedalada contínua a 35% ou a 65% do VO2max) com recuperação passiva, os resultados mostraram que:

- **Recuperação ativa em intensidade moderada-baixa (~35% VO2max) remove lactato sanguíneo mais rápido que a recuperação passiva.**
- **Recuperação ativa acima do limiar de lactato (~65% VO2max) não traz vantagem alguma e pode até prolongar a recuperação**, porque reinicia a formação e o acúmulo de lactato.
- A intensidade ótima de recuperação ativa provavelmente fica na faixa de **30-40% do VO2max**.

O mecanismo provável: o aumento do fluxo sanguíneo muscular durante a recuperação ativa de baixa intensidade favorece a perfusão de órgãos "consumidores líquidos" de lactato (fígado, coração, músculos inspiratórios) e a oxidação de lactato via ciclo do ácido cítrico no próprio tecido muscular — sem gerar lactato adicional, o que aconteceria em intensidades acima do limiar.

Confiança rebaixada (0,6) e status `revisar`: o achado vem de um único estudo laboratorial (Figura 7.11, cicloergômetro, amostra pequena de homens treinados), medindo lactato sanguíneo (não disponível no Strava).

Aplicação ao feedback: apesar de não ser executável automaticamente pelo Strava (sem lactato sanguíneo), esta é uma faixa de referência útil para orientar a intensidade do "cool-down"/volta à calma após esforços muito intensos (ex.: pós-prova, pós-série de VO2max) — sugerir uma pedalada leve, não parar totalmente nem continuar em intensidade moderada-alta, é consistente com esta evidência (30-40% do VO2max é aproximadamente Zona 1 baixa/recuperação ativa na maioria dos modelos de zona por potência).$m10069$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10070$nota-0242$m10070$, $m10071$'Janela aberta' de 3-72h após esforço muito longo/intenso eleva risco de infecção respiratória (URTI) nas 1-2 semanas seguintes — curva em J volume/intensidade x risco$m10071$, $m10072$recuperacao-e-fadiga$m10072$,
  $m10073$direta$m10073$, $m10074$regra-interpretacao$m10074$,
  ARRAY[$m10075$diario$m10075$, $m10076$semanal$m10076$]::text[], ARRAY[$m10077$TSS$m10077$, $m10078$tempo-decorrido$m10078$, $m10079$esforço-relativo (Relative Effort)$m10079$]::text[],
  0.65, $m10080$revisar$m10080$, $m10081$Modelo da "curva em J": a relação entre volume/intensidade de exercício e risco de infecção do trato respiratório superior (URTI, sigla em inglês) não é linear. Atividade física leve a moderada **reduz** o risco de URTI e outras doenças comparado a um estilo de vida sedentário (a "perna esquerda" da curva em J, abaixo da linha de base). Porém, uma sessão de treino muito intensa ou muito longa (ex.: maratona, prova ou treino excepcionalmente exigente) abre uma **"janela aberta"** de 3 a 72 horas de redução da resistência antiviral/antibacteriana, elevando o risco de URTI que se manifesta dentro de 1 a 2 semanas seguintes.

Dado quantificado de um estudo com participantes de uma maratona em Los Angeles: **13%** relataram episódio de infecção respiratória na semana seguinte à prova, contra apenas **2%** entre corredores de nível comparável que não competiram (por motivos não relacionados a doença). Ou seja, um evento único de esforço extremo elevou o risco de infecção em ~6,5x na semana seguinte.

Importante: atividade moderada não piora a gravidade/duração de uma infecção já instalada — o efeito negativo é específico de esforços muito longos/intensos (tipicamente provas de endurance ou treinos excepcionalmente exigentes), não do treino regular.

Aplicação ao feedback: quando o Strava registrar uma sessão com TSS muito acima do habitual do atleta (ex.: prova longa, evento fora do padrão, TSS "excepcional" — pico isolado muito acima da faixa normal de treino), ou duração/esforço relativo muito superiores ao normal, o feedback pode incluir um aviso de que as próximas 3-72h representam uma janela de maior vulnerabilidade a resfriados/infecções respiratórias, e que sinais de mal-estar nas 1-2 semanas seguintes podem estar relacionados ao esforço, reforçando a importância de sono, nutrição e higiene nesse período — não apenas de repouso muscular. Esta regra dispara de eventos isolados de carga excepcional, não do acúmulo crônico de TSB negativo (que já é coberto por nota-0092).$m10081$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;