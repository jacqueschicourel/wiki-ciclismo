BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6279$nota-0056$m6279$, $m6280$Xert MPA (Maximal Power Available): modelo de fadiga em tempo real com 3 parâmetros (PP, HIE, TP)$m6280$, $m6281$metricas-de-potencia$m6281$,
  $m6282$contexto$m6282$, $m6283$conceito$m6283$,
  ARRAY[$m6284$diario$m6284$]::text[], ARRAY[$m6285$potência-série-temporal$m6285$, $m6286$FTP$m6286$]::text[],
  0.7, $m6287$revisar$m6287$, $m6288$Xert (ferramenta de terceiros, não desenvolvida pelos autores do livro) introduz o conceito de Maximal Power Available (MPA): quanto de potência o ciclista ainda consegue gerar em um dado instante da atividade, calculado em tempo real a partir de um modelo de fadiga que integra a "Assinatura de Fitness" de 3 parâmetros do atleta: Peak Power (PP — pico de potência de 1 segundo), High Intensity Energy (HIE — aproximadamente a capacidade anaeróbia) e Threshold Power (TP — equivalente ao FTP).

No início de uma atividade, MPA = PP. A cada segundo, o MPA é recalculado com base na potência atual, no trabalho já realizado acima do TP e no trabalho realizado abaixo do TP — funciona como um "medidor de bateria" em tempo real: quanto mais o atleta trabalha acima do limiar, mais o MPA cai (fica mais difícil sustentar potências altas); com esforço mais leve, o MPA se recupera.

Aplicação: permite desenhar intervalos que miram um nível constante de *estresse/fadiga* (não um valor fixo de watts) — por exemplo, num treino de microbursts (nota-0044), os primeiros esforços de um bloco podem começar mais fortes (ex.: 439→363 W) e os últimos mais fracos em valor absoluto (ex.: 340→304 W), mas representando o mesmo nível de estresse fisiológico, porque o MPA já está mais baixo devido à fadiga acumulada.

Nota de confiança: este é um modelo proprietário de terceiros (Xert), citado pelos autores como exemplo de "análise preditiva de potência", não parte do arcabouço central Power Profile/PDC/FRC desenvolvido pelos próprios autores — por isso `aplicacao: contexto` e confiança mais baixa/marcada para revisão, já que a base não teve acesso à documentação completa do modelo Xert, apenas à descrição resumida feita neste livro.$m6288$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6289$nota-0057$m6289$, $m6290$Scatterplots (potência × cadência, balanço esquerda/direita, cadência × velocidade) para identificar padrões$m6290$, $m6291$metricas-de-potencia$m6291$,
  $m6292$direta$m6292$, $m6293$conceito$m6293$,
  ARRAY[$m6294$diario$m6294$, $m6295$mensal$m6295$]::text[], ARRAY[$m6296$potência-série-temporal$m6296$, $m6297$cadência$m6297$, $m6298$velocidade$m6298$]::text[],
  0.75, $m6299$ativo$m6299$, $m6300$Gráficos de dispersão (scatterplot) cruzam dois canais de dados simultaneamente e revelam padrões que médias isoladas escondem:

- **Potência (eixo Y) × cadência (eixo X)**: revela em qual cadência o atleta produz seus maiores picos de potência, e o limite superior de cadência em que ainda consegue gerar potência alta.
- **Balanço de potência esquerda/direita × faixa de potência**: revela se o atleta favorece uma perna em intensidades baixas (ex.: "descansando" uma perna) e passa a depender mais da outra em intensidades altas (VO2máx/Capacidade Anaeróbia), voltando a um padrão diferente em potência neuromuscular — um exemplo do livro mostra um atleta mais dominante na perna esquerda abaixo do FTP, mudando para a direita em VO2máx/Capacidade Anaeróbia, e retornando à esquerda em potência neuromuscular.
- **Cadência (eixo Y) × velocidade (eixo X)**, em contexto de ciclocross: revela o ponto (ex.: ~100–105 rpm) em que o atleta troca de marcha para continuar acelerando — pode indicar necessidade de melhorar a velocidade de pedalada ou de força muscular na marcha mais pesada.

Princípio geral citado pelos autores: fora da aerodinâmica, só existem duas formas de ir mais rápido de bicicleta — pedalar mais forte ou pedalar mais rápido (maior cadência) — e os scatterplots ajudam a identificar qual dessas alavancas (ou combinação) vale mais a pena trabalhar para um atleta específico.

Aplicação ao feedback: ao gerar um scatterplot de potência × cadência (ou balanço esquerda/direita) a partir da série temporal de uma atividade, usar o padrão visual resultante para identificar economia/ineficiência de pedalada, favorecimento de perna ou necessidade de ajuste de marcha — informação que a potência média isolada não revela.$m6300$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6301$nota-0059$m6301$, $m6302$Normalized Power (NP): algoritmo de cálculo e por que substitui a potência média$m6302$, $m6303$metricas-de-potencia$m6303$,
  $m6304$direta$m6304$, $m6305$referencia$m6305$,
  ARRAY[$m6306$diario$m6306$]::text[], ARRAY[$m6307$potência-média$m6307$, $m6308$NP$m6308$]::text[],
  0.95, $m6309$ativo$m6309$, $m6310$Algoritmo de cálculo da Potência Normalizada (Normalized Power, NP), aplicável a trechos de 30 segundos ou mais: (1) calcular a média móvel de 30 segundos da potência ao longo de todo o trecho; (2) elevar cada valor da média móvel à 4ª potência; (3) calcular a média de todos esses valores elevados à 4ª potência; (4) extrair a raiz quarta desse resultado.

Fundamento fisiológico: (a) respostas fisiológicas a mudanças rápidas de intensidade não são instantâneas, seguem um curso temporal previsível (daí a média móvel de 30s); (b) respostas fisiológicas críticas (utilização de glicogênio, produção de lactato, hormônios de estresse) têm relação curvilínea (não linear) com a intensidade do exercício — daí elevar à 4ª potência antes de tirar a média, o que pondera desproporcionalmente os picos de intensidade.

Interpretação prática: NP é a potência que o atleta teria sustentado, em média, se tivesse pedalado de forma perfeitamente constante (ex.: num ergômetro estacionário) para gerar o mesmo custo fisiológico do esforço real e variável que ele fez. É por isso que NP é sempre igual ou maior que a potência média — quanto mais variável o esforço, maior a diferença entre NP e potência média.

NP costuma ser semelhante entre provas de mesma duração e dificuldade mesmo quando a potência média difere muito (ex.: criterium tem potência média mais baixa que prova de estrada por causa de curvas/soft-pedaling, mas NP das duas costuma ser parecida) — por isso NP de provas de pelotão de ~1h pode ser usado como estimativa inicial de FTP (ver nota-0025, método 3).

Aplicação ao feedback: ao resumir ou comparar sessões, preferir NP à potência média bruta sempre que o esforço tiver variabilidade relevante (grupo, terreno, corrida) — NP representa melhor o custo fisiológico real e é a base de cálculo de IF e TSS.$m6310$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;