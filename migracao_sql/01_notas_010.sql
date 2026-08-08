BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1307$nota-0278$m1307$, $m1308$Equação de Siri (densidade corporal → %gordura) e por que ela erra em atletas com grande massa muscular$m1308$, $m1309$avaliacao-e-testes$m1309$,
  $m1310$contexto$m1310$, $m1311$conceito$m1311$,
  ARRAY[$m1312$mensal$m1312$]::text[], '{}'::text[],
  0.8, $m1313$ativo$m1313$, $m1314$A **equação de Siri** é o método padrão para converter densidade corporal (obtida por pesagem hidrostática, BOD POD ou DXA-derivada) em percentual de gordura: **%Gordura = (495 ÷ densidade corporal) − 450**. Ela assume um modelo de dois compartimentos com densidade constante de 0,90 g/cm³ para o tecido adiposo e 1,10 g/cm³ para a massa livre de gordura (FFM) em qualquer indivíduo.

Essa suposição de densidade constante da FFM **falha em pessoas com grande desenvolvimento muscular via treino de força**. Um estudo comparando levantadores de peso com controles não treinados mostrou que a densidade da FFM dos levantadores era menor (1,089 g/cm³) que a dos controles (1,099 g/cm³), porque o aumento de massa muscular foi desproporcional ao aumento de massa óssea — e o tecido muscular tem densidade menor que o valor assumido de 1,10. Resultado prático: **a equação de Siri padrão superestima o percentual de gordura em atletas muito musculosos**. Para corrigir isso, existe uma equação modificada para homens brancos treinados em força: **%Gordura = (521 ÷ densidade corporal) − 478**.

Relevância para ciclismo: ciclistas que também fazem musculação de força consistente (comum em treino de potência/sprint) podem ter sua %gordura superestimada por qualquer método baseado na equação de Siri padrão (pesagem hidrostática, BOD POD convertido por Siri). Isso não invalida o acompanhamento longitudinal (a tendência ao longo do tempo ainda é útil), mas o valor absoluto de %gordura deve ser interpretado com cautela nesse perfil de atleta.$m1314$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1315$nota-0279$m1315$, $m1316$Bioimpedância (BIA) é sensível ao estado de hidratação: medir logo após treino intenso superestima massa magra e subestima %gordura$m1316$, $m1317$avaliacao-e-testes$m1317$,
  $m1318$contexto$m1318$, $m1319$conceito$m1319$,
  ARRAY[$m1320$semanal$m1320$, $m1321$mensal$m1321$]::text[], '{}'::text[],
  0.8, $m1322$ativo$m1322$, $m1323$A **bioimpedância elétrica (BIA)** estima composição corporal medindo a resistência do corpo à passagem de uma corrente elétrica de baixa intensidade — tecidos hidratados (massa magra) conduzem melhor que tecido adiposo. Isso torna a técnica **muito sensível ao estado momentâneo de hidratação**, o que é especialmente relevante para ciclistas, que rotineiramente perdem líquido por suor em treinos longos ou intensos.

Mecanismo documentado: **desidratação por suor** (típica após um treino intenso) e **depleção de glicogênio** (que carrega água ligada) **reduzem a impedância** medida — o que faz o aparelho **superestimar a massa magra (FFM) e subestimar o percentual de gordura**. O efeito inverso ocorre com hiper-hidratação (superestima %gordura). Mesmo a temperatura da pele/ambiente influencia a leitura (pele mais quente e úmida produz menor impedância, logo menor %gordura estimado).

Além disso, mesmo em condições padronizadas, a BIA tende a **superestimar %gordura em pessoas magras/atléticas e subestimar em pessoas obesas**, sendo geralmente menos precisa que dobras cutâneas ou perímetros corporais.

Aplicação prática: se um ciclista usa balança de bioimpedância doméstica para acompanhar %gordura, os valores só são comparáveis entre si se medidos em condições de hidratação semelhantes (ex.: sempre em jejum, pela manhã, antes de qualquer treino do dia) — medir logo após um treino longo/suado, ou em dias com hidratação muito diferente, produz "mudanças" de composição corporal que são artefato de hidratação, não mudança real de gordura/músculo.$m1323$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1324$nota-0280$m1324$, $m1325$Acurácia comparada dos métodos de composição corporal: dobras cutâneas (±2,5-4%), BOD POD (-1,6 a -2,9% vs. DXA/densitometria) e DXA (<2% de erro vs. densitometria)$m1325$, $m1326$avaliacao-e-testes$m1326$,
  $m1327$contexto$m1327$, $m1328$referencia$m1328$,
  ARRAY[$m1329$mensal$m1329$]::text[], '{}'::text[],
  0.75, $m1330$ativo$m1330$, $m1331$Nenhum método de campo de composição corporal é exato; cada um tem um erro sistemático característico em relação aos métodos-critério laboratoriais (pesagem hidrostática/densitometria e DXA). Isso explica por que é comum um mesmo atleta obter %gordura visivelmente diferente em academias/clínicas distintas.

**Dobras cutâneas (skinfolds):** equações generalizadas predizem %gordura dentro de **±2,5 a 4,0 pontos percentuais** do valor real em cerca de 70% das pessoas medidas (comparado a um método-critério como pesagem hidrostática, DXA ou BOD POD). Para atletas especificamente, existe uma equação validada contra um modelo de quatro compartimentos: **%Gordura = 8,997 + 0,24658×(soma de 3 dobras: abdômen+coxa+tríceps, em mm) − 6,343×(sexo: 0=fem,1=masc) − 1,998×(raça: 0=branco,1=negro)** (Evans et al., 2005).

**BOD POD (pletismografia por deslocamento de ar):** em amostras heterogêneas, subestimou %gordura em relação à densitometria em **−1,9 pontos percentuais** e em relação ao DXA em **−1,6 a −2,9 pontos percentuais**, dependendo da população. Em atletas magros pode ocorrer superestimação; a direção e magnitude do erro variam por estudo/população.

**DXA (absorciometria de raios-X de dupla energia):** é o método de referência mais robusto disponível fora de cadáver, com erro **inferior a 2 pontos percentuais** de gordura em relação à densitometria numa amostra heterogênea de adultos — mas a força da predição diminui em pessoas mais velhas e mais gordas.

Aplicação prática: ao interpretar %gordura relatada por um atleta, é mais confiável acompanhar a **tendência ao longo do tempo usando sempre o mesmo método e protocolo** do que comparar valores absolutos entre métodos diferentes (ex.: dobras cutâneas de uma clínica vs. balança de bioimpedância de casa vs. DXA de um exame médico) — a diferença entre eles pode facilmente ser maior que a mudança real de composição corporal que se está tentando detectar.$m1331$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;