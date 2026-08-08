BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2090$nota-0261$m2090$, $m2091$Continuum de doença por calor: cãibras, exaustão e golpe de calor — sinais de alerta e limiares de temperatura retal$m2091$, $m2092$contexto-atleta$m2092$,
  $m2093$direta$m2093$, $m2094$regra-interpretacao$m2094$,
  ARRAY[$m2095$diario$m2095$]::text[], ARRAY[$m2096$temperatura$m2096$, $m2097$tempo-movimento$m2097$, $m2098$FC (média/máx)$m2098$]::text[],
  0.6, $m2099$ativo$m2099$, $m2100$As três doenças por calor, em ordem crescente de gravidade (McArdle), com sinais distintivos:

1. **Cãibras por calor**: espasmos musculares involuntários, sustentados e que se espalham, durante ou após atividade intensa. A temperatura central geralmente **permanece normal** — não é hipertermia. Associada a atletas com alta taxa de sudorese e/ou alta concentração de sódio no suor. Prevenção: hidratação com sal e aumento da ingestão diária de sal nos dias anteriores à exposição ao calor.

2. **Exaustão por calor**: ocorre tipicamente em pessoas não aclimatadas na primeira onda de calor do verão ou no primeiro treino intenso de um dia quente. Sinais: pulso fraco e rápido, pressão arterial baixa em pé, dor de cabeça, tontura, fraqueza generalizada. A temperatura central **não** atinge níveis perigosos (permanece abaixo de 40°C/104°F). Tratamento: parar a atividade, mover para ambiente mais fresco, reidratação.

3. **Golpe de calor (heat stroke)** — emergência médica, forma mais grave: temperatura central **excede 40,5°C (105°F)** na forma clássica, com alteração do estado mental e ausência de sudorese; na forma por exercício (exertional heat stroke), a temperatura sobe a **41,5°C (106,7°F) ou mais**. Fatores predisponentes: baixo condicionamento, obesidade, aclimatização inadequada, disfunção das glândulas sudoríparas, desidratação. Sem tratamento imediato (resfriamento agressivo — imersão em água fria/gelada é o "padrão-ouro"), evolui para colapso circulatório e dano a múltiplos órgãos. Um em cada três sobreviventes de golpe de calor quase-fatal fica com disfunção orgânica permanente.

Aplicação ao feedback: nenhum desses limiares (temperatura retal, sinais clínicos) é medido pelo Strava — mas a combinação de `temperatura` ambiente alta + `tempo-movimento` prolongado + esforço intenso (FC elevada sustentada) é um proxy indireto de risco crescente ao longo desse continuum, especialmente em atletas sem histórico recente de treino em calor (não aclimatados, ver nota-0254) ou com sobrepeso/baixo condicionamento (ver nota-0262). O sistema pode usar essa combinação para emitir um alerta educativo (não diagnóstico) recomendando pausar/reduzir intensidade e buscar sombra/hidratação diante de qualquer mal-estar, sem tentar inferir diretamente qual estágio o atleta atingiu.$m2100$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2101$nota-0262$m2101$, $m2102$Excesso de gordura corporal reduz tolerância ao calor: golpe de calor fatal é 3,5x mais frequente em jovens adultos com sobrepeso$m2102$, $m2103$contexto-atleta$m2103$,
  $m2104$contexto$m2104$, $m2105$conceito$m2105$,
  ARRAY[$m2106$mensal$m2106$]::text[], '{}'::text[],
  0.6, $m2107$ativo$m2107$, $m2108$O excesso de gordura corporal representa uma desvantagem termorregulatória mensurável em ambiente quente, por três mecanismos combinados:

1. **Isolamento térmico indesejado**: o calor específico da gordura é maior que o do músculo, então mais tecido adiposo retarda a condução de calor do núcleo para a periferia (o oposto do que se quer em ambiente quente).
2. **Menor razão superfície corporal/massa**: pessoas maiores e mais gordas têm proporcionalmente menos área de pele disponível para evaporação de suor por unidade de massa a resfriar.
3. **Maior custo metabólico** de atividades com sustentação de peso — mais massa para movimentar gera mais calor metabólico a dissipar.

Resultado prático citado no McArdle: **golpe de calor fatal ocorre 3,5 vezes mais frequentemente em jovens adultos com sobrepeso excessivo** do que em pessoas de tamanho corporal médio. O exemplo do livro é o jogador de futebol americano Korey Stringer, que morreu de golpe de calor com IMC de 40,8.

Aplicação ao feedback: como o Strava não fornece composição corporal (apenas peso, se o atleta preencher o perfil), este dado não gera regra automática — mas justifica que, ao calcular alertas de risco de calor (nota-0253, nota-0261), atletas com IMC elevado ou histórico de sobrepeso no perfil devem receber um limiar de alerta mais conservador (temperatura mais baixa) do que atletas magros, dado o risco elevado e bem documentado.$m2108$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2109$nota-0263$m2109$, $m2110$Estudo controlado: o capacete de ciclismo moderno não aumenta o estresse térmico nem a sensação térmica percebida em calor úmido$m2110$, $m2111$contexto-atleta$m2111$,
  $m2112$contexto$m2112$, $m2113$conceito$m2113$,
  ARRAY[$m2114$diario$m2114$]::text[], '{}'::text[],
  0.6, $m2115$ativo$m2115$, $m2116$Estudo específico de ciclismo (McArdle, Capítulo 25): 14 ciclistas competitivos (10 homens, 4 mulheres) pedalaram por 90 minutos a 60% do VO2pico em duas condições de calor — quente-seco (35°C, 20% umidade relativa) e quente-úmido (35°C, 70% umidade relativa) — com e sem capacete protetor. Foram medidos consumo de oxigênio, FC, temperatura central, de pele e da cabeça, percepção de esforço e sensação térmica percebida.

Resultado principal: **usar o capacete NÃO aumentou o estresse térmico nem a sensação térmica percebida** (nem da cabeça, nem do corpo como um todo), apesar da crença comum entre ciclistas competitivos de que andar sem capacete reduziria o desconforto térmico. Isso é atribuído ao design do capacete comercial moderno, que mantém características aerodinâmicas e leves com portas de ventilação para resfriamento convectivo e evaporativo.

Como esperado, o ambiente quente-úmido produziu maior estresse térmico geral do que o quente-seco (independente do uso de capacete) — a umidade relativa segue sendo o fator ambiental dominante (ver nota-0251, nota-0253), não o equipamento.

Aplicação ao feedback: como o Strava não registra uso de capacete, este achado não gera regra automática — mas é conteúdo educativo útil para desmistificar, junto a ciclistas, a crença de que remover o capacete ajuda na regulação térmica em dias quentes; a recomendação de segurança (sempre usar capacete) não compromete a termorregulação segundo este estudo controlado.$m2116$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;