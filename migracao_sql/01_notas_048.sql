BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6421$nota-0060$m6421$, $m6422$Variability Index (VI): fórmula (NP/potência média) e faixas típicas por tipo de prova$m6422$, $m6423$metricas-de-potencia$m6423$,
  $m6424$direta$m6424$, $m6425$referencia$m6425$,
  ARRAY[$m6426$diario$m6426$]::text[], ARRAY[$m6427$potência-média$m6427$, $m6428$NP$m6428$, $m6429$VI$m6429$]::text[],
  0.9, $m6430$ativo$m6430$, $m6431$**Fórmula: VI (Variability Index) = NP ÷ potência média.** Quanto mais variável o esforço (após a suavização de 30s do cálculo de NP), maior o VI; VI = 1,0 significa potência perfeitamente constante.

Tabela 7.1 do livro — faixas típicas de VI por tipo de prova/treino:

| Tipo de pedalada | VI típico |
|---|---|
| Treino de potência constante (isopower) | 1,00–1,02 |
| Prova de estrada plana | 1,00–1,06 |
| Contrarrelógio plano | 1,00–1,04 |
| Contrarrelógio de subida | 1,00–1,06 |
| Criterium plano | 1,06–1,35 |
| Criterium com subidas | 1,13–1,50 |
| Prova de estrada com subidas | 1,20–1,35 |
| Prova de mountain bike | 1,13–1,50 |

Exemplo real do livro (Figura 7.1, corrida de pelotão em estrada): potência média 319 W, NP 357 W → VI = 357/319 ≈ 1,12. Exemplo de subida constante (Figura 7.2): potência média 300 W, NP 304 W → VI = 304/300 ≈ 1,01.

**Correção aritmética (2026-08-02, achado de auditoria adversarial):** o valor do segundo exemplo estava registrado como "≈1,02"; recalculando, 304÷300 = 1,01333, que arredonda para 1,01, não 1,02. Corrigido acima. Erro pequeno de transcrição/arredondamento no exemplo secundário — não afeta a fórmula (VI = NP÷potência média), que está correta e é o que a skill de fato usa.

Aplicação ao feedback: comparar o VI de uma atividade com a faixa esperada para aquele tipo de evento ajuda a identificar se a prova/treino teve o padrão de variabilidade esperado (ex.: um VI muito mais alto que o esperado para um contrarrelógio pode indicar pacing ruim ou terreno/vento atípicos; treinar sempre com VI baixo quando o objetivo é um evento de VI alto — ex.: mountain bike — indica falta de especificidade no treino, ver nota-0060 e Quadrant Analysis).$m6431$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6432$nota-0061$m6432$, $m6433$Intensity Factor (IF): fórmula (NP/FTP) e uso para detectar FTP desatualizado (IF > 1,05 em prova de ~1h)$m6433$, $m6434$metricas-de-potencia$m6434$,
  $m6435$direta$m6435$, $m6436$regra-interpretacao$m6436$,
  ARRAY[$m6437$diario$m6437$]::text[], ARRAY[$m6438$potência-média$m6438$, $m6439$NP$m6439$, $m6440$FTP$m6440$, $m6441$IF$m6441$]::text[],
  0.9, $m6442$ativo$m6442$, $m6443$**Fórmula: IF (Intensity Factor) = NP ÷ FTP** — a fração do FTP do atleta que foi sustentada (em termos de potência normalizada) naquele treino/prova/trecho. Ao contrário do NP bruto, o IF é relativo à capacidade do próprio atleta, permitindo comparar a intensidade relativa de esforços ao longo do tempo (conforme o FTP muda) ou entre atletas diferentes.

**Regra de detecção de FTP desatualizado**: um IF acima de 1,05 numa prova de aproximadamente 1 hora de duração é frequentemente sinal de que o FTP cadastrado está subestimado (o FTP real do atleta já subiu). Exemplo do livro: Joe Athlete tem FTP cadastrado de 290 W; após 8 semanas de treino sem reteste formal, faz uma fuga de ~1h numa corrida e obtém NP = 310 W, IF = 1,07, TSS = 114. Como por definição 1h no FTP deveria dar IF = 1,0 e TSS = 100, Joe ajusta o FTP cadastrado para 310 W (recalculando TSS = 100, IF = 1,0) — mas, como um salto de 20 W (290→310) em 8 semanas é um aumento grande, o livro recomenda ser conservador e ajustar para um valor intermediário (300 W), confirmando com teste formal assim que possível.

Aplicação ao feedback: monitorar o IF de esforços de ~1h (provas ou treinos duros) ao longo da temporada é uma forma passiva de identificar que o FTP cadastrado provavelmente subiu (ou caiu) sem precisar aguardar o próximo teste formal — mas ajustes bruscos de FTP baseados nisso devem ser conservadores e, quando possível, confirmados por teste.$m6443$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6444$nota-0062$m6444$, $m6445$TSS (Training Stress Score): fórmula completa e definição de referência (1h no FTP = 100 TSS)$m6445$, $m6446$metricas-de-potencia$m6446$,
  $m6447$direta$m6447$, $m6448$referencia$m6448$,
  ARRAY[$m6449$diario$m6449$, $m6450$semanal$m6450$]::text[], ARRAY[$m6451$potência-média$m6451$, $m6452$NP$m6452$, $m6453$IF$m6453$, $m6454$TSS$m6454$, $m6455$FTP$m6455$, $m6456$tempo-decorrido$m6456$]::text[],
  0.95, $m6457$ativo$m6457$, $m6458$**Fórmula: TSS = [(s × NP × IF) ÷ (FTP × 3.600)] × 100**, onde s = duração em segundos, NP = Potência Normalizada em watts, IF = Intensity Factor, FTP = Functional Threshold Power em watts, 3.600 = segundos em 1 hora.

Ponto de referência que define a escala: **1 hora pedalando exatamente no FTP = 100 pontos de TSS, com IF = 1,0.** TSS combina intensidade (via IF) e duração num único número, funcionando como estimador da carga glicolítica/glicogênio utilizado em cada sessão.

Propriedade importante: como o TSS é calculado a partir do FTP (individualizado), um mesmo TSS representa a mesma carga relativa de estresse fisiológico para atletas de níveis muito diferentes — uma saída de 300 TSS para um iniciante e uma saída de 300 TSS para um profissional de elite (Peter Sagan é o exemplo citado) são fisicamente muito diferentes em distância/potência absoluta, mas colocam grau equivalente de estresse no sistema fisiológico de cada um. O que difere entre atletas é a *tolerância* a determinado volume de TSS acumulado (ex.: um profissional pode sustentar 300–400 TSS/dia com IF 0,85 por 21 dias seguidos e continuar evoluindo; um iniciante pode ficar sobrecarregado só com 2 dias nesse nível).

Exemplo de equivalência: um treino de 200 TSS equivale, em carga, a aproximadamente dois contrarrelógios de 40 km (cada um valendo ~100 TSS a IF 1,0); um treino de 100 TSS também pode ser obtido por 2 horas a IF mais baixo (0,71), representando teoricamente o mesmo custo fisiológico de um único CRI de 40 km a IF 1,0.

Aplicação ao feedback: TSS é a métrica central para acumular carga de treino ao longo do tempo (base de CTL/ATL/TSB) — ao gerar feedback diário/semanal, reportar o TSS de cada sessão e a soma acumulada, não apenas potência média ou duração isoladas, para refletir corretamente o estresse fisiológico real de cada atividade.$m6458$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;