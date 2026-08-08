BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6152$nota-0052$m6152$, $m6153$\"Tempo em zona\" de potência pode enganar: potência não tem inércia fisiológica como a FC$m6153$, $m6154$metricas-de-potencia$m6154$,
  $m6155$direta$m6155$, $m6156$regra-interpretacao$m6156$,
  ARRAY[$m6157$diario$m6157$]::text[], ARRAY[$m6158$potência-série-temporal$m6158$, $m6159$tempo-em-zona$m6159$, $m6160$FC (média/máx)$m6160$]::text[],
  0.85, $m6161$ativo$m6161$, $m6162$Diferente da frequência cardíaca — que tem inércia fisiológica (responde com atraso e "suaviza" automaticamente incursões muito curtas em alta intensidade) — a potência responde instantaneamente, sem atraso. Isso torna o gráfico de "tempo em zona/nível de potência" potencialmente enganoso: um padrão de 15 s a 400 W alternado com 15 s a 100 W, sustentado por 1 hora inteira, resultaria em "30 minutos no nível de 400 W" no gráfico de tempo-em-zona — mas 400 W contínuos talvez só sejam sustentáveis por ~4 minutos reais para esse atleta. Ou seja, o tempo-em-zona de potência não reflete a real exigência fisiológica de sustentar aquele nível continuamente.

Consequência prática citada pelos autores: "tempo em nível/zona" é uma métrica bem mais confiável quando aplicada à FC do que quando aplicada à potência, justamente por causa dessa ausência de inércia fisiológica na potência.

Aplicação ao feedback: ao reportar "X minutos em Zona Y" com base em potência bruta segundo a segundo, ter cautela ao inferir demanda fisiológica real a partir desse número isolado — esforços curtos e intermitentes numa zona alta (ex.: microbursts, fartlek) podem somar bastante "tempo em zona" sem representar o mesmo estresse fisiológico de sustentar aquela potência continuamente. Preferir olhar também a duração de cada incursão individual na zona, não só o total acumulado.$m6162$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6163$nota-0053$m6163$, $m6164$Curva de Potência Média Máxima (MMP): como interpretar inclinações, platôs e picos$m6164$, $m6165$metricas-de-potencia$m6165$,
  $m6166$direta$m6166$, $m6167$protocolo$m6167$,
  ARRAY[$m6168$mensal$m6168$]::text[], ARRAY[$m6169$potência-máx$m6169$]::text[],
  0.8, $m6170$ativo$m6170$, $m6171$A Curva de Potência Média Máxima (MMP, Mean Maximal Power) é o gráfico da melhor potência média real do atleta para cada duração possível (segundo a segundo) — não é um modelo matemático, é o registro literal dos melhores esforços já feitos, extraído de todo o histórico de arquivos de potência.

Como interpretar: mudanças na inclinação da curva revelam transições entre sistemas de energia predominantes (ex.: inclinação consistente de 20 s a 2,5 min pode indicar predomínio do sistema anaeróbio nessa faixa, com mudança de inclinação depois disso sinalizando transição para VO2máx/sistema de lactato). Uma "elevação" (hump) destacada na faixa de 3–6 min indica um ponto forte em potência de VO2máx; um platô na curva pode indicar uma fraqueza naquela faixa de duração específica.

Requisitos para uma leitura válida: (1) a curva deve ser construída sobre um período de dados razoavelmente longo (pelo menos 6 meses, idealmente um ano inteiro) para capturar o verdadeiro potencial do atleta em todas as durações; (2) os valores só são válidos se vierem de esforços genuinamente máximos naquela duração específica — não se pode inferir a capacidade máxima de 6 minutos a partir de um esforço de 5 minutos (mesmo que os dois estejam próximos), é preciso ter feito de fato um esforço máximo de 6 minutos para aquele ponto da curva ser confiável.

Aplicação ao feedback: a MMP Curve é a base de dados sobre a qual a Power Duration Curve (modelo ajustado, nota-0037) é construída — sem esforços máximos reais suficientes e bem distribuídos ao longo de várias durações, tanto a MMP quanto os modelos derivados dela (FTP modelado, FRC, Pmax) ficam menos confiáveis.$m6171$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6172$nota-0055$m6172$, $m6173$\"Match\" (fósforo): esforço ≥20% acima do FTP por ≥1 min; tabela de potência por duração$m6173$, $m6174$metricas-de-potencia$m6174$,
  $m6175$direta$m6175$, $m6176$referencia$m6176$,
  ARRAY[$m6177$diario$m6177$]::text[], ARRAY[$m6178$potência-máx$m6178$, $m6179$FTP$m6179$]::text[],
  0.8, $m6180$ativo$m6180$, $m6181$"Queimar um fósforo" (burn a match) é o termo popular do ciclismo para um esforço duro e decisivo (ataque, resposta a um ataque, subir forte um morro). Os autores propõem uma definição quantitativa: um esforço **pelo menos 20% acima do FTP, sustentado por pelo menos 1 minuto**. Para esforços mais longos que 1 minuto, o percentual acima do FTP necessário para "contar" como match cai — ou seja, a definição de match é sensível à duração.

Tabela 6.2 do livro (exemplo para atleta com FTP = 330 W):

| Duração | % do FTP | Potência (W) |
|---|---|---|
| 1 min | ≥120% | 396 |
| 5 min | 114–120% | 376–396 |
| 10 min | 108–114% | 356–376 |
| 20 min | 100–108% | 330–356 |

Os autores ressaltam que não existe uma definição exata e universal de "match" — esses números são um ponto de partida ilustrativo, e o "tamanho da caixa de fósforos" (quantidade de matches disponíveis) varia de atleta para atleta. O conceito de "matchbook" tem 4 objetivos práticos: (1) definir o que é um match para aquele atleta específico, (2) descobrir o tamanho do seu estoque de matches, (3) tentar aumentar esse estoque com treino, e (4) aprender a queimar os matches no momento certo da prova.

Aplicação ao feedback: contar quantos "matches" (nesse sentido quantitativo) um atleta queimou numa prova, e em que momentos, ajuda a explicar objetivamente por que ele pode ter sido "descolado" mais tarde (esgotamento do estoque) ou por que teve um bom resultado (matches bem distribuídos/guardados para o momento decisivo).$m6181$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;