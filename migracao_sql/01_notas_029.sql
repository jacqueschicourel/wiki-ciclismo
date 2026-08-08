BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3469$nota-0257$m3469$, $m3470$Desidratação de apenas 1,9% da massa corporal já reduz VO2max em 10% e resistência em 22%; 4,3% reduz VO2max em 22% e resistência em 48%$m3470$, $m3471$fisiologia$m3471$,
  $m3472$contexto$m3472$, $m3473$referencia$m3473$,
  ARRAY[$m3474$diario$m3474$]::text[], '{}'::text[],
  0.6, $m3475$ativo$m3475$, $m3476$Dados quantificados sobre o custo de desempenho da desidratação progressiva (McArdle, citando experimentos controlados):

- **Desidratação de 1,9% da massa corporal**: VO2max cai ~10%, resistência/desempenho de endurance cai ~22%.
- **Desidratação de 4,3% da massa corporal**: VO2max cai ~22%, resistência de caminhada cai ~48%.
- De forma geral, **até uma perda de apenas 2% da massa corporal já prejudica adversamente o desempenho de exercício**.

**Correção de interpretação (2026-08-02, achado de auditoria adversarial):** a frase original desta nota afirmava que a relação era "não linear... efeito acelerado" conforme a desidratação se agrava. Refazendo a conta com os próprios números citados acima: a razão de agravamento da desidratação (4,3÷1,9 ≈ 2,26x) é praticamente igual à razão de queda de VO2max (22÷10 = 2,2x) e à razão de queda de resistência (48÷22 ≈ 2,18x) — as três razões batem entre si (~2,2x), o que descreve uma relação aproximadamente **linear/proporcional**, não um efeito acelerado supra-linear (que exigiria as razões de queda de desempenho superarem 2,26x). Os números citados da fonte estão corretos; a interpretação qualitativa anterior não batia com a própria aritmética da nota. Correção: no intervalo observado (1,9%→4,3% de desidratação), a queda de desempenho escala de forma aproximadamente proporcional à magnitude da desidratação — não há evidência, nestes dois pontos de dado, de um efeito de aceleração.

Aplicação ao feedback: como o Strava não registra peso corporal pré/pós-treino, este dado não pode ser aplicado automaticamente sem que o atleta forneça essa medição (ver nota-0227 sobre o protocolo de pesagem). Serve como base quantitativa para justificar, ao atleta, por que quedas de potência/pace em sessões longas e quentes (sem explicação por fadiga muscular ou intensidade) provavelmente refletem desidratação, e para dar peso à recomendação de monitorar peso corporal em sessões longas (>2h) especialmente quando `temperatura` está elevada e a queda de desempenho observada (potência, pace) é desproporcional à duração/intensidade planejada.$m3476$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3477$nota-0268$m3477$, $m3478$Humanos têm muito menos capacidade de aclimatização ao frio do que ao calor — a adaptação principal é comportamental (evitar/isolar), não fisiológica$m3478$, $m3479$fisiologia$m3479$,
  $m3480$contexto$m3480$, $m3481$conceito$m3481$,
  ARRAY[$m3482$mensal$m3482$]::text[], '{}'::text[],
  0.6, $m3483$ativo$m3483$, $m3484$Ao contrário da aclimatização ao calor (rápida e robusta — ver nota-0254), **humanos têm capacidade muito limitada de adaptação fisiológica ao frio crônico**. A estratégia primária de populações adaptadas ao frio extremo (esquimós, lapões) é comportamental: evitar o frio ou minimizar seus efeitos via vestimenta e abrigo — por exemplo, o interior de um iglu mantém-se a ~15,6°C mesmo com temperaturas externas congelantes.

Os únicos três indícios de aclimatização (fraca) ao frio crônico documentados:
1. Tremores (shivering) começam em uma temperatura corporal mais baixa, porque mais calor passa a ser gerado sem tremor.
2. Melhora na capacidade de dormir no frio.
3. Mudança na distribuição de fluxo sanguíneo periférico — conservando calor no núcleo ou aquecendo extremidades para prevenir lesão por frio.

Um exemplo isolado de adaptação mais robusta é o das Ama (mergulhadoras coreanas/japonesas), que mostram aumento de ~25% na taxa metabólica de repouso no inverno e um limiar de tremor mais alto — mas esse é um caso de exposição extrema e repetida ao longo da vida, não replicável por treino recreativo.

Aplicação ao feedback: diferente do calor (onde ~10-14 dias de exposição repetida trazem ganhos fisiológicos mensuráveis e acionáveis, nota-0254), não há uma "aclimatização ao frio" comparável a esperar ou recomendar para ciclistas que treinam em clima frio — a estratégia eficaz permanece comportamental (vestimenta em camadas, evitar roupa molhada — ver nota-0270) e não fisiológica. O sistema não deve inferir "aclimatização ao frio" a partir de exposição repetida a `temperatura` baixa da mesma forma que infere aclimatização ao calor.$m3484$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3485$nota-0269$m3485$, $m3486$Atividade física gera calor metabólico suficiente para manter temperatura central estável em ar até -30°C, sem depender de vestimenta pesada$m3486$, $m3487$fisiologia$m3487$,
  $m3488$contexto$m3488$, $m3489$conceito$m3489$,
  ARRAY[$m3490$diario$m3490$]::text[], '{}'::text[],
  0.6, $m3491$ativo$m3491$, $m3492$O calor metabólico gerado pela **atividade física em si** (não pelos tremores/shivering) é o principal mecanismo de defesa do corpo contra o frio durante o exercício. O metabolismo energético durante movimento sustenta uma temperatura central constante mesmo em ar de até **−30°C (−22°F)**, sem depender de uma barreira pesada e restritiva de roupas — desde que a intensidade do exercício seja suficiente para gerar esse calor.

Ponto importante: é a **temperatura interna** (não a produção de calor per se) que media a resposta termorreguladora ao frio — ou seja, se a intensidade do exercício cai (por exemplo, por fadiga) o suficiente para reduzir a geração de calor, o tremor pode reaparecer mesmo durante atividade vigorosa, se a temperatura central ainda estiver baixa.

Para efeito de comparação de magnitude: o tremor por frio severo pode elevar o consumo de oxigênio a ~1200 mL/min, similar à demanda metabólica de exercício leve a moderado — ou seja, o corpo "gasta" energia significativa só para se manter aquecido em repouso no frio extremo, energia que o exercício ativo já supre como subproduto do movimento.

Aplicação ao feedback: para ciclistas treinando em `temperatura` baixa mas mantendo esforço/potência consistente, o risco de hipotermia central durante o pedal ativo é relativamente baixo (o próprio exercício gera calor suficiente) — o maior risco surge em **paradas prolongadas, descidas longas sem pedalar, ou quedas bruscas de intensidade** em clima frio, quando a geração de calor metabólico cai mas a exposição ao frio/vento continua. Isso pode informar alertas específicos para segmentos de baixa potência/parada em `temperatura` baixa, mais do que para o esforço sustentado em si.$m3492$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;