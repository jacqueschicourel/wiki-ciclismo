BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m251$nota-0024$m251$, $m252$Escala de esforço percebido Borg CR10 (0–10) usada nas zonas de potência$m252$, $m253$avaliacao-e-testes$m253$,
  $m254$direta$m254$, $m255$referencia$m255$,
  ARRAY[$m256$diario$m256$]::text[], '{}'::text[],
  0.85, $m257$ativo$m257$, $m258$Escala de esforço percebido (RPE) usada pelos autores para a coluna RPE da Tabela 3.1 (níveis de potência) é a escala de categoria-razão de 10 pontos de Gunnar Borg (CR10), não a escala tradicional de 20 pontos (6-20) mais comum. Valores: 0 = nada, 0,5 = extremamente fraco, 1 = muito fraco, 2 = fraco (leve), 3 = moderado, 4 = um tanto forte, 5 = forte (pesado), 6–7 = muito forte, 8–10 = extremamente forte, • (marcador especial) = máximo.

Justificativa dos autores para usar a CR10 em vez da escala de 20 pontos: ela reconhece explicitamente a resposta não linear de várias variáveis fisiológicas (ex.: lactato sanguíneo e muscular), servindo como melhor indicador do esforço geral. Como a percepção de esforço aumenta com o tempo mesmo em intensidade (potência) constante, os valores/faixas sugeridos na Tabela 3.1 referem-se ao esforço percebido no início de uma sessão ou série de intervalos, não ao final.

Nota: RPE é um dado subjetivo relatado pelo atleta, não um sinal automático do Strava — por isso não tem `sinais` do glossário associados; é usado como referência cruzada para interpretar a intensidade quando o atleta relata a sensação de esforço.

Aplicação ao feedback: como RPE não é um sinal automático do Strava, só usar a escala CR10 quando o atleta relatar esforço percebido explicitamente (ex.: em texto livre da atividade ou input do produto) — não inferir RPE a partir apenas de dados de potência/FC.$m258$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m259$nota-0025$m259$, $m260$Cinco métodos alternativos para estimar FTP sem um teste formal dedicado$m260$, $m261$avaliacao-e-testes$m261$,
  $m262$direta$m262$, $m263$protocolo$m263$,
  ARRAY[$m264$mensal$m264$]::text[], ARRAY[$m265$potência-média$m265$, $m266$NP$m266$]::text[],
  0.8, $m267$ativo$m267$, $m268$Além do teste de campo de 20 minutos (nota-0020), o livro lista métodos de estimar o FTP sem um teste formal, em ordem crescente de complexidade:

1. **Gráfico de distribuição de frequência de potência**: analisar todo o histórico de treino no software do medidor de potência; costuma haver uma queda perceptível na frequência de tempo passado acima de um certo valor de potência — esse ponto de queda aproxima o FTP. Funciona melhor com "bins" de potência estreitos (5–10 W) e quando o período analisado inclui treino/corrida de alta intensidade.
2. **Potência estável de rotina**: observar a potência que o atleta consegue sustentar de forma quase constante por vários minutos em treinos habituais (intervalos longos, subidas longas), usando uma linha de grade horizontal sobreposta ao gráfico de potência para "caçar" o patamar constante.
3. **Potência Normalizada (NP) em corrida**: analisar a NP (conceito detalhado no Capítulo 7) durante provas de pelotão (mass-start) de aproximadamente 1 hora de duração e alta intensidade — como muitos softwares calculam NP automaticamente, isso pode ser a forma mais rápida de estimar o FTP sem nenhum teste dedicado.
4. **Contrarrelógio de 1 hora**: por definição, o melhor indicador de performance é a própria performance — um TT de 60 minutos bem pacejado dá a estimativa mais direta do FTP (a potência média já É, por definição, próxima do FTP). Se o atleta começar forte demais e cair no fim, a potência média subestima o FTP real.
5. **Modelagem matemática (Potência Crítica / modelo Potência-Duração)**: ver nota específica sobre Potência Crítica.
6. **Modelagem computacional (mFTP)**: ver nota específica sobre FTP modelado por software.

Aplicação ao feedback: quando não houver um teste de FTP formal recente, esses métodos indiretos (especialmente NP de corridas duras de ~1h e distribuição de frequência de potência do histórico) permitem uma estimativa razoável de FTP a partir dos dados já disponíveis no Strava, sem exigir que o atleta faça um teste dedicado.$m268$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m269$nota-0031$m269$, $m270$Power Profile (Tabela 4.1): faixas de W/kg por categoria de nível, para 5 s / 1 min / 5 min / FTP, homens e mulheres$m270$, $m271$avaliacao-e-testes$m271$,
  $m272$direta$m272$, $m273$referencia$m273$,
  ARRAY[$m274$mensal$m274$]::text[], ARRAY[$m275$potência-máx$m275$, $m276$relação-P/peso$m276$, $m277$FTP$m277$]::text[],
  0.9, $m278$ativo$m278$, $m279$Tabela 4.1 do livro classifica o nível de um ciclista comparando a potência máxima (em W/kg) que ele produz em 4 durações-índice (5 segundos, 1 minuto, 5 minutos e no FTP) contra 9 faixas de categoria, de Novice 1 (mais baixa) a World Class (mais alta). Cada categoria tem uma faixa de valores (não um valor único); abaixo estão o teto (melhor linha) e o piso (pior linha) de cada categoria, em W/kg:

**Homens** (5 s / 1 min / 5 min / FTP):
- World class: 25,18/11,50/7,60/6,60 (topo) até 23,06/10,68/6,86/5,93 (piso)
- Exceptional: 22,76/10,56/6,75/5,84 até 21,25/9,97/6,23/5,36
- Excellent: 20,94/9,86/6,12/5,27 até 19,43/9,27/5,59/4,79
- Very good: 19,13/9,15/5,49/4,70 até 17,61/8,57/4,96/4,22
- Good: 17,31/8,45/4,85/4,12 até 15,80/7,86/4,32/3,65
- Moderate: 15,50/7,74/4,22/3,55 até 13,98/7,16/3,69/3,08
- Fair: 13,68/7,04/3,59/2,98 até 12,17/6,45/3,06/2,51
- Novice 2: 11,87/6,33/2,95/2,41 até 10,35/5,75/2,42/1,93
- Novice 1: 10,05/5,63/2,32/1,84 até 8,23/4,93/1,68/1,27

**Mulheres** (5 s / 1 min / 5 min / FTP):
- World class: 19,42/9,29/6,74/5,74 até 17,88/8,64/6,06/5,15
- Exceptional: 17,66/8,55/5,96/5,06 até 16,56/8,09/5,47/4,64
- Excellent: 16,34/7,99/5,38/4,55 até 15,24/7,53/4,89/4,13
- Very good: 15,02/7,44/4,79/4,04 até 13,91/6,97/4,31/3,62
- Good: 13,69/6,88/4,21/3,53 até 12,59/6,42/3,72/3,11
- Moderate: 12,37/6,33/3,62/3,02 até 11,27/5,86/3,14/2,60
- Fair: 11,05/5,77/3,04/2,51 até 9,95/5,31/2,55/2,09
- Novice 2: 9,73/5,22/2,45/2,00 até 8,63/4,75/1,97/1,58
- Novice 1: 8,41/4,66/1,87/1,49 até 7,09/4,10/1,29/0,98

Metodologia: os extremos das faixas foram "ancorados" no desempenho conhecido de campeões mundiais (extremo superior) e ciclistas novatos (extremo inferior) — ex.: um sprinter mundial produz >23 W/kg em sprint de 5 s, um novato produz 10–12,5 W/kg — com as 7 divisões intermediárias (exceptional, excellent, very good, good, moderate, fair, novice) distribuídas entre esses extremos e confirmadas com dados reais dos autores. A tabela não tem correção por idade (ver nota sobre limitações) nem chart separado para masters — os autores decidiram aplicá-la igual para todas as idades.

Aplicação ao feedback: para classificar o "fenótipo"/nível do atleta, calcular seus melhores W/kg nas 4 durações-índice (a partir do histórico de picos de potência do Strava) e localizar em que faixa de categoria cada valor cai — ver nota-0035 sobre como interpretar o formato resultante do perfil.$m279$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;