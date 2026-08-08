BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2289$nota-0270$m2289$, $m2290$Roupa molhada perde ~90% de sua capacidade isolante — água conduz calor 25x mais rápido que o ar, elevando risco de hipotermia em frio+chuva/suor$m2290$, $m2291$contexto-atleta$m2291$,
  $m2292$direta$m2292$, $m2293$regra-interpretacao$m2293$,
  ARRAY[$m2294$diario$m2294$]::text[], ARRAY[$m2295$temperatura$m2295$]::text[],
  0.55, $m2296$ativo$m2296$, $m2297$Dado quantificado e de alto impacto prático: quando a roupa fica molhada — seja por chuva/umidade externa ou por condensação do próprio suor — ela **perde quase 90% de sua capacidade isolante**. Isso ocorre porque a água conduz calor **25 vezes mais rápido** que o ar. Uma vez molhada, a camada de roupa deixa de reter a "zona de ar aquecido" que normalmente isola o corpo do ambiente, e passa a acelerar a perda de calor em vez de retardá-la.

Isso é especialmente relevante em cenários combinados comuns no ciclismo: (a) suor acumulado em roupa de treino intenso seguido de queda de intensidade ou parada, (b) chuva durante o percurso, (c) descidas longas após subidas suadas, onde a combinação de vento relativo (nota-0266) + roupa molhada + queda de geração de calor metabólico (nota-0269) cria a condição de maior risco de hipotermia, mesmo em temperaturas moderadas (não necessariamente congelantes).

Aplicação ao feedback: quando o sistema observa `temperatura` baixa a moderada (ex. <15°C) combinada com sinais de esforço intenso e prolongado (sudorese esperada) seguido de queda de potência/velocidade (ex. início de descida ou parada), pode sinalizar risco elevado de resfriamento por roupa molhada e recomendar preventivamente troca de camada ou vestimenta impermeável/corta-vento antes de descidas longas em dias frios — mesmo quando a temperatura isolada não pareceria extrema.

**Nota sobre o limiar de temperatura (2026-08-02):** o "<15°C" é estimativa editorial desta nota, não citação literal de McArdle (o trecho-fonte só quantifica a perda de 90% do isolamento e a condutividade 25x, sem valor de temperatura). Paralelo externo de apoio: no triatlo, o uso de roupa de neoprene é obrigatório em água abaixo de ~14°C — reforça a mesma ordem de grandeza como corte de risco de frio já reconhecido no esporte de endurance, mas é outro contexto (natação, não ciclismo) e não substitui uma citação direta de McArdle. Confiança rebaixada (0,65→0,55) por essa indireção.$m2297$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2298$nota-0271$m2298$, $m2299$Gordura corporal funciona como isolante eficaz no frio (o oposto do calor) — existe uma temperatura ambiente ótima individual, mais fria para pessoas com mais gordura$m2299$, $m2300$contexto-atleta$m2300$,
  $m2301$contexto$m2301$, $m2302$conceito$m2302$,
  ARRAY[$m2303$mensal$m2303$]::text[], '{}'::text[],
  0.55, $m2304$ativo$m2304$, $m2305$Ao contrário do calor (onde gordura corporal excessiva é uma desvantagem termorreguladora, ver nota-0262), a gordura subcutânea funciona como **isolante eficaz no frio**: quando o fluxo sanguíneo periférico é desviado da "casca" corporal para o núcleo (vasoconstrição no frio), a camada de gordura retém o calor central de forma mais eficaz em pessoas com mais tecido adiposo. Isso é bem documentado em nadadores de águas abertas, que tipicamente têm mais gordura subcutânea que nadadores de piscina de elite equivalentes.

Consequência prática: **existe uma temperatura ambiente "ótima" individual**, que varia com a composição corporal e a intensidade do esforço. Exemplo do livro: uma pessoa com excesso de gordura em repouso a 26°C na água já pode suar durante esforço vigoroso — para essa pessoa, água mais fria (18°C) é mais favorável para esforço de alta intensidade. Já para uma pessoa magra, 18°C já é debilitante tanto em repouso quanto em atividade.

Aplicação ao feedback: a tolerância ao frio (assim como ao calor) não é uma constante universal — atletas mais magros sentirão o mesmo `temperatura` registrado no Strava como mais desafiador no frio do que atletas com mais gordura corporal, e o inverso se aplica ao calor. Isso reforça a necessidade de personalizar limiares de alerta de frio/calor por perfil corporal do atleta (peso/composição, se disponível), em vez de aplicar o mesmo limiar de `temperatura` a todos os usuários.$m2305$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2306$nota-0274$m2306$, $m2307$Protocolo de ascensão em estágios para prevenir mal agudo da montanha: máximo 300-350m/dia de ganho na altitude de sono acima de 2500m, +1 noite extra a cada 600-900m$m2307$, $m2308$contexto-atleta$m2308$,
  $m2309$contexto$m2309$, $m2310$protocolo$m2310$,
  ARRAY[$m2311$mensal$m2311$]::text[], '{}'::text[],
  0.6, $m2312$ativo$m2312$, $m2313$Protocolo prático de "ascensão em estágios" (staged ascent) para prevenir o mal agudo da montanha (AMS — dor de cabeça, náusea, tontura, fadiga, geralmente aparecendo acima de 2500m):

- Acima de 2500 m, a **altitude de sono não deve subir mais de 300-350 m por dia** em média (para indivíduos suscetíveis).
- Alpinistas devem passar várias noites entre 2500-3000 m antes de subir mais.
- **Adicionar uma noite extra a cada 600-900 m** adicionais de subida.
- Regra prática conhecida como **"suba alto, durma baixo"** (climb high–sleep low): evitar aumentos abruptos de mais de 600 m na altitude de sono quando já acima de 2500 m — é aceitável subir mais durante o dia (ex. escalada) desde que se desça para dormir em altitude menor.
- **A ascensão rápida a 4200 m praticamente garante alguma forma de AMS.**
- Se os sintomas de AMS não melhorarem após um dia de repouso, a recomendação é descer; um descenso de ~300 m geralmente alivia os sintomas.
- HAPE (edema pulmonar de altitude) afeta ~2% dos que sobem acima de 3000m; HACE (edema cerebral de altitude) afeta ~1% acima de 2700m — ambos potencialmente fatais e exigem descida imediata.

Aplicação ao feedback: relevante para ciclistas planejando provas ou passeios de múltiplos dias em grande altitude (granfondos de montanha, cicloturismo em cordilheiras) — não é executável a partir de uma atividade isolada do Strava, mas pode fundamentar um alerta/recomendação de planejamento quando o produto identificar que o atleta está se deslocando para eventos em altitude significativamente maior que sua altitude habitual de treino.$m2313$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;