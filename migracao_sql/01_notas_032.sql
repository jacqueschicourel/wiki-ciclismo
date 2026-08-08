BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3805$nota-0167$m3805$, $m3806$Lactate Shuttle (George Brooks, anos 1980): lactato é transportado entre fibras/órgãos e reutilizado como combustível — não é resíduo metabólico$m3806$, $m3807$limiares-e-lactato$m3807$,
  $m3808$contexto$m3808$, $m3809$conceito$m3809$,
  ARRAY[$m3810$mensal$m3810$]::text[], '{}'::text[],
  0.6, $m3811$ativo$m3811$, $m3812$O modelo do Lactate Shuttle (Brooks, década de 1980) propõe que o lactato produzido em um tecido não fica "acumulado" localmente como resíduo — ele é transportado (via transportadores MCT1/MCT4) para fibras musculares oxidativas, coração, fígado, cérebro e rins, onde é reconvertido em piruvato e usado para gerar ATP. Atletas altamente treinados apresentam maior expressão desses transportadores, maior capacidade de oxidação e maior eficiência mitocondrial — permitindo reutilizar mais lactato como combustível durante o próprio exercício, o que reduz sua acumulação sanguínea para uma dada potência.

Aplicação ao feedback: nota de fundamentação conceitual — explica, no nível mecanístico, por que atletas mais treinados sustentam potências mais altas com concentrações de lactato mais baixas (base fisiológica para a evolução da FTP/limiares ao longo do treinamento, já tratada operacionalmente pelas notas de FTP do Livro 1). Não gera regra de interpretação direta de dado Strava.$m3812$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3813$nota-0168$m3813$, $m3814$Mito refutado: 'o lactato causa fadiga muscular' — é apenas um marcador correlacionado à intensidade, não a causa; pode até ter efeito protetor$m3814$, $m3815$limiares-e-lactato$m3815$,
  $m3816$contexto$m3816$, $m3817$conceito$m3817$,
  ARRAY[$m3818$mensal$m3818$]::text[], '{}'::text[],
  0.6, $m3819$ativo$m3819$, $m3820$Desmistifica a crença tradicional de que o acúmulo de lactato causaria diretamente a queda de força/fadiga muscular. Lactato e fadiga aumentam juntos porque ambos são consequência do aumento da intensidade — correlação, não causalidade. A fadiga real resulta de múltiplos mecanismos (alterações iônicas, disponibilidade energética, acúmulo de fosfato inorgânico, fatores neurais centrais e periféricos), e evidências sugerem que o lactato pode até exercer efeito protetor sobre a função muscular.

Aplicação ao feedback: relevante como cautela terminológica — o produto não deveria usar frases como "acúmulo de lactato causou a queda de desempenho" ao explicar fadiga para o usuário; a fadiga em dados de potência/pacing (ex.: queda de potência ao final de uma sessão longa, ver notas de durabilidade do Livro 1) deve ser descrita em termos de fadiga multifatorial, não atribuída a uma única molécula.$m3820$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3821$nota-0169$m3821$, $m3822$Treinamento não reduz a produção de lactato — melhora sua utilização/remoção; objetivo do treino é 'utilizar melhor', não 'produzir menos'$m3822$, $m3823$limiares-e-lactato$m3823$,
  $m3824$contexto$m3824$, $m3825$conceito$m3825$,
  ARRAY[$m3826$mensal$m3826$]::text[], '{}'::text[],
  0.55, $m3827$ativo$m3827$, $m3828$Correção de outro equívoco comum: atletas de elite não produzem menos lactato que atletas amadores — eles continuam produzindo grandes quantidades. A diferença está na capacidade de utilizá-lo/removê-lo (via maior transporte MCT1/MCT4, maior capacidade oxidativa e eficiência mitocondrial, ver nota-0167), o que resulta em menor concentração sanguínea observada para uma dada potência, e no deslocamento dos limiares fisiológicos (LT1/LT2/MLSS, ver Capítulo 11) para intensidades mais altas.

Aplicação ao feedback: reforça que o objetivo de longo prazo do treinamento (refletido em uma FTP crescente ao longo de meses, ver notas de PMC/FTP do Livro 1) é a capacidade de sustentar potências mais altas com "menos estresse metabólico relativo", não uma redução abstrata de "lactato" — útil como cautela de linguagem em textos de feedback educativo.$m3828$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3829$nota-0170$m3829$, $m3830$Limiares fisiológicos são regiões de transição graduais, não 'interruptores' binários — o organismo não muda de estado ao ultrapassar um watt específico$m3830$, $m3831$limiares-e-lactato$m3831$,
  $m3832$contexto$m3832$, $m3833$conceito$m3833$,
  ARRAY[$m3834$mensal$m3834$]::text[], '{}'::text[],
  0.6, $m3835$ativo$m3835$, $m3836$Advertência conceitual central do capítulo: limiares fisiológicos (LT1, LT2, VT1, VT2, MLSS, etc.) não são pontos de corte binários onde o metabolismo muda abruptamente de "modo aeróbio" para "modo anaeróbio". São regiões de transição graduais entre estados fisiológicos, identificadas por métodos laboratoriais em pontos convenientes de uma curva contínua.

Aplicação ao feedback: reforça diretamente uma orientação já presente no Livro 1 (nota-0047) — o produto não deve tratar as fronteiras de zona (ex.: limite entre Nível 3 e Nível 4 na tabela de Coggan, nota-0022) como transições fisiológicas abruptas ao gerar feedback; esforços próximos ao limite de uma zona devem ser interpretados com a mesma cautela dada a esforços claramente dentro dela.$m3836$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3837$nota-0171$m3837$, $m3838$LT1 (primeiro limiar de lactato): primeiro aumento consistente do lactato acima do repouso — domínio moderado, predomínio oxidativo, sustentável por horas$m3838$, $m3839$limiares-e-lactato$m3839$,
  $m3840$contexto$m3840$, $m3841$conceito$m3841$,
  ARRAY[$m3842$mensal$m3842$]::text[], '{}'::text[],
  0.6, $m3843$ativo$m3843$, $m3844$LT1 é o ponto em que a concentração sanguínea de lactato começa a subir de forma consistente acima dos valores de repouso (a produção começa a superar discretamente a remoção, mas ainda em equilíbrio metabólico amplo). Características: predomínio do metabolismo oxidativo, alta contribuição de oxidação de gordura, baixa perturbação da homeostase, ventilação ainda proporcional ao VO2, sustentável por várias horas. Para ciclistas de endurance, grande parte do treinamento aeróbio de base é realizado abaixo ou próximo dessa intensidade — corresponde aproximadamente ao "limiar de lactato" citado de forma mais simplificada na nota-0145 do Livro 1 (Nível 2-3 de Coggan).

Aplicação ao feedback: nota de contexto fisiológico — o LT1 não é medido diretamente pelo Strava (exige teste de lactato/ergoespirometria), mas corresponde aproximadamente à fronteira entre os Níveis 2 e 3 da tabela de Coggan (nota-0022), já operacionalizável via %FTP nas notas existentes do Livro 1.$m3844$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;