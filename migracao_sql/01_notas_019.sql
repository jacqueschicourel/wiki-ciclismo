BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2386$nota-0281$m2386$, $m2387$Fórmula do peso-meta (goal body weight) a partir da massa livre de gordura atual e do %gordura desejado$m2387$, $m2388$contexto-atleta$m2388$,
  $m2389$contexto$m2389$, $m2390$protocolo$m2390$,
  ARRAY[$m2391$mensal$m2391$]::text[], '{}'::text[],
  0.85, $m2392$ativo$m2392$, $m2393$Fórmula para calcular o **peso corporal-meta** de um atleta a partir de sua massa livre de gordura (FFM) atual e de um percentual de gordura desejado, assumindo que a FFM permanece constante durante o processo (premissa que só se sustenta se a perda for de fato majoritariamente gordura, não músculo):

**Peso-meta = FFM atual ÷ (1,00 − %gordura desejado, em fração decimal)**

Passo a passo, com exemplo do livro (homem de 91 kg, 20% de gordura, que quer chegar a 10%):
1. Massa de gordura atual = 91 kg × 0,20 = 18,2 kg
2. FFM atual = 91 − 18,2 = 72,8 kg
3. Peso-meta = 72,8 ÷ (1,00 − 0,10) = 72,8 ÷ 0,90 = **80,9 kg**
4. Perda de gordura necessária = 91 − 80,9 = **10,1 kg**

Essa fórmula é mais adequada para definir metas de composição corporal do que simplesmente "perder X kg", porque ancora a meta num %gordura-alvo realista em vez de um peso-tabela genérico — relevante em ciclismo, onde o objetivo raramente é "pesar menos" isoladamente, mas sim otimizar a razão potência/peso (nota-0033) sem sacrificar massa muscular/potência.

Limitação importante: o cálculo assume que toda a perda de peso vem de gordura e a FFM não muda — na prática, déficits calóricos agressivos ou mal planejados também reduzem FFM (ver notas sobre déficit calórico moderado e sobre perda de peso via exercício vs. restrição calórica), o que faz o peso real necessário para atingir o %gordura-alvo ser diferente do calculado.$m2393$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2394$nota-0282$m2394$, $m2395$IMC (BMI) mal classifica atletas musculosos; ciclistas de elite do Tour de France mantêm IMC baixo e notavelmente homogêneo (~21,5) ao longo de décadas$m2395$, $m2396$contexto-atleta$m2396$,
  $m2397$contexto$m2397$, $m2398$conceito$m2398$,
  ARRAY[$m2399$mensal$m2399$]::text[], '{}'::text[],
  0.72, $m2400$ativo$m2400$, $m2401$O **Índice de Massa Corporal (IMC = massa corporal em kg ÷ estatura² em m)** classifica mal atletas com grande massa muscular: por não distinguir massa magra de massa gorda, um atleta muito musculoso pode ser classificado como "sobrepeso" ou "obeso" por padrões de IMC populacionais mesmo com baixo percentual de gordura — problema documentado em jogadores de futebol americano, halterofilistas, lutadores pesados e atletas de arremesso.

No polo oposto, ciclistas de estrada de elite apresentam **IMC consistentemente baixo e extremamente homogêneo**, estável ao longo de décadas de competição no Tour de France:
- 1997: 170 competidores, IMC médio 21,5 (estatura 1,79 m, massa 68,7 kg)
- 2000: 162 competidores, IMC médio 21,5 (mesma estatura, massa 69,1 kg)
- 2005: 189 competidores, IMC 21,5 (mesma estatura, massa 71 kg)
- 2012 (vencedor Bradley Wiggins): mais alto que a média dos ciclistas (1,90 m) mas com massa proporcionalmente equivalente (69,0 kg)

A conclusão do texto-fonte: **a homogeneidade de composição corporal entre os ciclistas de elite torna improvável que variáveis de composição corporal, por si só, expliquem diferenças individuais de desempenho em ciclismo** dentro desse grupo já pré-selecionado por nível competitivo — reforçando que, uma vez que o atleta já está numa faixa de IMC/composição corporal compatível com o esporte, otimizar ainda mais o peso tem retorno decrescente, e outros fatores (potência absoluta, capacidade aeróbia, tática) pesam mais para diferenciar desempenho entre pares.

Aplicação: útil como contraponto educativo quando um ciclista se compara a padrões de IMC de saúde pública geral (pensados para população sedentária, não para atletas) — o IMC isoladamente não deve orientar decisões de peso de um ciclista treinado; e mesmo entre ciclistas de elite já magros, buscar composição corporal ainda mais extrema tem baixo retorno esperado de desempenho.$m2401$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2402$nota-0283$m2402$, $m2403$Composição corporal de referência de ciclistas de estrada profissionais (literatura compilada): ~71,3 kg, 11,6% de gordura, FFM 63,0 kg$m2403$, $m2404$contexto-atleta$m2404$,
  $m2405$contexto$m2405$, $m2406$referencia$m2406$,
  ARRAY[$m2407$mensal$m2407$]::text[], '{}'::text[],
  0.72, $m2408$ativo$m2408$, $m2409$Compilação da literatura científica (múltiplos estudos, valor médio) sobre composição corporal de **ciclistas de estrada profissionais do sexo masculino**: massa corporal média de **71,3 kg**, **11,6% de gordura corporal**, massa livre de gordura (FFM) de **63,0 kg**.

Para contextualizar dentro do espectro de esportes de endurance masculinos (mesma fonte, mesma tabela): corredores de maratona são o extremo mais magro (59,4 kg, 3,3% gordura, FFM 57,4 kg), seguidos de ginastas (4,6%) e nadadores (6,8%); corredores de fundo/meio-fundo têm 11,8% de gordura (67,2 kg) — muito próximo do valor de ciclistas profissionais. Ciclistas de elite, portanto, não são o grupo mais magro do endurance, mas ficam na faixa baixa-moderada, consistentes com a necessidade de gerar potência absoluta maior que corredores de longa distância.

Não há tabela equivalente com dados de ciclistas profissionais do sexo feminino nesta fonte.

Aplicação: serve como ponto de referência de "normalidade" para %gordura de ciclistas de alto nível ao interpretar dados de composição corporal de um atleta — útil para contextualizar se um valor medido está dentro, acima ou abaixo do observado em ciclistas de elite, sem tratar esse valor como meta obrigatória (ver nota-0282 sobre retorno decrescente de otimizar ainda mais a composição corporal).$m2409$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;