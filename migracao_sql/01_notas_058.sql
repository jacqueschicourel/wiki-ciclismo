BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7958$nota-0124$m7958$, $m7959$Gráfico de resistência à fadiga: comparar potência de pico fresco vs. após um limiar de kJ de trabalho (e degradação percentual do sprint)$m7959$, $m7960$metricas-de-potencia$m7960$,
  $m7961$direta$m7961$, $m7962$protocolo$m7962$,
  ARRAY[$m7963$mensal$m7963$]::text[], ARRAY[$m7964$potência-máx$m7964$]::text[],
  0.7, $m7965$ativo$m7965$, $m7966$Metodologia para quantificar a resistência à fadiga de um atleta, útil para provas longas (>3h) ou para caracterizar o tipo de velocista:

**Resistência à fadiga de médio/longo prazo:** comparar a melhor potência de 5 e 20 minutos do atleta quando **fresco** (início de um passeio/prova) contra a melhor potência para as mesmas durações **após um limiar de trabalho acumulado** (ex.: após 2.000 kJ). Exemplo do livro: um atleta teve queda de 261W→202W nos 5min e de 241W→187W nos 20min após 2.000 kJ de trabalho prévio — quantificando exatamente o quanto a fadiga acumulada corrói a capacidade de gerar potência.

**Resistência à fadiga do sprint:** plotar a degradação percentual de potência a partir do pico máximo ao longo dos primeiros ~35 segundos de um esforço máximo. Exemplo: um velocista com queda de apenas 20% aos 15s (de 1.274W) e 41% aos 35s (ainda acima de 800W) tem alta resistência à fadiga de sprint — mais adequado a esperar/lançar o sprint de mais longe (~300-600m) do que a competir num sprint curtíssimo.

Aplicação ao feedback: para atletas com dados de provas longas (>3h) recorrentes, calcular a queda percentual de potência de pico (5min/20min) entre o início e o total acumulado de kJ da atividade — um percentual de queda muito maior que o histórico do próprio atleta é um sinal de baixa resistência à fadiga no dia, relevante para explicar um "final fraco" de prova. Para sprints, a curva de degradação percentual pode informar recomendações táticas (lançar sprint de mais longe vs. mais perto da linha).$m7966$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7967$nota-0125$m7967$, $m7968$O 'quase-platô' de potência após 1,5-2,5 minutos de um esforço bem pacing aproxima a potência real de VO2max, sem precisar de teste de laboratório$m7968$, $m7969$metricas-de-potencia$m7969$,
  $m7970$direta$m7970$, $m7971$regra-interpretacao$m7971$,
  ARRAY[$m7972$diario$m7972$]::text[], ARRAY[$m7973$potência-série-temporal$m7973$]::text[],
  0.65, $m7974$ativo$m7974$, $m7975$Ao analisar a curva de potência de um esforço máximo bem-pacing (ex.: perseguição de 3-5 minutos), a potência tende a formar um **"quase-platô"** a partir de aproximadamente **1,5 a 2,5 minutos** do início do esforço. A partir desse ponto, a capacidade anaeróbia (déficit máximo acumulado de oxigênio) já está essencialmente esgotada, e o esforço remanescente passa a ser sustentado quase inteiramente por via aeróbia ("pay as you go"). Esse patamar de potência, portanto, é uma boa aproximação de campo da **potência real do atleta em VO2max**, sem necessidade de teste de laboratório com analisador de gases.

Aplicação ao feedback: em esforços máximos de 3+ minutos bem executados (constantes, sem variação abrupta), identificar o ponto onde a potência estabiliza (deixa de cair rapidamente) entre 1,5-2,5min como estimativa de campo da potência de VO2max do atleta — útil como validação cruzada para o valor de VO2max power já usado nas iLevels/Coggan Classic Levels (Cap.3).$m7975$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7976$nota-0128$m7976$, $m7977$Decomposição das fontes de resistência numa perseguição de pista: aerodinâmica ~85%, inércia ~8%, rolamento ~5%, transmissão/rolamentos ~2%$m7977$, $m7978$metricas-de-potencia$m7978$,
  $m7979$contexto$m7979$, $m7980$referencia$m7980$,
  ARRAY[$m7981$mensal$m7981$]::text[], '{}'::text[],
  0.6, $m7982$ativo$m7982$, $m7983$Para uma perseguição individual de pista (velódromo, 3-4 km), a decomposição aproximada de onde vai a potência produzida pelo atleta é: **~85% para vencer a resistência do ar (aerodinâmica)**, ~8% para vencer a inércia (aceleração), ~5% para resistência ao rolamento, e ~2% para atrito de transmissão/rolamentos.

Aplicação ao feedback: contexto de referência para explicar por que otimização aerodinâmica (posição, equipamento) tem impacto desproporcionalmente maior que outras fontes de resistência em provas de velocidade constante em pista/contrarrelógio — não diretamente aplicável a dados de atividades do Strava, mas útil como justificativa ao recomendar foco em aerodinâmica para esse tipo de prova.$m7983$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7984$nota-0130$m7984$, $m7985$Interpretar arquivo de potência de ciclocross: média 20-40W abaixo da FTP é normal (não indica esforço baixo); 'matches' partem de uma base já alta$m7985$, $m7986$metricas-de-potencia$m7986$,
  $m7987$direta$m7987$, $m7988$regra-interpretacao$m7988$,
  ARRAY[$m7989$diario$m7989$]::text[], ARRAY[$m7990$potência-média$m7990$, $m7991$FTP$m7991$]::text[],
  0.7, $m7992$ativo$m7992$, $m7993$Ao analisar um arquivo de potência de uma prova de ciclocross, a **potência média típica fica 20-40W abaixo da FTP real do atleta** — isso **não indica baixo esforço**. As causas são estruturais ao esporte: muito tempo sem pedalar (descidas técnicas em roda livre, corrida carregando a bicicleta) e perda de tração em barro/areia que reduz a potência transmitida ao solo mesmo com esforço máximo do atleta.

Além disso, o conceito de "match" (esforço acima da FTP, ver notas do Cap.7) tem significado diferente no ciclocross: como o atleta já está tipicamente pedalando perto da própria FTP na maior parte da prova, os "matches" são mais como "labaredas subindo de uma fogueira que já está queimando forte" — ou seja, picos relativamente menores em cima de uma base já alta, e não picos isolados vindos de um ritmo mais baixo (como costuma ocorrer em estrada).

Aplicação ao feedback: ao processar atividades classificadas como ciclocross, não usar o mesmo limiar de "potência média baixa = esforço fraco" aplicado a outras modalidades — potência média 20-40W abaixo da FTP pode representar uma prova de esforço máximo em ciclocross. Ao contar "matches" (picos acima da FTP), considerar que a base de referência já está próxima da FTP, então mesmo picos menores em amplitude podem representar esforços significativos.$m7993$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;