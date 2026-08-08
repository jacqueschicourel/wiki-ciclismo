BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7801$nota-0116$m7801$, $m7802$Para provas de ultraresistência (ex.: Ironman), o TSB no dia da prova é mais preditivo de desempenho do que picos de potência de curta duração; pico de forma sustentável por 6-8 semanas, mas não recomendado$m7802$, $m7803$metricas-de-potencia$m7803$,
  $m7804$direta$m7804$, $m7805$regra-interpretacao$m7805$,
  ARRAY[$m7806$mensal$m7806$]::text[], ARRAY[$m7807$TSS$m7807$]::text[],
  0.65, $m7808$revisar$m7808$, $m7809$Para eventos de ultraresistência (ex.: Ironman), picos de potência de curta duração (1min, 20min, 120min) **não predizem** o desempenho no dia da prova — o evento é dominado pela resistência/endurance, não pela potência máxima. O indicador mais relevante para prontidão nesse tipo de prova é o **TSB no dia da prova**: TSB muito positivo indica excesso de frescor com perda de fitness; TSB muito negativo indica fadiga excessiva.

Observação adicional (estudo de caso, uma atleta ao longo de 6 temporadas): seus melhores resultados individuais (picos de potência/pace) ocorreram consistentemente **logo após semanas de recuperação** dentro de fases de treino pesado — reforça o padrão de que picos de performance seguem semanas de descarga (nota-0094, nota-0098). Também: é fisicamente possível manter um "pico de forma" (CTL alto/TSB favorável) por 6-8 semanas, mas os autores **não recomendam tentar isso deliberadamente** — preferem visar o pico próximo à prova-alvo, já que segurar o pico por tempo excessivo aumenta o risco de errar o timing.

**Motivo da revisão:** conclusão baseada num único estudo de caso (uma atleta, 6 temporadas de dados observacionais), não um estudo controlado — tratar como heurística qualitativa, não regra numérica validada.

Aplicação ao feedback: para provas de longa duração (>3-4h), priorizar o TSB (trajetória e valor no dia da prova) sobre picos de MMP recentes ao avaliar prontidão do atleta. Não usar "melhor 20min da temporada" como proxy de prontidão para provas de ultraresistência.$m7809$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7810$nota-0119$m7810$, $m7811$Vento de frente amplifica a vantagem de quem tem FTP mais alta; vento de cauda nivela as diferenças entre atletas$m7811$, $m7812$metricas-de-potencia$m7812$,
  $m7813$contexto$m7813$, $m7814$conceito$m7814$,
  ARRAY[$m7815$diario$m7815$]::text[], ARRAY[$m7816$potência-média$m7816$, $m7817$FTP$m7817$, $m7818$velocidade$m7818$]::text[],
  0.6, $m7819$ativo$m7819$, $m7820$Exemplo quantitativo comparando dois ciclistas (FTP 340W vs. 320W) num contrarrelógio de 40 km dividido em metade com vento de cauda e metade com vento de frente:

- **Trecho com vento de cauda (20 km):** a diferença de potência sustentável entre os dois se reduz (320W vs. 300W efetivos), e a diferença de velocidade também (32,5 mph vs. 32,1 mph) — resultando em apenas **17 segundos** de vantagem para o atleta de FTP mais alta nesse trecho.
- **Trecho com vento de frente (20 km):** a mesma diferença de FTP se traduz em vantagem de velocidade muito maior (22 mph vs. 20,5 mph) — resultando em **194 segundos** de vantagem para o atleta de FTP mais alta nesse trecho.

Conclusão dos autores: o vento de cauda tende a nivelar as diferenças de aptidão entre atletas, enquanto o vento de frente as amplifica — "a prova pode ser vencida no trecho contra o vento."

Aplicação ao feedback: ao interpretar o desempenho de um atleta num contrarrelógio ou segmento com vento variável, não esperar que a mesma diferença relativa de potência produza a mesma diferença relativa de tempo/velocidade em todos os trechos — trechos contra o vento amplificam o efeito de diferenças de FTP/potência muito mais que trechos a favor do vento. Nota de contexto: exemplo numérico único do livro, não uma fórmula física derivável sem dados adicionais (área frontal, CdA, densidade do ar).$m7820$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7821$nota-0122$m7821$, $m7822$Comparar Quadrant Analysis de um treino contra a prova-alvo para verificar se o treino é neuromuscularmente específico$m7822$, $m7823$metricas-de-potencia$m7823$,
  $m7824$direta$m7824$, $m7825$regra-interpretacao$m7825$,
  ARRAY[$m7826$semanal$m7826$, $m7827$mensal$m7827$]::text[], ARRAY[$m7828$potência-série-temporal$m7828$, $m7829$cadência$m7829$]::text[],
  0.75, $m7830$ativo$m7830$, $m7831$Método geral para verificar se o treino de um atleta é especificamente adequado às demandas neuromusculares da sua prova-alvo: comparar a distribuição por Quadrante (Quadrant Analysis) de um arquivo de **treino típico** contra a distribuição de um arquivo de **prova/corrida real** de duração semelhante.

Exemplo do livro (mountain bike): um treino de "subthreshold" ficou concentrado nos Quadrantes III e IV (baixa força), estressando bem o sistema metabólico mas pouco as fibras de contração rápida (Tipo II). A prova real do mesmo atleta mostrou distribuição muito mais dispersa ("shotgun blast"), com presença significativa em Quadrante II (alta força/baixa cadência) — evidenciando uma lacuna: o treino não estava replicando a demanda neuromuscular real da prova.

Aplicação ao feedback: quando o atleta tiver histórico de provas anteriores do mesmo tipo/percurso, comparar periodicamente a distribuição por quadrante dos treinos recentes contra a distribuição típica das provas-alvo. Uma discrepância sistemática (ex.: treino sempre em Q3/Q4, prova historicamente com bastante Q2) é uma lacuna de especificidade a ser sinalizada como recomendação de treino (ex.: sugerir mais trabalho em alta força/baixa cadência).$m7831$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;