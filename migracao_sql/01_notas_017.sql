BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2190$nota-0265$m2190$, $m2191$Idosos bem treinados e mulheres toleram calor tão bem quanto jovens/homens de fitness equivalente — diferenças são de mecanismo (sudorese vs. circulação), não de capacidade$m2191$, $m2192$contexto-atleta$m2192$,
  $m2193$contexto$m2193$, $m2194$conceito$m2194$,
  ARRAY[$m2195$mensal$m2195$]::text[], '{}'::text[],
  0.6, $m2196$ativo$m2196$, $m2197$Dois achados sobre variação individual na tolerância ao calor que **não** devem ser confundidos com menor capacidade física:

**Idade**: quando controlado por tamanho corporal, composição, condicionamento aeróbio, hidratação e grau de aclimatização, **não há diferença relevante relacionada à idade** na capacidade termorregulatória durante exercício ou na aclimatização ao calor. Corredores de meia-idade bem treinados não mostram déficit termorregulatório na maratona comparados a corredores mais jovens. O que existe é um atraso no início da sudorese em idosos (por sensibilidade reduzida dos termorreceptores, menor output das glândulas sudoríparas, ou desidratação crônica por sede reduzida) — mas isso reflete menor condicionamento/aclimatização típica dessa faixa etária, não um limite fisiológico inerente à idade.

**Gênero**: mulheres toleram o estresse térmico do exercício **pelo menos tão bem quanto** homens de condicionamento aeróbio e aclimatização equivalentes — comparações antigas que mostravam pior tolerância feminina tinham a falha metodológica de testar mulheres numa % maior do VO2max do que homens. Mulheres suam menos que homens (mesmo tendo mais glândulas sudoríparas ativas por área de pele) mas compensam usando mais os mecanismos circulatórios de dissipação de calor, enquanto homens dependem mais de resfriamento evaporativo — dois caminhos fisiológicos diferentes chegando a tolerância térmica equivalente.

Aplicação ao feedback: ao interpretar quedas de desempenho em calor, não usar idade ou gênero como justificativa automática de menor tolerância — a variável relevante é o nível de condicionamento aeróbio e o grau de aclimatização recente (ver nota-0254) daquele atleta específico, não sua categoria demográfica.$m2197$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2198$nota-0266$m2198$, $m2199$Índice de sensação térmica (wind-chill): fórmula oficial e tempos de risco de geladura por temperatura e velocidade do vento$m2199$, $m2200$contexto-atleta$m2200$,
  $m2201$contexto$m2201$, $m2202$referencia$m2202$,
  ARRAY[$m2203$diario$m2203$]::text[], '{}'::text[],
  0.55, $m2204$ativo$m2204$, $m2205$Fórmula oficial do National Weather Service (revisão de 2001) para o índice de sensação térmica (wind-chill), que combina temperatura do ar e velocidade do vento:

**Wind Chill (°F) = 35,74 + 0,6215×T − 35,75×(V^0,16) + 0,4275×T×(V^0,16)**

Onde T = temperatura do ar em °F, V = velocidade do vento em mph.

A tabela derivada da fórmula mostra, por exemplo, que com temperatura de −1°C (30°F) e vento de 25 mph, a sensação térmica equivale a −12,7°C (9°F); a mesma velocidade de vento a 12,2°C (10°F) produz sensação de −23,8°C (−11°F). A tabela também fornece **tempos estimados até geladura de pele exposta**: zonas de risco marcam limiares de 30, 10 e 5 minutos até congelamento da pele exposta, dependendo da combinação temperatura/vento.

Importante para quem se desloca contra o vento (ex.: ciclista pedalando contra o vento): **a velocidade relativa do vento soma-se à velocidade de deslocamento**. Exemplo do livro: correr a 8 mph contra um vento de 12 mph cria o equivalente a um vento de 20 mph (soma); correr a 8 mph com o vento de 12 mph nas costas cria um vento relativo de apenas 4 mph (subtração). O mesmo princípio se aplica à velocidade de um ciclista.

Aplicação ao feedback: o Strava fornece `temperatura` mas não velocidade do vento, então o wind-chill completo não é calculável automaticamente a partir dos dados de atividade — porém, para ciclistas, o próprio deslocamento a alta velocidade já produz um "vento relativo" significativo mesmo em dia calmo (ex.: pedalar a 30 km/h já gera sensação de vento de ~30 km/h contra o corpo), o que deveria ser considerado ao interpretar `temperatura` baixa combinada com alta `velocidade` em rotas de descida ou contrarrelógio — o risco de frio é maior do que a temperatura ambiente isolada sugere.$m2205$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2206$nota-0267$m2206$, $m2207$Tabela de estágios de hipotermia por temperatura central: de tremores máximos (35°C) a fibrilação ventricular (28°C) e óbito (13,7°C em adultos)$m2207$, $m2208$contexto-atleta$m2208$,
  $m2209$contexto$m2209$, $m2210$referencia$m2210$,
  ARRAY[$m2211$diario$m2211$]::text[], '{}'::text[],
  0.55, $m2212$ativo$m2212$, $m2213$Tabela de referência (McArdle, adaptada do ACSM Position Stand, Tabela 25.7) com os estágios de hipotermia por temperatura central (retal), com efeitos fisiológicos observados a cada nível — normal é 37,0°C:

| Estágio | Temp. central | Efeito fisiológico |
|---|---|---|
| Normotermia | 37,0°C | Sem efeito perceptível |
| Hipotermia leve | 35,0°C | Tremores máximos, pressão arterial aumentada |
| | 34,0°C | Amnésia, disartria, julgamento prejudicado |
| | 33,0°C | Ataxia, apatia |
| Hipotermia moderada | 32,0°C | Estupor |
| | 31,0°C | Tremores cessam, pupilas dilatam |
| | 30,0°C | Arritmias cardíacas, queda do débito cardíaco |
| | 29,0°C | Inconsciência |
| Hipotermia severa | 28,0°C | Fibrilação ventricular provável, hipoventilação |
| | 27,0°C | Perda de reflexos e movimento voluntário |
| | 25,0°C | Fluxo sanguíneo cerebral reduzido |
| | 18,0°C | Assistolia |
| — | 13,7°C | Menor temperatura de sobrevivência registrada em adulto (hipotermia acidental) |

Ponto crítico: **os tremores (shivering), o mecanismo primário de geração de calor no frio, cessam em torno de 31°C** — abaixo disso a pessoa perde a principal defesa ativa contra a queda adicional de temperatura, acelerando a progressão.

Aplicação ao feedback: o Strava não mede temperatura central, então esta tabela não gera regra automática — mas serve como referência de gravidade para conteúdo educativo de segurança em treinos de frio extremo (ex.: descidas longas após subidas suadas, onde o risco de hipotermia é maior por combinação de roupa molhada + vento + baixa temperatura, ver nota-0270).$m2213$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;