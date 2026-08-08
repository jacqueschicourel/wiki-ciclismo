BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3184$nota-0228$m3184$, $m3185$Tabela de contribuição percentual de cada sistema energético (fosfocreatina, glicogênio anaeróbio/aeróbio, glicose sanguínea, triacilglicerol) por duração de evento, de 100m a prova de 24h$m3185$, $m3186$fisiologia$m3186$,
  $m3187$contexto$m3187$, $m3188$referencia$m3188$,
  ARRAY[$m3189$mensal$m3189$]::text[], '{}'::text[],
  0.6, $m3190$revisar$m3190$, $m3191$Tabela de referência (Newsholme et al. 1992, citada por McArdle, assume corredor de 70 kg) para a contribuição percentual de cada via energética à geração total de ATP, por duração de prova de corrida — usada aqui como referência geral de janelas de duração (o princípio se estende por analogia a esforços de ciclismo de duração equivalente, embora os números tenham sido derivados de corrida):

| Evento | Fosfocreatina | Glicogênio (anaeróbio) | Glicogênio (aeróbio) | Glicose sanguínea | Triacilglicerol (gordura) |
|---|---|---|---|---|---|
| 100 m | 50% | 50% | — | — | — |
| 200 m | 25% | 65% | 10% | — | — |
| 400 m | 12,5% | 62,5% | 25% | — | — |
| 800 m | 6% | 50% | 44% | — | — |
| 1500 m | mínima | 25% | 75% | — | — |
| 5000 m | mínima | 12,5% | 87,5% | — | — |
| 10.000 m | mínima | 3% | 97% | — | — |
| Maratona | — | — | 75% | 5% | 20% |
| Ultramaratona (80 km) | — | — | 35% | 5% | 60% |
| Prova de 24h | — | — | 10% | 2% | 88% |

Padrão claro: quanto mais curto o evento, maior a dependência de fosfocreatina e glicólise anaeróbia; conforme a duração aumenta além de ~10-15 minutos, a contribuição aeróbia (glicogênio, depois progressivamente gordura) domina, com a gordura (triacilglicerol) tornando-se o combustível majoritário em provas de ultra-endurance (>6-8h).

Confiança rebaixada (0,6) e status `revisar`: a tabela vem de uma única fonte primária (Newsholme et al. 1992) aplicada a corrida, extrapolada aqui por analogia a durações equivalentes de ciclismo — os percentuais exatos podem diferir por modalidade (a economia/eficiência do ciclismo difere da corrida) e não foram validados especificamente para pedal.

Aplicação ao feedback: fora do escopo de aplicação direta (não há sinal do Strava que meça fontes de combustível), mas útil como tabela de referência para explicar, em texto educativo, por que esforços de diferentes durações (ex.: um sprint de 15s vs. uma prova de 6h) dependem de sistemas energéticos tão diferentes — reforça, com números específicos, a lógica de especificidade de treino por duração-alvo já presente no cânone (nota-0042, nota-0043).$m3191$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3192$nota-0229$m3192$, $m3193$Déficit de oxigênio: no início do exercício, o consumo de O2 sobe exponencialmente até atingir o steady-rate em ~3-4min; atletas treinados atingem esse platô mais rápido, com déficit menor$m3193$, $m3194$fisiologia$m3194$,
  $m3195$contexto$m3195$, $m3196$conceito$m3196$,
  ARRAY[$m3197$mensal$m3197$]::text[], '{}'::text[],
  0.7, $m3198$ativo$m3198$, $m3199$Quando o exercício começa em intensidade constante (steady-rate), o consumo de oxigênio não sobe instantaneamente ao nível necessário — ele sobe exponencialmente ("componente rápido") e só atinge um platô estável entre o 3º e o 4º minuto. Esse atraso inicial é chamado de **déficit de oxigênio**: a diferença entre o oxigênio total consumido no início do exercício e o que teria sido consumido se o steady-rate tivesse sido atingido instantaneamente. Esse déficit é suprido pelos sistemas anaeróbios (fosfagênio + glicólise rápida) até que a produção aeróbia de energia alcance o requerimento energético do exercício. Fosfatos de alta energia se depletam substancialmente durante essa fase, gerando tipicamente um déficit de 3-4 L de oxigênio.

Diferença por nível de treino: **atletas treinados em endurance atingem o steady-rate mais rapidamente e com um déficit de oxigênio menor** do que atletas de potência/sprint, cardiopatas, idosos ou indivíduos destreinados. Essa cinética aeróbia mais rápida permite ao atleta treinado consumir uma fração maior de oxigênio total já na fase inicial do esforço, tornando proporcionalmente menor a contribuição anaeróbia (e, portanto, o acúmulo de lactato/fadiga) para o mesmo esforço. Três adaptações de treino explicam essa resposta mais rápida: (1) aumento mais rápido da bioenergética muscular, (2) aumento do débito cardíaco, (3) fluxo sanguíneo regional desproporcionalmente maior para o músculo ativo, combinado a adaptações celulares.

Este é o fundamento fisiológico de por que o **aquecimento gradual** (rampa de intensidade no início de uma sessão) reduz a dependência anaeróbia/acúmulo de lactato numa arrancada: um atleta mais aeróbio treinado "liga" o sistema oxidativo mais rápido mesmo em esforços de início abrupto.

Depende de medição de laboratório (VO2 em tempo real, não disponível no Strava), portanto classificada como contexto — mas é uma base fisiológica útil para explicar por que arrancadas/começos fortes de prova pesam desproporcionalmente mais em atletas menos aeróbios.$m3199$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3200$nota-0230$m3200$, $m3201$Fórmula da eficiência mecânica (% = trabalho externo ÷ gasto energético × 100): 20-25% em ciclismo estacionário, cai abaixo de 20% no ciclismo de estrada por causa do arrasto aerodinâmico$m3201$, $m3202$fisiologia$m3202$,
  $m3203$contexto$m3203$, $m3204$referencia$m3204$,
  ARRAY[$m3205$mensal$m3205$]::text[], '{}'::text[],
  0.75, $m3206$ativo$m3206$, $m3207$**Fórmula: Eficiência mecânica (%) = Trabalho externo realizado ÷ Gasto energético total × 100.** Representa a fração da energia química total gasta que efetivamente se converte em trabalho externo mensurável — o restante se perde como calor (atrito interno/externo).

Exemplo numérico do livro (15 min em bicicleta estacionária): trabalho realizado = 13.300 kg-m (equivalente a 31,19 kcal, usando 426,4 kg-m por kcal); oxigênio consumido = 25 L com RQ=0,88 (equivalente a 4,9 kcal/L de O2, logo 122,5 kcal de gasto energético total). Eficiência mecânica = 31,19 ÷ 122,5 × 100 = **25,5%**.

Faixas de referência: em média, a eficiência mecânica fica entre **20-25%** para caminhada, corrida e ciclismo estacionário (sem resistência de arrasto). Ela **cai abaixo de 20%** em atividades com força de arrasto substancial contra o movimento — especificamente citado: **ciclismo de estrada**, esqui cross-country, patinação no gelo, remo e natação — porque parte da energia é gasta vencendo resistência aerodinâmica/hidrodinâmica em vez de ser convertida em trabalho útil mensurável no sentido clássico. Isso é consistente com o foco competitivo em aerodinâmica (posição, equipamento) no ciclismo de estrada e contrarrelógio, já registrado no cânone (nota-0003).

Aplicação ao feedback: não há sinal direto do Strava para calcular gasto energético total (requer VO2/calorimetria), então a fórmula em si não é executável automaticamente — mas fundamenta, de forma quantitativa, por que investimentos em aerodinâmica têm retorno desproporcional no ciclismo de estrada comparado a atividades sem arrasto significativo (nota-0003), e por que a "eficiência" de um ciclista não é fixa nem comparável 1:1 entre modalidades.$m3207$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;