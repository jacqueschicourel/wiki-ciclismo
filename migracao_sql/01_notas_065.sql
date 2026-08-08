BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9001$nota-0224$m9001$, $m9002$Ciclo alanina-glicose: até 45% da liberação hepática de glicose em exercício prolongado vem de aminoácidos, não de glicogênio$m9002$, $m9003$nutricao-e-energia$m9003$,
  $m9004$contexto$m9004$, $m9005$conceito$m9005$,
  ARRAY[$m9006$mensal$m9006$]::text[], '{}'::text[],
  0.7, $m9007$ativo$m9007$, $m9008$O **ciclo alanina-glicose** é uma via pela qual proteína/aminoácidos musculares contribuem indiretamente como combustível durante exercício prolongado, mesmo sem serem oxidados diretamente no músculo: o músculo ativo sintetiza alanina a partir do piruvato (via transaminação, usando nitrogênio derivado em parte da leucina); a alanina sai do músculo, chega ao fígado, é desaminada, e seu esqueleto de carbono é convertido de volta em glicose via gliconeogênese — glicose essa que retorna à corrente sanguínea para ser usada pelo músculo ativo e pelo sistema nervoso central.

Magnitude: após 4 horas de exercício leve contínuo, a glicose derivada de alanina responde por **cerca de 45% da liberação hepática total de glicose**. No total, o ciclo alanina-glicose gera entre **10 e 15% do requerimento energético total do exercício** em esforços prolongados. O treinamento regular de endurance aumenta a capacidade do fígado de realizar essa gliconeogênese, o que ajuda a manter a homeostase da glicose sanguínea durante exercício prolongado.

Isso reforça por que a depleção de glicogênio aumenta o catabolismo proteico durante o exercício: quando as reservas de glicogênio muscular e hepático caem, o corpo depende proporcionalmente mais dessa via de "reciclagem" de aminoácidos para manter a glicemia, sacrificando proteína estrutural/funcional no processo — um dos motivos pelos quais atletas de endurance treinando intensamente têm demanda proteica acima da RDA padrão (ver nota-0223).

Este é um mecanismo bioquímico de base sem tradução direta a um sinal do Strava (não há como medir alanina circulante ou gliconeogênese hepática a partir de dados de potência/FC), por isso permanece como nota de contexto explicativo.$m9008$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9009$nota-0225$m9009$, $m9010$Gasto energético diário em ciclismo de endurance: ~6500 kcal/dia médio no Tour de France (3000 em dia de descanso, 9000 em etapa de montanha); déficit energético em provas ultra associa-se a tempo de prova mais lento$m9010$, $m9011$nutricao-e-energia$m9011$,
  $m9012$direta$m9012$, $m9013$referencia$m9013$,
  ARRAY[$m9014$diario$m9014$]::text[], ARRAY[$m9015$trabalho-kJ$m9015$, $m9016$tempo-movimento$m9016$]::text[],
  0.7, $m9017$ativo$m9017$, $m9018$Referências quantitativas de gasto energético diário em ciclismo de resistência, úteis para contextualizar o trabalho-kJ/duração registrados pelo Strava frente a faixas fisiológicas plausíveis:

- **Tour de France (3 semanas, etapas profissionais):** gasto energético médio de **~6500 kcal/dia**, com grande variação por tipo de dia — cerca de **3000 kcal em dia de descanso** e até **9000 kcal em etapa de montanha**. Ciclistas profissionais conseguem, com estratégia de nutrição líquida combinada a refeições normais, chegar perto do balanço energético mesmo nessas cargas extremas.
- **Ultraendurance (prova de 384 km / 16h):** ingestão média de energia de 18,7 MJ (4469 kcal) ficou **abaixo** da necessidade energética estimada da prova, 25,5 MJ (6095 kcal) — um déficit de ~27%. Esse déficit energético teve relação negativa com o tempo de prova (quanto maior o déficit, mais lento o atleta), sugerindo que reduzir o déficit energético durante a prova favorece o desempenho.

Esses números servem como faixa de referência (não como alvo prescritivo individual — variam com massa corporal, eficiência mecânica e condições ambientais) para saber se o gasto energético estimado de uma sessão/etapa longa está dentro do esperado fisiologicamente.

Aplicação ao feedback: o produto pode converter o trabalho mecânico (trabalho-kJ) de uma sessão longa em uma estimativa aproximada de gasto calórico (usando a conversão kJ→kcal considerando eficiência mecânica, nota-0002) e comparar contra essas faixas de referência — por exemplo, sinalizar quando uma sessão/etapa de duração muito longa (vários dias consecutivos de alto volume, como uma viagem de cicloturismo ou uma prova de ultra-endurance) provavelmente exige um gasto calórico da ordem de milhares de kcal/dia, reforçando a importância de reposição energética adequada para não comprometer o desempenho nos dias seguintes.$m9018$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;