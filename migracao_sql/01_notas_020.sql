BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2493$nota-0289$m2493$, $m2494$9-12 meses de treino de endurance em idosos (60+) produzem ganhos de VO2máx de 19% (homens) e 22% (mulheres) — comparáveis a jovens, mas por mecanismos diferentes por sexo$m2494$, $m2495$contexto-atleta$m2495$,
  $m2496$contexto$m2496$, $m2497$conceito$m2497$,
  ARRAY[$m2498$mensal$m2498$]::text[], '{}'::text[],
  0.65, $m2499$revisar$m2499$, $m2500$Um estudo (Spina et al., 1993) com 15 homens (63±3 anos) e 16 mulheres (64±3 anos) submetidos a **9-12 meses de treino de endurance** mostrou ganhos de VO2máx de **19% nos homens e 22% nas mulheres** — magnitude que representa a **extremidade superior** dos ganhos tipicamente observados em adultos jovens no mesmo período de treino. Ou seja, o envelhecimento não reduz necessariamente a capacidade de resposta ao treino de VO2máx (treinabilidade), mesmo já havendo declínio de base relacionado à idade (ver nota-0207).

O mecanismo do ganho, porém, **difere por sexo**:
- **Homens:** o ganho de VO2máx veio de aumento de 15% no volume sistólico máximo (explicando dois terços do ganho, via débito cardíaco — mecanismo central) mais 7% de aumento na diferença arteriovenosa de O2 (mecanismo periférico).
- **Mulheres:** o ganho de VO2máx foi explicado **inteiramente** pelo aumento da diferença arteriovenosa de O2 (extração periférica de oxigênio pelo músculo treinado), **sem nenhum aumento** de volume sistólico ou desempenho ventricular esquerdo máximo.

Hipóteses para a ausência de resposta cardíaca central em mulheres idosas: menor expansão do volume plasmático com o treino, menor sensibilidade do barorreflexo cardiopulmonar, e maior rigidez vascular relacionada à deficiência de estrogênio pós-menopausa.

Nota de confiança: resultado de um único estudo com amostra pequena (n=31 no total) — a magnitude exata dos percentuais não deve ser generalizada, mas o padrão qualitativo (idosos ainda respondem bem ao treino; diferença de mecanismo por sexo) é biologicamente plausível e consistente com outras notas do cânone sobre não-respondedores (nota-0216).

Aplicação ao feedback: reforça que recomendar/manter treino de endurance estruturado em ciclistas mais velhos (60+) é justificado por ganhos de VO2máx potencialmente tão grandes quanto em atletas jovens — a idade avançada não deveria, por si só, reduzir a ambição de metas de melhoria de capacidade aeróbia no feedback dado ao atleta.$m2500$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2501$nota-0068$m2501$, $m2502$Força máxima raramente limita a performance no ciclismo: atleta usa só ~25-55% da força máxima mesmo em esforços duros$m2502$, $m2503$fisiologia$m2503$,
  $m2504$contexto$m2504$, $m2505$conceito$m2505$,
  ARRAY[$m2506$mensal$m2506$]::text[], ARRAY[$m2507$potência-série-temporal$m2507$, $m2508$cadência$m2508$]::text[],
  0.8, $m2509$ativo$m2509$, $m2510$Comparando a AEPF (força efetiva média no pedal) real usada durante corridas/treinos com a força máxima que o atleta consegue gerar (medida por uma série de esforços máximos curtos, <10s, seated ou standing), os autores mostram que força pura raramente é o fator limitante no ciclismo: no exemplo do livro, a força máxima do atleta era de ~1.100 N, mas o pico de força usado num sprint de prova real foi de apenas ~600 N (~55% do máximo), e na maior parte do tempo o atleta usava menos de 400 N (~35% do máximo) — mesmo pedalando no FTP durante um contrarrelógio, a força usada era de apenas ~25% da força máxima.

Exceção notável: a largada parada (standing start, CPV = 0) em BMX e algumas provas de pista é a única situação em que a força máxima realmente limita a performance.

Consequência prática: treinar força pura (ex.: musculação pesada e lenta) tem efeito limitado sobre a potência máxima de um ciclista treinado — o fator limitante de performance normalmente não é "quanta força o músculo consegue gerar", mas sim quanta potência (força × velocidade) o atleta consegue sustentar ao longo do tempo sem fadigar, o que depende muito mais dos sistemas energéticos (aeróbio/anaeróbio) do que de força bruta.$m2510$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2511$nota-0074$m2511$, $m2512$FTP como limiar aproximado de recrutamento significativo de fibras de contração rápida (Tipo II)$m2512$, $m2513$fisiologia$m2513$,
  $m2514$contexto$m2514$, $m2515$conceito$m2515$,
  ARRAY[$m2516$mensal$m2516$]::text[], ARRAY[$m2517$potência-média$m2517$, $m2518$FTP$m2518$]::text[],
  0.75, $m2519$ativo$m2519$, $m2520$As fibras musculares de contração lenta (Tipo I) são recrutadas ao máximo já em intensidades relativamente baixas (~40% do VO2máx), enquanto as fibras de contração rápida (Tipo IIa e, especialmente, Tipo IIx) só são recrutadas de forma significativa em intensidades bem mais altas. Evidências de eletromiografia e biópsias musculares sugerem que a potência de limiar funcional (FTP) representa, aproximadamente, não só um limiar de sustentabilidade de potência, mas também o ponto (em termos de força/potência, numa cadência autosselecionada) em que o recrutamento significativo de fibras rápidas começa.

É essa relação que fundamenta fisiologicamente a divisão da Quadrant Analysis (nota-0067) usando a força (AEPF) e velocidade (CPV) no FTP como linhas de corte — pedalar nos quadrantes de alta força (I e II) está associado a maior recrutamento de fibras rápidas. Ressalva do próprio livro: essa relação não é uma linha reta horizontal perfeita — na realidade é uma curva que cai da esquerda para a direita (o limiar de força para recrutar fibras rápidas é mais alto em baixa velocidade e mais baixo em alta velocidade), e a duração do esforço também influencia o recrutamento, mas isso não é capturado no modelo simplificado de 4 quadrantes.$m2520$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;