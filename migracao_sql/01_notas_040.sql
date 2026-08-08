BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5114$nota-0275$m5114$, $m5115$Treinar em altitude não melhora o desempenho subsequente em nível do mar — só o protocolo 'live high, train low' mostra benefício consistente$m5115$, $m5116$metodologia-e-periodizacao$m5116$,
  $m5117$contexto$m5117$, $m5118$conceito$m5118$,
  ARRAY[$m5119$mensal$m5119$]::text[], '{}'::text[],
  0.6, $m5120$ativo$m5120$, $m5121$Achado experimental consistente (McArdle, múltiplos estudos citados, incluindo comparação cruzada com corredores de meia-distância): **treinar em altitude moderada (ex. 2300m) não produz nenhuma vantagem sobre treinar equivalentemente ao nível do mar**, quando o critério é o desempenho subsequente ao nível do mar. Um estudo cruzado (6 corredores treinando 3 semanas em cada local, depois trocando) mostrou que, ao retornar ao nível do mar, o VO2max ficou **2,8% abaixo** do valor pré-altitude — ou seja, nenhum efeito sinérgico surgiu de combinar treino aeróbio com hipóxia moderada.

A **única exceção bem documentada** é o protocolo **"live high, train low"** (morar em altitude moderada, mas treinar em altitude baixa/nível do mar para manter a intensidade absoluta de treino): atletas que viveram a 2500m mas desceram regularmente para treinar a 1000-1250m mostraram ganhos médios maiores de VO2max e desempenho de 5000m do que atletas que viveram/treinaram só em altitude OU só ao nível do mar.

Por que a diferença? Treinar diretamente em altitude força o atleta a reduzir a intensidade absoluta do treino (a mesma % de VO2max relativa corresponde a um ritmo/potência muito menor — ver Tabela 24.3: 78% do VO2max ao nível do mar cai para apenas 39% de intensidade equivalente a 4000m), o que compromete a qualidade do estímulo de treino de alta intensidade — mesmo que o corpo ganhe benefícios hematológicos (mais hemoglobina/hematócrito) da exposição à altitude. O "live high, train low" resolve esse conflito: ganha os benefícios da exposição hipóxica (síntese de EPO, mais glóbulos vermelhos) SEM perder a capacidade de treinar em alta intensidade absoluta.

Três pré-requisitos citados para o protocolo funcionar: (1) a altitude de moradia deve ser alta o suficiente para elevar EPO e aumentar volume de hemácias/VO2max; (2) o atleta precisa responder positivamente com aumento de EPO (existem "não-respondedores"); (3) o treino deve ocorrer em altitude baixa o suficiente para manter intensidade/consumo de oxigênio próximos do nível do mar.

Aplicação ao feedback: se um atleta relatar/planejar um "training camp" em altitude visando melhorar desempenho de provas ao nível do mar, a recomendação baseada nesta evidência é que simplesmente treinar E dormir em altitude não trará vantagem sobre treinar normalmente ao nível do mar — só compensa se o protocolo específico de "dormir alto, treinar baixo" for viável logisticamente. Não é executável a partir de dados do Strava isoladamente, mas relevante para orientação de planejamento de temporada.$m5121$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5122$nota-0001$m5122$, $m5123$Potência como sinal mais confiável que FC para detectar fadiga acumulada$m5123$, $m5124$metricas-de-potencia$m5124$,
  $m5125$direta$m5125$, $m5126$regra-interpretacao$m5126$,
  ARRAY[$m5127$diario$m5127$, $m5128$semanal$m5128$]::text[], ARRAY[$m5129$FC (média/máx)$m5129$, $m5130$potência-série-temporal$m5130$, $m5131$decoupling (Pw:Hr)$m5131$]::text[],
  0.85, $m5132$ativo$m5132$, $m5133$A frequência cardíaca (FC) é uma resposta fisiológica indireta ao esforço, influenciada por hidratação, temperatura ambiente, sono, estresse e nível de fadiga acumulada — não apenas pela intensidade do exercício. A potência, por outro lado, mede diretamente o trabalho mecânico produzido (watts), sendo um sinal mais objetivo do estímulo real de treino.

Consequência prática: quando a FC está mais baixa que o habitual para uma dada potência (ex.: um ciclista que normalmente atinge 165 bpm a 280 W passa a marcar 158 bpm a 280 W), isso não deve ser lido como sinal de que o esforço está "fácil" ou que o atleta pode/deve reduzir a intensidade — é mais provável que indique fadiga acumulada de dias anteriores de treino intenso, já que a capacidade de gerar potência costuma se manter praticamente intacta mesmo quando a FC está suprimida pela fadiga. Nesses casos, a potência (não a FC) deve orientar a decisão sobre necessidade de descanso.

Aplicação ao feedback: ao comparar a série temporal de FC e potência de uma atividade contra sessões anteriores em trechos/potências semelhantes (decoupling Pw:Hr), uma FC mais baixa que o habitual para a mesma potência não deve ser lida como "sessão fácil" — cruzar com a carga acumulada recente (TSS/CTL/ATL) antes de recomendar redução de intensidade.$m5133$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5134$nota-0008$m5134$, $m5135$Fórmula fundamental: Potência = Força × Velocidade$m5135$, $m5136$metricas-de-potencia$m5136$,
  $m5137$contexto$m5137$, $m5138$conceito$m5138$,
  ARRAY[$m5139$diario$m5139$]::text[], ARRAY[$m5140$potência-série-temporal$m5140$]::text[],
  0.9, $m5141$ativo$m5141$, $m5142$Definição física básica que fundamenta todo medidor de potência: potência (watts) é o produto da força aplicada pelo ciclista nos pedais pela velocidade angular/linear resultante. Ciclistas aplicam força para vencer as forças de resistência que se opõem ao movimento (subida, resistência do ar, resistência de rolamento, aceleração). A maioria dos medidores de potência mede diretamente a força aplicada (torção/deflexão em manivela, cubo, eixo de movimento central ou pedal); o PowerPod (Velocomp) é uma exceção que mede as forças opostas (resistência do ar via tubo de Pitot, peso, coeficiente aerodinâmico e de rolamento) e infere a potência aplicada usando a 3ª Lei de Newton (força de reação = força aplicada).

Nota: é a equação-base que os capítulos seguintes do livro (NP, IF, TSS, modelo potência-duração) desenvolvem — por isso `aplicacao: contexto` aqui, e não uma regra de interpretação em si.$m5142$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5143$nota-0009$m5143$, $m5144$Coroas não circulares (ovais) inflam a potência registrada em até 10–20 W$m5144$, $m5145$metricas-de-potencia$m5145$,
  $m5146$direta$m5146$, $m5147$regra-interpretacao$m5147$,
  ARRAY[$m5148$diario$m5148$]::text[], ARRAY[$m5149$potência-série-temporal$m5149$]::text[],
  0.85, $m5150$ativo$m5150$, $m5151$Medidores de potência que calculam watts a partir da velocidade angular da manivela/pedal (assumindo velocidade angular constante ao longo da volta) sofrem um viés sistemático de superestimação quando o ciclista usa coroas não circulares (ovais). O desenho da coroa oval acelera o trecho "morto" do pedal (topo/base do curso) para o ciclista retornar mais rápido ao trecho de força (0–180°), o que inflaciona artificialmente a potência calculada em até 10–20 W, dependendo do grau de ovalização.

Aplicação ao feedback: ao interpretar potência/NP/TSS de um atleta que usa coroas não circulares, considerar que os valores registrados podem estar superestimados em ~10–20 W frente ao valor real — medidores que calculam potência no cubo ou no pedal (em vez de por velocidade angular na manivela) não sofrem esse viés.$m5151$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;