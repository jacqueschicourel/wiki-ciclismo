BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6668$nota-0067$m6668$, $m6669$Quadrant Analysis: os quatro quadrantes força × velocidade e o que cada um representa$m6669$, $m6670$metricas-de-potencia$m6670$,
  $m6671$direta$m6671$, $m6672$regra-interpretacao$m6672$,
  ARRAY[$m6673$diario$m6673$, $m6674$mensal$m6674$]::text[], ARRAY[$m6675$potência-série-temporal$m6675$, $m6676$cadência$m6676$]::text[],
  0.85, $m6677$ativo$m6677$, $m6678$A Quadrant Analysis usa a AEPF (força, eixo Y) e a CPV (velocidade, eixo X) calculadas no FTP do atleta (na cadência autosselecionada) como linhas divisórias para separar todo o arquivo de potência de uma atividade em 4 quadrantes:

- **Quadrante I (superior direito): alta força e alta velocidade.** No extremo, é o sprint; também inclui praticamente qualquer esforço supra-limiar estendido em terreno plano (ataque, tentativa de alcançar uma fuga). Provas de pista com largada em massa (ex.: prova por pontos) envolvem bastante pedalada nesse quadrante, por causa do caráter agressivo e do uso de marcha fixa.
- **Quadrante II (superior esquerdo): alta força, baixa velocidade.** Típico de subidas ou de acelerações a partir de baixa velocidade. Largada parada (CPV inicial zero) é a única situação no ciclismo em que a força pura é realmente limitante. Ciclocross e mountain bike também envolvem bastante pedalada de alta força/baixa velocidade, assim como estrada com subidas muito íngremes ou marcha muito pesada.
- **Quadrante III (inferior esquerdo): baixa força e baixa velocidade.** Típico de passeios de recuperação/sociais (sem foco de treino). Em prova de pelotão com potência muito variável, também ocorre bastante nesse quadrante durante recuperação entre esforços ou "soft-pedaling" no meio do grupo.
- **Quadrante IV (inferior direito): baixa força, alta velocidade.** Uso de marcha fixa leve ou rolos para melhorar suavidade de pedalada; provas com acelerações frequentes e rápidas (ex.: criterium) também envolvem bastante pedalada nesse quadrante.

Pedalar nos Quadrantes I e II (força suficientemente alta) está associado a recrutamento significativo de fibras de contração rápida (Tipo II).

Aplicação ao feedback: comparar a distribuição de tempo/esforço nos 4 quadrantes de um treino com a distribuição típica do tipo de prova-alvo do atleta revela se o treino está sendo específico o suficiente (ex.: um triatleta que só treina em provas de pelotão de estrada provavelmente não estará neuromuscularmente pronto para o triatlo; um ciclista que só anda de bike de recuperação no Quadrante III não deve esperar ser bom velocista de criterium).$m6678$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6679$nota-0070$m6679$, $m6680$O \"power balance\" padrão ANT+ é enganoso; GPR/GPA corrigem contabilizando potência absorvida na perna oposta$m6680$, $m6681$metricas-de-potencia$m6681$,
  $m6682$direta$m6682$, $m6683$conceito$m6683$,
  ARRAY[$m6684$diario$m6684$]::text[], ARRAY[$m6685$potência-média$m6685$]::text[],
  0.8, $m6686$ativo$m6686$, $m6687$O "power balance" padrão do protocolo ANT+ (potência média de uma perna vs. a outra) tem um problema: quando uma perna empurra o pedal para baixo (gerando potência positiva), a perna oposta, na subida, cria alguma resistência (potência negativa/absorvida) — e essa potência negativa não é corretamente contabilizada no cálculo simples de balanço ANT+.

Exemplo do livro: se a perna esquerda "libera" (releases) 150 W e a direita "absorve" 20 W na subida, a contribuição líquida real da esquerda é 130 W; se a direita libera 170 W e a esquerda absorve 30 W, a contribuição líquida da direita é 140 W. O total ainda soma 270 W, mas o balanço correto passa a ser 48% esquerda / 52% direita — diferente (e às vezes até invertido) do que o cálculo simplista de "potência média de cada perna" indicaria.

Por essa limitação, os autores recomendam não confiar nas métricas padrão ANT+ (Pedaling Smoothness, Torque Effectiveness, Balance) para análise bilateral fina, propondo métricas próprias (GPR, GPA, Kurtotic Index — ver nota-0071) que consideram potência liberada e absorvida separadamente.

Aplicação ao feedback: ao interpretar o balanço esquerda/direita reportado pelo Strava (baseado no protocolo ANT+ padrão), ter cautela ao concluir que uma perna é mais forte que a outra apenas pelo percentual simples — a diferença real de contribuição líquida pode ser menor (ou até invertida) do que o balanço bruto sugere, por causa da potência absorvida não contabilizada.$m6687$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6688$nota-0071$m6688$, $m6689$GPR, GPA e Kurtotic Index: métricas dos autores para análise bilateral de potência$m6689$, $m6690$metricas-de-potencia$m6690$,
  $m6691$direta$m6691$, $m6692$conceito$m6692$,
  ARRAY[$m6693$diario$m6693$]::text[], ARRAY[$m6694$potência-série-temporal$m6694$]::text[],
  0.75, $m6695$ativo$m6695$, $m6696$Métricas desenvolvidas pelos autores para análise bilateral de potência mais precisa que o "power balance" padrão ANT+:

- **GPR (Gross Power Released)**: potência bruta (muscular + inercial + gravitacional) liberada por uma perna (esquerda ou direita), principalmente na fase de descida do pedal (downstroke).
- **GPA (Gross Power Absorbed)**: potência bruta absorvida por uma perna, principalmente na fase de subida do pedal (upstroke).
- **Kurtotic Index (KI)**: mede o quão "pontiagudo" (peaked) é o padrão de aplicação de força/torque/potência de uma perna durante a fase de geração de potência — quanto maior o KI, mais a perna "soca" o pedal (aplica força de forma concentrada/abrupta) em vez de aplicar potência de forma suave ao longo de todo o curso do pedal.

Essas métricas são mais bem compreendidas em formato gráfico e plotadas contra a Curva de Potência Média Máxima (MMP, nota-0053) — permitindo ver, por exemplo, se a perna esquerda libera mais potência que a direita em esforços curtos (<30s) mas o padrão se inverte em esforços mais longos (até 20 min), e se uma perna absorve consistentemente mais potência que a outra ao longo de todas as durações (indicando potencial de melhora reduzindo a potência absorvida).

Aplicação ao feedback: usar GPR/GPA (em vez do balanço bruto ANT+) para identificar de forma mais precisa se uma perna do atleta libera consistentemente menos potência ou absorve mais potência que a outra ao longo de diferentes durações de esforço — a comparação contra a MMP Curve (nota-0053) revela se o padrão é estável ou muda conforme a intensidade/duração.$m6696$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;