BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3307$nota-0240$m3307$, $m3308$Tabela de características metabólicas e contráteis dos tipos de fibra (I, IIa, IIx, IIb) e distribuição em atletas de elite por esporte (90-95% tipo I em fundistas/esquiadores)$m3308$, $m3309$fisiologia$m3309$,
  $m3310$contexto$m3310$, $m3311$referencia$m3311$,
  ARRAY[$m3312$mensal$m3312$]::text[], '{}'::text[],
  0.7, $m3313$ativo$m3313$, $m3314$O McArdle apresenta uma tabela de referência (Tabela 18.2) que classifica 4 subtipos de fibra muscular esquelética humana por características metabólicas e contráteis:

| Característica | Tipo I | Tipo IIa | Tipo IIx | Tipo IIb |
|---|---|---|---|---|
| Velocidade de contração | Lenta | Moderadamente rápida | Rápida | Muito rápida |
| Resistência à fadiga | Alta | Razoavelmente alta | Intermediária | Baixa |
| Atividade típica | Aeróbia | Anaeróbia de longa duração | Anaeróbia de curta duração | Anaeróbia de curta duração |
| **Duração máxima de uso sustentável** | **Horas** | **<30 min** | **<5 min** | **<1 min** |
| Produção de força | Baixa | Média | Alta | Muito alta |
| Densidade mitocondrial | Alta | Alta | Intermediária | Baixa |
| Densidade capilar | Alta | Intermediária | Baixa | Baixa |
| Combustível principal | Triacilglicerol | Fosfocreatina, glicogênio | Fosfocreatina, glicogênio | Fosfocreatina, glicogênio |

A coluna "duração máxima de uso" é o dado mais concretamente útil: fibras Tipo I sustentam esforço por horas, enquanto Tipo IIx e IIb se esgotam em minutos — o que explica fisiologicamente por que esforços de endurance (>30-60 min) dependem quase exclusivamente do pool de fibras Tipo I, e por que sprints/esforços supra-VO2máx recorrem cada vez mais a IIx/IIb à medida que a duração cai abaixo de alguns minutos.

Dado populacional complementar: pessoas em geral (homens, mulheres, crianças) têm em média 45-55% de fibras Tipo I nos membros. Atletas de elite de endurance (fundistas, esquiadores cross-country) chegam a 90-95% de fibras Tipo I no gastrocnêmio — a composição de fibra mais extrema associada a alto desempenho aeróbio registrada no cânone. Levantadores de peso, jogadores de hóquei no gelo e velocistas têm predominância de fibras rápidas e menor capacidade aeróbia relativa. Atletas de meio-fundo e provas de potência (arremesso, salto) tendem a ter proporção ~50/50. A composição de fibra é majoritariamente determinada geneticamente; o texto reconhece que "treinamento específico pode produzir alguma modificação", mas não quantifica conversão de tipo de fibra por treinamento.

Esta é uma limitação relevante para o produto: composição de fibra não é mensurável via Strava (exigiria biópsia muscular) e a variação interindividual é grande mesmo dentro do mesmo grupo esportivo — por isso a nota permanece `aplicacao: contexto`, útil apenas para explicar o "porquê" fisiológico por trás de por que ciclistas de endurance têm um teto biológico para potência de sprint e por que a duração de um esforço muda o mix de fibras recrutado, sem gerar regra automática a partir de dados do Strava.$m3314$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3315$nota-0241$m3315$, $m3316$Limiar de catecolaminas: norepinefrina sobe a partir de ~50% do VO2máx, epinefrina só a partir de ~75% do VO2máx$m3316$, $m3317$fisiologia$m3317$,
  $m3318$contexto$m3318$, $m3319$conceito$m3319$,
  ARRAY[$m3320$diario$m3320$]::text[], '{}'::text[],
  0.6, $m3321$revisar$m3321$, $m3322$Estudo em cicloergômetro com 10 homens (McArdle, Fig. 20.10) mediu a resposta de catecolaminas plasmáticas (norepinefrina e epinefrina) em intensidades crescentes expressas em %VO2máx. Achados:

- **Norepinefrina** começa a subir de forma acentuada a partir de intensidades que excedem **~50% do VO2máx**.
- **Epinefrina** permanece praticamente inalterada até a intensidade ultrapassar **~75% do VO2máx** — só a partir daí sobe de forma perceptível.
- No esforço máximo, a norepinefrina aumenta de 2 a 6 vezes o valor basal.

A resposta simpatoadrenal ao exercício se relaciona mais com a intensidade **relativa** (percentual do VO2máx/capacidade individual) do que com a intensidade absoluta — ou seja, o mesmo percentual de esforço dispara resposta hormonal semelhante em pessoas treinadas e destreinadas, mesmo com potências absolutas muito diferentes.

Isto é um dado de laboratório (N=10 homens, medição de catecolaminas plasmáticas — não disponível via Strava) que ajuda a explicar fisiologicamente por que esforços acima de ~75-80% do VO2máx (faixa que se aproxima do limiar/FTP e das zonas de alta intensidade) costumam ser percebidos como qualitativamente "mais duros" e mais estressantes do ponto de vista hormonal/simpático do que esforços moderados — não é apenas uma questão de acúmulo de lactato, mas também de uma resposta adrenérgica que só decola nessa faixa. Isso é consistente com (mas não prova) a ideia de que o limiar funcional de potência (FTP) marca uma transição fisiológica mais ampla do que apenas o balanço lactato produção/remoção.

Aplicação ao feedback: nota de contexto fisiológico — não gera regra automática porque não há medição de catecolaminas no Strava. Pode ser usada apenas para explicar didaticamente por que treinos acima de zona 4-5 (aprox. >75-80% do VO2máx) tendem a ser percebidos como desproporcionalmente mais estressantes que a diferença de potência sugeriria.$m3322$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;