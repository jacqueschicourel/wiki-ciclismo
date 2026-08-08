BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8773$nota-0123$m8773$, $m8774$Estimar necessidade calórica de uma prova a partir dos kJ registrados pelo medidor de potência$m8774$, $m8775$nutricao-e-energia$m8775$,
  $m8776$direta$m8776$, $m8777$protocolo$m8777$,
  ARRAY[$m8778$diario$m8778$]::text[], ARRAY[$m8779$potência-média$m8779$, $m8780$tempo-decorrido$m8780$]::text[],
  0.65, $m8781$ativo$m8781$, $m8782$Método prático para estimar a necessidade calórica real de uma prova/treino longo usando o trabalho em kJ registrado pelo medidor de potência:

1. Marcar (durante ou após o download) o ponto em que o atleta começou a sentir fadiga/exaustão significativa.
2. Verificar quantos kJ de trabalho foram registrados até aquele ponto (ou ao longo de toda a prova).
3. Converter kJ em kcal aproximadamente numa razão próxima de 1:1,1 (exemplo do livro: 2.000 kJ ≈ 2.200 kcal).
4. Comparar essa necessidade calórica estimada contra o que o atleta efetivamente consumiu durante a prova (ex.: 500 kcal consumidas vs. ~2.200 kcal gastas) para identificar déficit de reposição energética.

Aplicação ao feedback: para atividades longas (>2h) com dados de potência, calcular o gasto energético estimado a partir do total de kJ da atividade e comparar contra relatos ou estimativas de ingestão do atleta (se disponíveis) — um grande déficit entre kJ gastos e calorias repostas é um sinal relevante para recomendações de nutrição/hidratação em provas futuras, especialmente se o atleta relatar "bonk"/pane de energia no fim de provas longas.$m8782$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8783$nota-0155$m8783$, $m8784$Crossover metabólico: gordura predomina em baixa intensidade, participação de carboidrato cresce progressivamente com o aumento da intensidade$m8784$, $m8785$nutricao-e-energia$m8785$,
  $m8786$contexto$m8786$, $m8787$conceito$m8787$,
  ARRAY[$m8788$diario$m8788$]::text[], '{}'::text[],
  0.6, $m8789$ativo$m8789$, $m8790$O "crossover metabólico" descreve a transição contínua (não abrupta) na contribuição relativa dos substratos energéticos conforme a intensidade do exercício aumenta: predomínio de lipídios em intensidades baixas, com participação crescente de carboidratos em intensidades mais altas. A localização exata do ponto de cruzamento é influenciada por intensidade, duração, nível de treinamento, alimentação, disponibilidade de glicogênio, temperatura e altitude. O treinamento de endurance desloca esse ponto para intensidades mais altas (maior capacidade de oxidar gordura em potências mais elevadas), fenômeno relacionado à "flexibilidade metabólica" (ver nota-0156).

Aplicação ao feedback: fundamenta, em nível conceitual, por que sessões longas em baixa intensidade (Zona 2) são o principal estímulo para melhorar a capacidade oxidativa de gordura e por que a dependência de carboidrato aumenta abruptamente em esforços de alta intensidade (relevante para orientações de fueling/nutrição durante sessões longas vs. intervalados, mas não gera um gatilho direto de interpretação de dado do Strava).$m8790$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8791$nota-0156$m8791$, $m8792$Flexibilidade metabólica: capacidade treinável de alternar rapidamente entre gordura e carboidrato conforme a demanda do exercício$m8792$, $m8793$nutricao-e-energia$m8793$,
  $m8794$contexto$m8794$, $m8795$conceito$m8795$,
  ARRAY[$m8796$mensal$m8796$]::text[], '{}'::text[],
  0.55, $m8797$ativo$m8797$, $m8798$Um ciclista metabolicamente flexível consegue: oxidar predominantemente gordura em esforços leves, aumentar rapidamente a utilização de carboidrato quando a intensidade exige, e retornar eficientemente ao metabolismo oxidativo após esforços intensos (recuperação entre picos). Essa capacidade reduz desperdício energético e melhora a sustentabilidade do desempenho em provas longas. É desenvolvida principalmente por treinamento de endurance consistente (aumento de densidade mitocondrial, enzimas oxidativas, capacidade de armazenar/poupar glicogênio).

Aplicação ao feedback: reforça, conceitualmente, a importância de volume consistente em intensidade baixa (Zona 2) na construção de base aeróbia — não gera uma regra de interpretação de dado isolado, mas serve de justificativa para recomendações de distribuição de intensidade ao longo do tempo (complementar às notas de periodização e distribuição de intensidade do Livro 1).$m8798$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8799$nota-0201$m8799$, $m8800$Tabela de ingestão de carboidrato durante o exercício por duração: até 60min geralmente desnecessário (exceto bochecho em provas intensas), 1-2h → 30-60g/h, 2-3h → 60-90g/h, >3h → 90-120g/h (se treinado)$m8800$, $m8801$nutricao-e-energia$m8801$,
  $m8802$direta$m8802$, $m8803$referencia$m8803$,
  ARRAY[$m8804$diario$m8804$]::text[], ARRAY[$m8805$tempo-decorrido$m8805$, $m8806$tempo-movimento$m8806$]::text[],
  0.6, $m8807$ativo$m8807$, $m8808$Tabela de referência (recomendações atuais da nutrição esportiva) para ingestão de carboidrato durante o exercício, por faixa de duração: até 60 minutos — normalmente desnecessária (exceto bochecho de carboidrato em provas muito intensas próximas de 60min, que pode melhorar desempenho via efeito central/sensorial, sem necessidade de ingestão real); 1-2 horas — 30-60 g/h; 2-3 horas — 60-90 g/h; acima de 3 horas — 90-120 g/h (somente em atletas com intestino treinado para tolerar essa quantidade, ver nota-0202 sobre carboidratos múltiplos). Recomendações devem ser individualizadas — nem todos toleram grandes quantidades.

**Convenção de fronteira (2026-08-02, achado de auditoria adversarial):** a fonte não especifica se os limites das faixas (60min, 120min, 180min) são inclusivos ou exclusivos. Convenção adotada por este cânone: o valor-limite pertence à faixa em que aparece como **teto** — ou seja, exatamente 60min ainda é "até 60min" (faixa 1); exatamente 120min ainda é "1-2h" (30-60g/h, não 60-90g/h); exatamente 180min ainda é "2-3h" (60-90g/h, não 90-120g/h). Esta é uma decisão operacional do projeto (não é regra do cânone/fonte), adotada por ser a leitura mais natural de como a tabela é normalmente lida em nutrição esportiva (o valor de fronteira "fecha" a faixa anterior antes de abrir a próxima).

Aplicação ao feedback: o produto pode usar a duração da sessão (tempo-movimento/tempo-decorrido, já disponível via Strava) para sugerir uma faixa de ingestão de carboidrato apropriada em sessões longas planejadas ou passadas (ex.: "essa sessão de 3h20 provavelmente exigia 90-120g/h de carboidrato para sustentar a potência-alvo") — não é possível verificar a ingestão real a partir do Strava, apenas sugerir a faixa recomendada com base na duração.$m8808$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;