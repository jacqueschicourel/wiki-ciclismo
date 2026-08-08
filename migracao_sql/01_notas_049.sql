BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6551$nota-0064$m6551$, $m6552$Tabela de referência: TSS e IF típicos para diferentes tipos de prova (Tabela 7.4)$m6552$, $m6553$metricas-de-potencia$m6553$,
  $m6554$direta$m6554$, $m6555$referencia$m6555$,
  ARRAY[$m6556$diario$m6556$]::text[], ARRAY[$m6557$TSS$m6557$, $m6558$IF$m6558$, $m6559$tempo-decorrido$m6559$]::text[],
  0.85, $m6560$ativo$m6560$, $m6561$Tabela 7.4 do livro — exemplos reais de TSS e IF por tipo/duração de evento, úteis como referência de calibração (seleção representativa; a tabela completa tem ~24 linhas):

| Evento | Duração | TSS | IF |
|---|---|---|---|
| Recuperação fácil Nível 1, terreno plano, Cat. III masc. | 1:00 | 12 | 0,37 |
| Recuperação fácil Nível 2, terreno ondulado, Cat. II masc. | 2:30 | 60 | 0,49 |
| Prova de ciclocross, masters fem. 40–45 | 0:45 | 61 | 0,92 |
| Criterium Pro 1/2 americano, divisão 1 | 1:00 | 73 | 0,86 |
| Criterium feminino profissional | 0:45 | 80 | 1,06 |
| CRI 40 km, Cat. II masc. | 0:53 | 89 | 1,02 |
| Criterium nacional típico, Cat. III | 1:57 | 109 | 0,75 |
| Criterium nacional típico, Pro 1/2 | 2:35 | 118 | 0,67 |
| Mount Evans Hill Climb 2018, Cat. I | 2:02 | 126 | 0,79 |
| Campeonato nacional masters de estrada 2018, 55–59 anos | 2:34 | 160 | 0,79 |
| Prova de estrada muito montanhosa nacional 2018, Cat. I, grupo de perseguição pequeno | 4:55 | 266 | 0,74 |
| Campeonato nacional elite dos EUA 2018, Cat. I | 5:22 | 272 | 0,71 |
| Ironman Lake Placid 2018, top 3 fem. 40–45 (só o segmento de bike) | 5:40 | 278 | 0,70 |
| Etapa 1 de prova nacional americana por etapas 2018 | 4:55 | 292 | 0,78 |
| Vuelta a España 2018, etapa 12, fuga, top 10 | 4:22 | 323 | 0,86 |
| Leadville 100 MTB 2018, vencedora fem. 35–40 | 9:18 | 354 | 0,62 |
| Tour de France 2018, etapa de montanha 16, top 5 | 5:13 | 359 | 0,83 |
| Prova de MTB de 24 horas, elite masters masc. | 24:00 | 1058 | 0,74 |
| Brevet de 1.000 km em 3 dias, só 5h de sono total, fem. 40 anos | 42:00 | 1610 | 0,62 |

Padrão geral visível na tabela: eventos mais curtos e intensos (criteriums, CRIs) tendem a IF mais alto (próximo ou acima de 1,0); eventos muito longos (ultraendurance, brevets, MTB de 24h) têm IF bem mais baixo (0,6–0,8) mas TSS acumulado extremamente alto, por causa da duração.

Aplicação ao feedback: esta tabela serve como calibração de "senso comum" — permite comparar o TSS/IF de uma atividade do atleta com eventos de referência de perfil semelhante, ajudando a comunicar de forma mais concreta o que aquele número de TSS representa.$m6561$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6562$nota-0065$m6562$, $m6563$Fórmula da AEPF (força efetiva média aplicada ao pedal)$m6563$, $m6564$metricas-de-potencia$m6564$,
  $m6565$direta$m6565$, $m6566$referencia$m6566$,
  ARRAY[$m6567$diario$m6567$]::text[], ARRAY[$m6568$potência-série-temporal$m6568$, $m6569$cadência$m6569$]::text[],
  0.9, $m6570$ativo$m6570$, $m6571$**Fórmula: AEPF = (P × 60) ÷ (C × 2 × π × CL)**, onde AEPF = força efetiva média aplicada ao pedal (em newtons, N); P = potência (watts); C = cadência (rpm); CL = comprimento da manivela (em metros); as constantes 60, 2 e π convertem cadência em velocidade angular (radianos/segundo).

AEPF é a força tangencial média (perpendicular à manivela) exercida pelas duas pernas combinadas ao longo de uma volta completa (360°) do pedal, derivada matematicamente da potência e da cadência — não precisa de um medidor de força dedicado, qualquer medidor de potência com cadência permite calculá-la.

Aplicação ao feedback: aplicar esta fórmula ponto a ponto (ou por intervalo) sobre a série de potência e cadência de uma atividade permite construir o eixo de força da Quadrant Analysis (nota-0067) e identificar em que trechos do treino/prova o atleta trabalhou com alta ou baixa força no pedal.$m6571$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6572$nota-0066$m6572$, $m6573$Fórmula da CPV (velocidade circunferencial do pedal)$m6573$, $m6574$metricas-de-potencia$m6574$,
  $m6575$direta$m6575$, $m6576$referencia$m6576$,
  ARRAY[$m6577$diario$m6577$]::text[], ARRAY[$m6578$cadência$m6578$]::text[],
  0.9, $m6579$ativo$m6579$, $m6580$**Fórmula: CPV = (C × CL × 2 × π) ÷ 60**, onde CPV = velocidade circunferencial do pedal (metros/segundo); C = cadência (rpm); CL = comprimento da manivela (metros).

CPV é a velocidade com que o pedal se move ao longo do círculo que descreve durante a pedalada. Tecnicamente, a velocidade de encurtamento muscular (ou velocidade angular da articulação) seria a medida mais correta, mas CPV é um excelente preditor de ambas. Como o comprimento da manivela é geralmente constante para um mesmo atleta, a cadência sozinha poderia ser usada como proxy — os autores preferem CPV por consistência com a convenção científica de curvas força-velocidade do músculo.

Aplicação ao feedback: aplicar esta fórmula à cadência registrada no Strava para obter o eixo de velocidade da Quadrant Analysis (nota-0067) — junto com a AEPF (força), permite mapear cada ponto da atividade nos quatro quadrantes força × velocidade.$m6580$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;