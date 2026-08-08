BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6779$nota-0073$m6779$, $m6780$Quando agir sobre desequilíbrio bilateral: diferença >10% entre pernas, ou GPA >35 W sentado; cautela com \"puxar\" o pedal$m6780$, $m6781$metricas-de-potencia$m6781$,
  $m6782$direta$m6782$, $m6783$regra-interpretacao$m6783$,
  ARRAY[$m6784$mensal$m6784$]::text[], ARRAY[$m6785$potência-série-temporal$m6785$]::text[],
  0.75, $m6786$ativo$m6786$, $m6787$Critérios práticos para decidir se vale a pena intervir sobre um desequilíbrio bilateral identificado via GPR/GPA:

1. **Diferença de mais de 10% na potência liberada entre as pernas** → investigar se é discrepância real de força muscular ou um problema de padrão de movimento/ajuste de bike (bike fit).
2. **GPA (potência absorvida) maior que 35 W em ambas as pernas, estando sentado** → para ciclista com 3+ anos de treino sério, os autores sugerem deliberadamente direcionar o joelho em direção ao guidão na subida do pedal e apontar levemente a ponta do pé para baixo ao longo de todo o curso do pedal (para reduzir a potência absorvida na subida).

**Cautela importante**: apesar da tentação de "corrigir" a técnica de pedalada, 3 linhas de evidência citadas no livro desaconselham tentar deliberadamente "puxar" o pedal para cima: (a) ciclistas de elite na verdade puxam menos na subida do que ciclistas não-elite (eles minimizam a potência absorvida em vez de ativamente puxar); (b) puxar deliberadamente na subida do pedal gasta mais energia e é menos eficiente; (c) modificar deliberadamente o padrão de aplicação de força ao longo do pedal para enfatizar o "puxar" reduz a eficiência metabólica — o padrão de pedalada de cada pessoa é como uma "impressão digital", e mudá-lo pode prejudicar a eficiência.

Aplicação ao feedback: um desequilíbrio bilateral identificado nos dados não deve gerar automaticamente uma recomendação de "puxar mais o pedal" — a orientação baseada em evidência é reduzir a potência absorvida (empurrar de forma mais eficiente na descida, minimizar resistência na subida), não ativamente aumentar a tração para cima.$m6787$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6788$nota-0076$m6788$, $m6789$A relação potência-duração é curvilínea, não linear: interpolar entre dois pontos conhecidos gera erro grande$m6789$, $m6790$metricas-de-potencia$m6790$,
  $m6791$direta$m6791$, $m6792$regra-interpretacao$m6792$,
  ARRAY[$m6793$mensal$m6793$]::text[], ARRAY[$m6794$potência-máx$m6794$]::text[],
  0.85, $m6795$ativo$m6795$, $m6796$A queda de potência sustentável conforme a duração aumenta segue uma relação não-linear (curvilínea) com o tempo — a queda entre durações curtas (ex.: 10s e 30s) é acentuada, mas conforme a duração se aproxima de ~1 hora, a potência sustentável tende a um platô, que corresponde aproximadamente ao FTP.

Por causa dessa não-linearidade, **interpolar linearmente entre dois pontos conhecidos da curva potência-duração de um atleta produz erros grandes.** Exemplo do livro: interpolando linearmente entre um esforço máximo de 20 segundos e um de 20 minutos, a potência estimada para 8 minutos seria de ~500 W — mas o modelo Potência-Duração (curva ajustada corretamente) indica apenas ~380 W para essa mesma duração. Essa diferença de ~120 W ilustra por que a modelagem adequada (não a interpolação simples) é necessária para prever a potência sustentável numa duração para a qual não há dado real.

Aplicação ao feedback: nunca estimar a potência-alvo de um atleta para uma duração específica (ex.: planejar pacing para uma prova de X minutos) por interpolação linear entre dois esforços máximos conhecidos de durações diferentes — usar sempre um modelo de curva ajustada (Potência Crítica/Power Duration Model) ou, na ausência dele, dados reais de esforços máximos na duração mais próxima possível.$m6796$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6797$nota-0077$m6797$, $m6798$Pmax: potência máxima numa única volta de pedal (substitui o critério antigo de \"5 segundos\")$m6798$, $m6799$metricas-de-potencia$m6799$,
  $m6800$direta$m6800$, $m6801$conceito$m6801$,
  ARRAY[$m6802$mensal$m6802$]::text[], ARRAY[$m6803$potência-máx$m6803$]::text[],
  0.8, $m6804$ativo$m6804$, $m6805$Pmax é a maior potência que o atleta consegue gerar numa duração mínima de uma volta completa de pedal com as duas pernas (não mais os "5 segundos" usados no Power Profile clássico). É essencialmente a medida mais pura da potência neuromuscular máxima que o ciclista consegue produzir, porque minimiza a influência de fadiga e da sobreposição de outros sistemas de energia que ainda contaminava um pouco a métrica de 5 segundos.

Contexto histórico: o critério de 5 segundos existia por limitação técnica de medidores de potência antigos (picos de dado espúrios eram mais comuns e difíceis de filtrar) — com medidores modernos e análise de dados mais avançada, tornou-se viável usar diretamente a potência de uma única volta de pedal, que também é capturada com mais frequência no dia a dia (mais dados = métrica mais robusta) do que esperar por um esforço máximo dedicado de 5s completos.

Aplicação ao feedback: ao buscar o pico de potência neuromuscular de uma atividade no Strava (dado por segundo, não por volta de pedal), usar o pico de potência mais curto disponível (idealmente 1s) como aproximação de Pmax — picos isolados de curtíssima duração são o sinal mais confiável de capacidade neuromuscular máxima, mais robusto que a antiga janela de 5s.$m6805$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;