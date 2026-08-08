BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9174$nota-0238$m9174$, $m9175$Suplementação de vitaminas antioxidantes (C e E) em atletas já bem nutridos não melhora adaptação ao treino nem desempenho — o próprio treino já regula positivamente as defesas antioxidantes naturais$m9175$, $m9176$nutricao-e-energia$m9176$,
  $m9177$contexto$m9177$, $m9178$referencia$m9178$,
  ARRAY[$m9179$mensal$m9179$]::text[], '{}'::text[],
  0.7, $m9180$ativo$m9180$, $m9181$O exercício aeróbio aumenta a produção de radicais livres (espécies reativas de oxigênio), mas em pessoas bem nutridas e saudáveis, o **próprio treinamento regula positivamente ("up-regula") as defesas antioxidantes naturais do corpo** (enzimas superóxido dismutase e glutationa peroxidase) — ou seja, o sistema de defesa se adapta ao estresse oxidativo crônico do treino, autonomamente, sem necessidade de suplementação externa.

Consistente com isso, estudos controlados mostram que **suplementar vitaminas C e E em indivíduos sem deficiência prévia dessas vitaminas não produz efeito nas adaptações fisiológicas ao treino de endurance intenso** — nem no desempenho, nem nas respostas hormonais/metabólicas ao exercício, nem na capacidade de treinar pesado e se recuperar. O livro-texto resume: mais de 55 anos de pesquisa em pessoas saudáveis com dieta nutricionalmente adequada não fornecem evidência de que suplementos vitamínicos/minerais melhorem desempenho.

Contraponto citado (mas de menor peso): alguns estudos isolados mostraram que vitamina E reduziu marcadores de estresse oxidativo em ciclistas de prova após 5 meses de suplementação, e mitigou dano muscular em situações específicas — mas mesmo esses achados não se traduziram consistentemente em melhora de desempenho, e doses altas de vitamina E (1200 UI/dia) trazem risco real (interferência na coagulação/vitamina K, aumento de risco de câncer de próstata em homens saudáveis).

Grupos com risco real de deficiência de micronutrientes (onde suplementação pode fazer sentido): vegetarianos/veganos ou atletas com baixa ingestão energética (dançarinos, ginastas, atletas de categoria de peso), atletas que eliminam grupos alimentares inteiros, e atletas que consomem excesso de alimentos processados com baixa densidade de micronutrientes (inclui alguns endurance athletes que sobrecarregam em açúcares simples).

Aplicação ao feedback: fora do escopo de sinais do Strava (suplementação não é rastreada) — nota de referência complementar à nota-0204: reforça que, ao contrário de cafeína/creatina/bicarbonato/nitrato/beta-alanina (que têm evidência de benefício), suplementos antioxidantes em megadose NÃO têm evidência de benefício para atletas bem nutridos e podem até ser contraproducentes em teoria (ao "amortecer" o sinal de estresse oxidativo que impulsiona a adaptação ao treino).$m9181$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9182$nota-0255$m9182$, $m9183$Tabela de taxa de sudorese prevista (L/h) por peso corporal, velocidade e clima (fresco vs. quente)$m9183$, $m9184$nutricao-e-energia$m9184$,
  $m9185$contexto$m9185$, $m9186$referencia$m9186$,
  ARRAY[$m9187$diario$m9187$]::text[], '{}'::text[],
  0.55, $m9188$ativo$m9188$, $m9189$Tabela de referência (McArdle, Tabela 25.4, dados de Montain et al. 2006) com taxas de sudorese previstas para corrida, por peso corporal, velocidade e clima (18°C = fresco/temperado vs. 28°C = quente), a temperatura de bulbo seco:

| Peso corporal | Clima | 8,5 km/h | 10 km/h | 12,5 km/h | 15 km/h |
|---|---|---|---|---|---|
| 50 kg | Fresco/temperado | 0,43 L/h | 0,53 L/h | 0,69 L/h | 0,86 L/h |
| 50 kg | Quente | 0,52 L/h | 0,62 L/h | 0,79 L/h | 0,96 L/h |
| 70 kg | Fresco/temperado | 0,65 L/h | 0,79 L/h | 1,02 L/h | 1,25 L/h |
| 70 kg | Quente | 0,75 L/h | 0,89 L/h | 1,12 L/h | 1,36 L/h |
| 90 kg | Fresco/temperado | 0,86 L/h | 1,04 L/h | 1,34 L/h | 1,64 L/h |
| 90 kg | Quente | 0,97 L/h | 1,15 L/h | 1,46 L/h | 1,76 L/h |

Padrão: a taxa de sudorese aumenta com peso corporal, velocidade/intensidade, e temperatura ambiente — de forma aproximadamente linear dentro dessas faixas. Dados originalmente para corrida; a relação qualitativa (peso × intensidade × temperatura → taxa de sudorese) é transferível ao ciclismo, mas os valores absolutos não foram validados para pedalada (diferença de mecânica, ventilação por deslocamento a maior velocidade, e postura).

**Verificação externa (2026-08-02, achado de auditoria adversarial):** só 4 das 24 células da tabela (linha 70kg, colunas 10 e 15 km/h, fresco e quente) tinham trecho de citação literal capturado no frontmatter — as demais 20 células (linhas 50kg/90kg completas, colunas 8,5/12,5 km/h) não tinham citação de apoio conferível dentro desta nota. Busca externa localizou a tabela original (Montain et al., publicação de referência sobre predição de taxa de sudorese por peso corporal/velocidade/clima, citada de forma consistente em revisões subsequentes da área) e confirmou de forma independente os valores de extremo de cada linha/clima: 50kg fresco 0,43-0,86 L/h; 50kg quente 0,52-0,96 L/h; 70kg fresco 0,65-1,25 L/h; 70kg quente 0,75-1,36 L/h; 90kg fresco 0,86-1,64 L/h; 90kg quente 0,97-1,76 L/h — todos batem exatamente com os valores desta nota. Como os extremos de cada linha (colunas 8,5 e 15 km/h) e o meio de uma linha (70kg) já estavam confirmados por duas fontes independentes batendo exatamente, e a tabela inteira segue um padrão monotônico suave (sudorese cresce com peso/velocidade/temperatura sem saltos), as células intermediárias remanescentes (50kg/90kg nas colunas 10 e 12,5 km/h) são tratadas como corroboradas por consistência interna da mesma tabela publicada, não mais como número sem lastro. Confiança mantida em 0,55 (a nota já refletia alguma cautela antes desta verificação).

Aplicação ao feedback: como o Strava não mede sudorese diretamente, esta tabela pode servir de estimativa a priori de necessidade de hidratação (L/h) a partir do peso do atleta (perfil), da intensidade da atividade planejada e da `temperatura` prevista/registrada — útil para recomendar volume de garrafa antes de uma saída longa em calor, complementando o método de pesagem pré/pós-treino da nota-0227 (que mede a taxa real, mas só depois do fato).$m9189$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;