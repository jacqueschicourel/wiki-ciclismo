BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9262$nota-0259$m9262$, $m9263$Protocolo ACSM de volumes de fluido: 500-600mL 2-3h antes, 200-300mL a cada 10-15min durante, e reposição de 20-24 oz por libra perdida após o exercício$m9263$, $m9264$nutricao-e-energia$m9264$,
  $m9265$contexto$m9265$, $m9266$protocolo$m9266$,
  ARRAY[$m9267$diario$m9267$]::text[], '{}'::text[],
  0.6, $m9268$ativo$m9268$, $m9269$Protocolo prático de hidratação (McArdle, baseado em recomendações ACSM), com volumes específicos:

**Antes da atividade:**
1. Beber ~17 a 20 oz (≈500-590 mL) 2 a 3 horas antes.
2. Beber mais 7 a 10 oz (≈210-300 mL) após o aquecimento, 10 a 15 min antes do exercício.

**Durante a atividade:**
1. Beber ~28 a 40 oz por hora de exercício (≈830-1180 mL/h), fracionado em 7 a 10 oz (≈210-300 mL) a cada 10-15 minutos.

**Após a atividade:**
1. Repor rapidamente o fluido perdido (suor + urina) dentro de 2 horas, bebendo **20 a 24 oz (≈590-710 mL) para cada libra (0,45 kg) de peso corporal perdido por suor** — note que este volume de reposição pós-treino é maior que a simples equivalência 1:1 (450 mL por libra), refletindo que parte do líquido ingerido é excretado antes de restaurar plenamente o volume plasmático.

Meta geral (ACSM): evitar perda de peso por desidratação maior que 2% da massa corporal, e evitar mudanças excessivas no equilíbrio de eletrólitos.

Aplicação ao feedback: o Strava não captura ingestão de líquido nem peso corporal, então este protocolo não é executável automaticamente a partir dos dados de atividade — permanece como conteúdo educativo/de referência que o produto pode sugerir ao atleta antes e depois de sessões longas e quentes (`tempo-movimento` alto combinado com `temperatura` elevada), complementando a regra mais simples de reposição a 80% da taxa de sudorese (nota-0227) com quantidades concretas e cronograma de ingestão.$m9269$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9270$nota-0260$m9270$, $m9271$Reposição de sódio em exercício >1h: ACSM recomenda 0,5-0,7g de sódio por litro de fluido; perda diária de sal pode chegar a 13-17g em suor intenso no calor$m9271$, $m9272$nutricao-e-energia$m9272$,
  $m9273$contexto$m9273$, $m9274$protocolo$m9274$,
  ARRAY[$m9275$diario$m9275$]::text[], '{}'::text[],
  0.6, $m9276$ativo$m9276$, $m9277$Recomendações de reposição de sódio para exercício prolongado (>1h), especialmente em calor (McArdle/ACSM):

- **Bebidas esportivas devem conter 0,5 a 0,7 g de sódio por litro** de fluido consumido, para atividade com duração maior que 1 hora.
- Em esforço prolongado no calor, a perda de sal pelo suor pode chegar a **13 a 17 g de sal por dia** (2,3-3,4 g de sal por litro de suor) — cerca de 8 g a mais do que a ingestão alimentar típica.
- Nessa situação de déficit, uma correção prática sugerida é adicionar **cerca de 1/3 de colher de chá de sal de cozinha por litro de água**.
- Perda de potássio pelo suor é geralmente pequena (5-18 mEq mesmo em atividade competitiva intensa) e representa pouco ou nenhum risco imediato — compensada facilmente com frutas cítricas/bananas.

Contexto adicional: bebidas esportivas típicas contêm 10-25 mmol de sódio por litro; a concentração de sódio plasmático normal fica entre 138-142 mmol/L. Adicionar sódio à bebida de reposição (20-60 mmol/L) acelera a restauração do volume plasmático em comparação com água pura, porque sustenta o estímulo de sede e reduz a perda por urina.

**Nota de tensão numérica (2026-08-02, achado de auditoria adversarial):** a correção prática de "1/3 de colher de chá de sal por litro" citada acima equivale a ~0,75 g de sódio/L (1/3 colher ≈ 1,9g de NaCl × 39,3% de sódio no sal ≈ 0,75g), um valor ligeiramente acima do teto superior da faixa ACSM citada nesta mesma nota (0,5-0,7 g/L). Ambos os números são citação literal da mesma página-fonte (McArdle p.631) — a tensão já existe no texto original, não foi introduzida por esta nota. Leitura mais provável: a faixa ACSM (0,5-0,7g/L) é a recomendação de formulação para bebidas esportivas em geral, enquanto a "1/3 colher de chá" é uma correção prática aproximada especificamente para a situação de déficit de sódio em suor intenso no calor (contexto diferente, não uma bebida-padrão) — a fonte não reconcilia os dois números explicitamente, então tratar a colher de chá como aproximação de ordem de grandeza, não como valor exato a ser seguido à risca.

Aplicação ao feedback: como o Strava não mede ingestão nutricional nem composição do suor, este protocolo não é executável automaticamente — serve como conteúdo educativo a ser sugerido quando o sistema detecta sessões longas (`tempo-movimento` >1h) em `temperatura` elevada, complementando a recomendação de volume de fluido (nota-0227, nota-0259) com a dimensão de eletrólitos, especialmente relevante para atletas com histórico de cãibras por calor (ver nota-0261).$m9277$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9278$nota-0285$m9278$, $m9279$Déficit calórico moderado (300-500 kcal/dia) produz mais perda de gordura por unidade de déficit e menos recuperação de peso que déficits agressivos (500-1000+ kcal/dia)$m9279$, $m9280$nutricao-e-energia$m9280$,
  $m9281$contexto$m9281$, $m9282$conceito$m9282$,
  ARRAY[$m9283$mensal$m9283$]::text[], '{}'::text[],
  0.75, $m9284$ativo$m9284$, $m9285$Para perda de peso planejada (não o déficit agudo de uma prova longa, ver nota-0225), a faixa recomendada de déficit calórico diário é **300 a 1000 kcal abaixo do gasto energético diário**, mas dentro dessa faixa **um déficit moderado (300 a 500 kcal/dia) produz maior perda de gordura por unidade de déficit calórico do que uma restrição mais severa**. Além disso, atletas/indivíduos que criam déficits maiores para perder peso mais rapidamente **tendem a recuperar mais peso depois** do que os que perdem peso a um ritmo mais lento.

Implicação prática: a lógica "quanto maior o déficit, mais rápido e melhor o resultado" não se sustenta nem para a composição da perda (mais gordura vs. músculo por kcal de déficit) nem para a sustentabilidade do resultado (recuperação de peso). Um déficit moderado e sustentado ao longo do tempo é mais eficiente e mais duradouro que cortes agressivos e curtos.

Aplicação ao feedback: ao orientar um ciclista com objetivo declarado de perda de peso, a recomendação de déficit calórico diário deveria mirar a faixa de 300–500 kcal/dia como padrão, reservando déficits maiores (até ~1000 kcal/dia) apenas para períodos curtos e bem monitorados — evitando recomendar cortes agressivos e prolongados, que tendem a comprometer a qualidade da perda de peso e sua manutenção.$m9285$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;