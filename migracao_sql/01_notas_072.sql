BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9627$nota-0092$m9627$, $m9628$Overreaching não funcional: ATL > CTL por tempo prolongado sem TSB retornar à neutralidade$m9628$, $m9629$recuperacao-e-fadiga$m9629$,
  $m9630$direta$m9630$, $m9631$regra-interpretacao$m9631$,
  ARRAY[$m9632$semanal$m9632$, $m9633$mensal$m9633$]::text[], ARRAY[$m9634$TSS$m9634$]::text[],
  0.8, $m9635$ativo$m9635$, $m9636$Deixar de permitir que o TSB suba periodicamente até perto da neutralidade (ou seja, manter ATL cronicamente maior que CTL / TSB muito negativo por tempo prolongado) pode levar a um estado de **overreaching não funcional**: o atleta continua treinando, mas para de melhorar e fica progressivamente mais fatigado. Se esse estado persistir por tempo demais, pode evoluir para **síndrome de overtraining**, exigindo meses ou até um ano longe da bicicleta para recuperação completa.

Aplicação ao feedback: monitorar períodos prolongados de TSB fortemente negativo sem sinais de retorno à neutralidade é um indicador de alerta precoce para overreaching não funcional — vale sinalizar isso antes que se manifeste como estagnação de performance, doença ou lesão. Esse é o mecanismo de fundo por trás da recomendação de respeitar as taxas seguras de ramp rate de CTL (nota-0090).$m9636$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9637$nota-0096$m9637$, $m9638$Semana de recuperação: teto prático de ~62% da FTP e menos de 2h/dia$m9638$, $m9639$recuperacao-e-fadiga$m9639$,
  $m9640$direta$m9640$, $m9641$regra-interpretacao$m9641$,
  ARRAY[$m9642$semanal$m9642$]::text[], ARRAY[$m9643$potência-média$m9643$, $m9644$tempo-movimento$m9644$]::text[],
  0.7, $m9645$ativo$m9645$, $m9646$Exemplo prático de uma semana de recuperação (rest week) dentro de um plano de treino: manter a potência **abaixo de ~62% da FTP** em todas as pedaladas da semana ("really easy"), limitar a duração diária a **menos de 2 horas** (com a maioria dos treinos durando ~1h15), e incluir **dias de descanso completo**.

Nota: 62% é ligeiramente acima do teto da Zona 1/Active Recovery (~55% FTP, nota já registrada no Capítulo 2), sugerindo que numa semana de recuperação o autor tolera um pouco de deslocamento para a Zona 2 baixa, desde que a intensidade geral permaneça bem reduzida.

Aplicação ao feedback: útil como heurística para verificar se uma "semana de recuperação" declarada pelo atleta realmente correspondeu a uma redução real de carga — se a potência média/máxima da semana ultrapassar esse teto com frequência, ou a duração diária exceder 2h, a semana provavelmente não cumpriu a função de recuperação pretendida.$m9646$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9647$nota-0148$m9647$, $m9648$Overreached (agudo, recupera em poucos dias) vs. Overtrained/OTS (crônico, recuperação >30 dias) — critério de distinção pela duração da recuperação$m9648$, $m9649$recuperacao-e-fadiga$m9649$,
  $m9650$direta$m9650$, $m9651$regra-interpretacao$m9651$,
  ARRAY[$m9652$semanal$m9652$, $m9653$mensal$m9653$]::text[], '{}'::text[],
  0.65, $m9654$ativo$m9654$, $m9655$Distinção precisa entre dois estados de fadiga excessiva, frequentemente confundidos na linguagem coloquial dos atletas:

- **Overreached (agudo):** fadiga e queda de desempenho resultantes de um período **breve** de treino excessivo em relação ao normal do atleta. A performance se recupera após **apenas alguns dias** de descanso/treino reduzido. Segundo os autores, a maioria dos atletas que se autodenominam "overtrained" na verdade só sofreram overreaching agudo.
- **Overtrained / Overtraining Syndrome (OTS) (crônico):** estado crônico de overreaching do qual a recuperação leva **um período longo, tipicamente superior a 30 dias**.

Aplicação ao feedback: útil como critério objetivo para classificar a severidade de um estado de fadiga detectado (ex.: via TSB fortemente negativo prolongado, nota-0092) — se o desempenho/forma do atleta se recupera em poucos dias após reduzir a carga, é overreaching agudo (não motivo de alarme excessivo); se a queda de desempenho persiste por semanas mesmo com descanso, há indício de overtraining syndrome real, que exige uma resposta de feedback muito mais séria (recomendação de pausa prolongada e possivelmente acompanhamento médico).$m9655$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9656$nota-0160$m9656$, $m9657$Metaborreflexo dos músculos respiratórios: em alta intensidade, músculos respiratórios competem por fluxo sanguíneo com as pernas (custo ventilatório de 10-15% do VO2 total)$m9657$, $m9658$recuperacao-e-fadiga$m9658$,
  $m9659$contexto$m9659$, $m9660$conceito$m9660$,
  ARRAY[$m9661$diario$m9661$]::text[], '{}'::text[],
  0.5, $m9662$ativo$m9662$, $m9663$Em intensidades elevadas, os músculos respiratórios consomem 10-15% do VO2 total, competindo por fluxo sanguíneo com os músculos locomotores. Quando os músculos respiratórios fadigam, um mecanismo neural (metaborreflexo) aumenta a atividade simpática e reduz parcialmente o fluxo sanguíneo para as pernas — um mecanismo adicional (além da fadiga muscular periférica e central) que pode limitar a performance em atletas de elite, cujos demais sistemas já estão próximos do teto adaptativo. O Manual cita evidência de que treinamento muscular inspiratório (dispositivos de resistência inspiratória) produz ganhos pequenos, porém consistentes, de resistência respiratória e percepção de esforço — mais evidentes em atletas com fraqueza respiratória, elevada carga ventilatória ou provas de endurance prolongadas/altitude; em atletas de elite já bem adaptados, o benefício tende a ser marginal.

Aplicação ao feedback: mecanismo de contexto, não gera regra de interpretação de dado do Strava (o app não mede ventilação nem fadiga respiratória). Relevante apenas como explicação de fundo para casos em que um atleta relata "falta de ar" desproporcional sem indício de limitação cardiovascular nos dados de potência/FC — não deve ser usado para gerar alertas automáticos.$m9663$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;