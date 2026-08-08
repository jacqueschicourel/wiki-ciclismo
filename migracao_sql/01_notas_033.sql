BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4012$nota-0172$m4012$, $m4013$LT2 (segundo limiar de lactato): ponto em que o lactato passa a crescer rapidamente — domínio pesado/severo, fadiga inevitável em poucos minutos$m4013$, $m4014$limiares-e-lactato$m4014$,
  $m4015$contexto$m4015$, $m4016$conceito$m4016$,
  ARRAY[$m4017$mensal$m4017$]::text[], '{}'::text[],
  0.6, $m4018$ativo$m4018$, $m4019$LT2 é o ponto em que a concentração de lactato passa a crescer de forma acentuadamente mais rápida (aceleração da glicólise, maior participação de carboidratos, ventilação desproporcional, instabilidade crescente do equilíbrio ácido-base). Acima do LT2 não há mais estado estável — o atleta ainda consegue sustentar o esforço por alguns minutos, mas a fadiga é inevitável. Corresponde aproximadamente ao MLSS/FTP (ver nota-0174 e nota-0176) e à fronteira do domínio "severo" (ver nota-0178).

Aplicação ao feedback: assim como o LT1, não é medido diretamente pelo Strava — mas seu correlato prático operacionalizável já existe no cânone via FTP e Nível 4 de Coggan (nota-0022). Serve de base fisiológica para por que esforços sustentados pouco acima da FTP têm duração inevitavelmente curta (minutos, não dezenas de minutos).$m4019$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4020$nota-0173$m4020$, $m4021$LT1/LT2 não são valores fixos (mito refutado: '2 mmol/L e 4 mmol/L universais'); OBLA 4mmol/L é referência prática, não ponto fisiológico universal$m4021$, $m4022$limiares-e-lactato$m4022$,
  $m4023$contexto$m4023$, $m4024$conceito$m4024$,
  ARRAY[$m4025$mensal$m4025$]::text[], '{}'::text[],
  0.6, $m4026$ativo$m4026$, $m4027$Refuta a simplificação didática comum de que LT1 = 2 mmol/L e LT2 = 4 mmol/L (OBLA — Onset of Blood Lactate Accumulation) seriam valores fisiológicos universais. Na realidade, as concentrações absolutas de lactato nos limiares variam amplamente entre indivíduos — dois atletas podem ter o mesmo comportamento fisiológico com concentrações completamente diferentes. Métodos modernos de avaliação priorizam a análise individual da curva de lactato (tendências), não números absolutos fixos.

Aplicação ao feedback: reforça a desambiguação já presente na nota-0145 do Livro 1 sobre OBLA — caso o produto algum dia receba dados de teste de lactato do usuário (input externo), não deve assumir que 4 mmol/L é o limiar anaeróbio desse atleta específico; é apenas uma referência de conveniência histórica, não uma medida fisiológica individualizada.$m4027$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4028$nota-0174$m4028$, $m4029$MLSS (Maximum Lactate Steady State): maior intensidade com lactato estável — bom indicador de intensidade máxima sustentável, mas exige múltiplos testes em dias diferentes$m4029$, $m4030$limiares-e-lactato$m4030$,
  $m4031$contexto$m4031$, $m4032$conceito$m4032$,
  ARRAY[$m4033$mensal$m4033$]::text[], '{}'::text[],
  0.55, $m4034$ativo$m4034$, $m4035$MLSS é a maior intensidade em que a concentração de lactato permanece relativamente estável ao longo de um exercício contínuo (acima dela, o lactato aumenta progressivamente sem estabilizar). É considerado um dos melhores indicadores laboratoriais de intensidade máxima sustentável, mas sua determinação exige múltiplos testes de carga constante em dias diferentes — por isso seu uso prático cotidiano é limitado, mesmo em contexto de laboratório.

Aplicação ao feedback: Política de ativação aplicada — por depender de protocolo laboratorial multi-dia não derivável do Strava, permanece aplicacao: contexto (referência conceitual). Sua relevância prática para o produto é indireta: FTP (nota-0019 do Livro 1) é usado como proxy prático do MLSS, conforme detalhado na nota-0176.$m4035$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4036$nota-0175$m4036$, $m4037$Limiares ventilatórios VT1 e VT2 (ergoespirometria) apresentam excelente correlação com LT1 e LT2$m4037$, $m4038$limiares-e-lactato$m4038$,
  $m4039$contexto$m4039$, $m4040$conceito$m4040$,
  ARRAY[$m4041$mensal$m4041$]::text[], '{}'::text[],
  0.5, $m4042$ativo$m4042$, $m4043$Além dos limiares de lactato sanguíneo, testes ergoespirométricos (análise de gases) identificam dois limiares ventilatórios com forte correlação aos limiares metabólicos: VT1 (aumento da ventilação sem aumento proporcional da produção de CO2 — correlato do LT1) e VT2 (hiperventilação significativa em resposta à acidose metabólica crescente — correlato do LT2).

Aplicação ao feedback: nota de referência conceitual — método laboratorial (ergoespirometria) não disponível via Strava; relevante apenas como pano de fundo caso o usuário informe resultados de teste ergoespirométrico externo.$m4043$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4044$nota-0023$m4044$, $m4045$Adaptações fisiológicas e de performance esperadas por nível de treino (Tabela 3.2)$m4045$, $m4046$metodologia-e-periodizacao$m4046$,
  $m4047$direta$m4047$, $m4048$referencia$m4048$,
  ARRAY[$m4049$semanal$m4049$, $m4050$mensal$m4050$]::text[], ARRAY[$m4051$potência-média$m4051$, $m4052$tempo-em-zona$m4052$]::text[],
  0.9, $m4053$ativo$m4053$, $m4054$Tabela 3.2 do livro relaciona cada nível de treino (1–7, definidos na nota-0022) com a magnitude esperada de cada adaptação fisiológica (escala qualitativa de + a ++++, quanto mais sinais, maior a adaptação para uma dada "dose" de treino):

- **Aumento do volume plasmático**: pico em Nível 4 (++++), forte em Nível 3 e 5 (++/+++)
- **Aumento de enzimas mitocondriais musculares**: pico em Nível 4 (++++)
- **Aumento do limiar de lactato**: pico em Nível 4 (++++)
- **Aumento do estoque de glicogênio muscular**: pico em Nível 3 (++++)
- **Hipertrofia de fibras de contração lenta**: pico em Nível 5 (+++)
- **Aumento da capilarização muscular**: pico em Nível 5 (+++)
- **Interconversão de fibras rápidas (Tipo IIx → Tipo IIa)**: pico em Nível 3 (+++)
- **Aumento do volume sistólico/débito cardíaco máximo**: pico em Nível 5 (++++)
- **Aumento do VO2máx**: pico em Nível 5 (++++)
- **Aumento de estoques de fosfato de alta energia muscular (ATP/PCr)**: só em Níveis 6–7, pico no 7 (++)
- **Aumento da capacidade anaeróbia ("tolerância a lactato")**: pico em Nível 6 (+++)
- **Hipertrofia de fibras rápidas**: só em Níveis 6–7, pico no 7 (++)
- **Aumento da potência neuromuscular**: só em Níveis 6–7, pico no 7 (+++)

Padrão geral: Níveis 2–5 dominam as adaptações aeróbias/metabólicas (plasma, mitocôndria, limiar, glicogênio, VO2máx), com pico de intensidade de adaptação por volta do Nível 4 (limiar) e 5 (VO2máx); Níveis 6–7 dominam adaptações anaeróbias/neuromusculares (fosfatos de alta energia, fibras rápidas, potência neuromuscular).

Aplicação ao feedback: ao identificar uma lacuna de fitness do atleta (ex.: baixo VO2máx, baixa capacidade anaeróbia), esta tabela justifica em qual nível/zona concentrar o treino prescrito para gerar a adaptação-alvo específica.$m4054$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;