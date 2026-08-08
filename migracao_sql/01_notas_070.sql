BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9360$nota-0286$m9360$, $m9361$A 'regra dos 3500 kcal = 1 libra de gordura' superestima a perda de peso real; a relação déficit-perda não é linear/estática$m9361$, $m9362$nutricao-e-energia$m9362$,
  $m9363$contexto$m9363$, $m9364$conceito$m9364$,
  ARRAY[$m9365$mensal$m9365$]::text[], '{}'::text[],
  0.7, $m9366$ativo$m9366$, $m9367$A regra popular "3500 kcal de déficit = 1 libra (0,45 kg) de gordura perdida" — amplamente usada em sites de saúde, apps de smartphone e até em textos didáticos (incluindo edições anteriores do próprio McArdle) — **superestima sistematicamente a perda de peso real**, segundo pesquisa mais recente citada na 8ª edição do livro (Thomas et al., 2013).

O motivo: a relação entre déficit calórico acumulado e perda de peso **não é linear nem estática** — à medida que o peso corporal cai, o gasto energético diário também cai (menor massa para movimentar, menor gasto metabólico basal), então o mesmo déficit nominal de calorias produz cada vez menos perda de peso ao longo do tempo. Um déficit fixo de X kcal/dia não continua produzindo a mesma taxa de perda de peso indefinidamente — a perda desacelera. Modelos dinâmicos e validados (ex.: a ferramenta do NIH Body Weight Planner, mencionada na fonte) capturam esse efeito de forma mais precisa que a divisão simples "déficit acumulado ÷ 3500".

Aplicação ao feedback: se o produto projeta prazo/quantidade de perda de peso a partir de um déficit calórico diário planejado, usar a regra estática dos 3500 kcal/libra tende a **prometer perda de peso mais rápida do que a que realmente ocorrerá**, especialmente em horizontes de várias semanas/meses — o que pode gerar frustração e abandono da estratégia pelo atleta. Prefira comunicar estimativas conservadoras ou reconhecer que a taxa de perda desacelera com o tempo, em vez de extrapolar linearmente um déficit fixo.$m9367$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9368$nota-0288$m9368$, $m9369$Perder peso via aumento de gasto (exercício) preserva massa muscular, força e VO2máx; perder o mesmo peso só por restrição calórica reduz os três$m9369$, $m9370$nutricao-e-energia$m9370$,
  $m9371$contexto$m9371$, $m9372$conceito$m9372$,
  ARRAY[$m9373$mensal$m9373$]::text[], '{}'::text[],
  0.75, $m9374$ativo$m9374$, $m9375$Um estudo comparou dois grupos de adultos de 50-60 anos que perderam a **mesma quantidade de peso (~4,5 kg) ao longo de 12 meses**, um só por restrição calórica (dieta) e outro só por aumento de exercício, medindo volume de músculo da coxa por ressonância magnética, força de flexão de joelho e VO2máx:

- **Grupo restrição calórica isolada:** perda de 6,8% no volume de músculo da coxa, queda de 27% na força de flexão de joelho, e queda de 27% no VO2máx.
- **Grupo perda de peso via exercício:** nenhuma queda de volume muscular ou força — e o VO2máx **aumentou 15,5%**.

Ou seja, para a **mesma perda de peso corporal**, o método usado para criar o déficit energético determina se a perda "custa" músculo, força e capacidade aeróbia, ou se preserva (e até melhora) essas capacidades. Isso é consistente com o princípio mais amplo de que adicionar atividade física a um programa de perda de peso favorece maior perda de gordura e menor perda de massa magra, além de manter ou até aumentar a capacidade física.

Aplicação ao feedback: para um ciclista com objetivo de perda de peso, a recomendação deveria priorizar criar o déficit calórico através de **aumento do gasto energético (mais volume/intensidade de treino)** em vez de apenas cortar a ingestão calórica de forma agressiva — não só porque preserva massa magra (relevante para potência absoluta), mas porque, ao contrário da restrição isolada, essa abordagem tende a manter ou melhorar o VO2máx durante o próprio processo de perda de peso, evitando o cenário indesejável de "perder peso mas perder também capacidade de gerar potência".$m9375$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9376$nota-0291$m9376$, $m9377$Amenorreia atlética: prevalência de 2-5% na população geral chega a 40% em grupos de atletas; a teoria de um '%gordura crítico' (17%) para menstruação não se sustenta nos dados$m9377$, $m9378$nutricao-e-energia$m9378$,
  $m9379$contexto$m9379$, $m9380$conceito$m9380$,
  ARRAY[$m9381$mensal$m9381$]::text[], '{}'::text[],
  0.7, $m9382$ativo$m9382$, $m9383$A **amenorreia** (ausência de menstruação) ocorre em apenas 2-5% das mulheres em idade reprodutiva na população geral, mas pode atingir **até 40% em determinados grupos de atletas** — sendo particularmente comum em modalidades de "baixo peso/estética" (corrida de longa distância, ginástica, balé, patinação artística, fisiculturismo). Entre atletas de endurance do sexo feminino em geral, **um terço a metade apresenta algum grau de irregularidade menstrual**.

Um ponto importante para não usar de forma simplista: a teoria antiga de que existiria um **percentual de gordura corporal "crítico" fixo (17% para início da menstruação, 22% para ciclo regular)** não se sustenta nos dados. Um estudo comparando 30 atletas e 30 não-atletas, todas com menos de 20% de gordura corporal, mostrou que mulheres fisicamente ativas abaixo do suposto limiar crítico de 17% frequentemente têm ciclos menstruais normais, enquanto algumas atletas amenorreicas mantêm %gordura considerado médio para a população. Ou seja, **não existe um corte único de %gordura que determine função menstrual** — a causa é multifatorial (física, nutricional, genética, hormonal, distribuição regional de gordura, psicológica, ambiental).

Duas hipóteses concorrentes (não mutuamente excludentes) explicam a disfunção menstrual induzida por exercício:
1. **Hipótese do estresse do exercício:** o próprio estresse físico prolongado/intenso, via eixo hipotálamo-hipófise-adrenal, desregula a secreção pulsátil de hormônio luteinizante.
2. **Hipótese da disponibilidade energética:** reservas energéticas insuficientes para sustentar uma gravidez induzem cessação da ovulação — evidência a favor: dançarinas de balé amenorreicas que param de treinar por lesão frequentemente retomam a menstruação mesmo mantendo peso corporal baixo, sugerindo que é a **disponibilidade energética** (ingestão menos gasto de exercício), não o peso/gordura em si, o fator determinante.

Aplicação ao feedback: para atletas mulheres com sinais de irregularidade menstrual, a orientação baseada em "%gordura muito baixo" isoladamente é insuficiente e pode ser incorreta — o fator mais provável e acionável é a **disponibilidade energética insuficiente** (ingestão inadequada frente ao gasto total incluindo treino), reforçando a importância de monitorar consumo calórico junto ao volume de treino em vez de mirar um %gordura-alvo fixo. Amenorreia prolongada deve ser avaliada por profissional de saúde, pois afeta negativamente a massa óssea (ver nota-0237).$m9383$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;