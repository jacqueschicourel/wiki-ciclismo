BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8614$nota-0191$m8614$, $m8615$Carga externa (trabalho prescrito/mensurável: potência, distância, kJ) vs. carga interna (resposta fisiológica: FC, lactato, RPE) — a adaptação segue uma curva dose-resposta com faixa ótima entre insuficiência e excesso$m8615$, $m8616$metricas-de-potencia$m8616$,
  $m8617$contexto$m8617$, $m8618$conceito$m8618$,
  ARRAY[$m8619$diario$m8619$, $m8620$semanal$m8620$]::text[], '{}'::text[],
  0.55, $m8621$ativo$m8621$, $m8622$Carga de treinamento tem dois componentes: carga externa (trabalho objetivamente mensurável — potência, velocidade, distância, tempo, desnível, kJ) e carga interna (resposta fisiológica do organismo a esse trabalho — FC, lactato, RPE, VFC, hormônios). O treinador prescreve carga externa, mas é a carga interna que efetivamente determina a adaptação — por isso dois atletas na mesma potência podem ter respostas fisiológicas muito diferentes (fadiga acumulada, temperatura, hidratação, glicogênio, sono, estresse). A relação entre dose de treino e resposta adaptativa segue uma "curva dose-resposta": carga insuficiente gera pouca adaptação, carga excessiva aumenta risco de fadiga crônica — existe uma faixa ótima entre os dois extremos.

Aplicação ao feedback: reforça, com vocabulário formal, a lógica que já orienta o cruzamento potência/FC no cânone (nota-0185) e a lógica de CTL/ATL/TSB do Livro 1 (a "faixa ótima de CTL", nota-0088, e a "taxa segura de ramp rate", nota-0090, são operacionalizações práticas dessa curva dose-resposta).$m8622$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8623$nota-0194$m8623$, $m8624$TSS mede carga mecânica (externa) ponderada por intensidade — não mede fadiga, recuperação nem adaptação diretamente$m8624$, $m8625$metricas-de-potencia$m8625$,
  $m8626$direta$m8626$, $m8627$regra-interpretacao$m8627$,
  ARRAY[$m8628$diario$m8628$]::text[], ARRAY[$m8629$TSS$m8629$]::text[],
  0.6, $m8630$ativo$m8630$, $m8631$Ressalva explícita: o TSS (Training Stress Score) quantifica apenas a carga externa (trabalho mecânico ponderado pela intensidade relativa ao FTP) — não é uma medida direta de fadiga, recuperação ou adaptação fisiológica real. Dois atletas podem acumular o mesmo TSS numa semana e ter respostas de fadiga/recuperação completamente diferentes, dependendo de fatores de carga interna (sono, nutrição, estresse, histórico).

Aplicação ao feedback: reforça uma cautela importante para o produto — TSS/CTL/ATL/TSB (já operacionalizados no Livro 1) descrevem a carga mecânica prescrita/realizada, não o estado fisiológico real do atleta. O feedback não deveria afirmar "você está fadigado" apenas com base em TSS acumulado alto; deveria idealmente cruzar com sinais de carga interna disponíveis (FC, esforço-relativo do Strava) antes de emitir alertas de fadiga, consistente com a lógica de decoupling e "potência vs. FC" já registrada nas notas 0158/0185/0191.$m8631$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8632$nota-0212$m8632$, $m8633$'Performance VO2': taxa de consumo de O2 durante a prova real (a uma dada velocidade/potência), distinta do VO2máx — reflete a interação dinâmica entre metabolismo aeróbio e anaeróbio durante a competição$m8633$, $m8634$metricas-de-potencia$m8634$,
  $m8635$contexto$m8635$, $m8636$conceito$m8636$,
  ARRAY[$m8637$diario$m8637$]::text[], '{}'::text[],
  0.5, $m8638$ativo$m8638$, $m8639$"Performance VO2" é um conceito (não uma métrica padronizada com fórmula fixa) que descreve a taxa real de consumo de oxigênio durante uma prova/esforço competitivo — em contraste com o VO2máx (teto absoluto medido em teste). Reflete a interação dinâmica entre metabolismo aeróbio e anaeróbio ao longo da prova, servindo como estimativa prática da produção metabólica de energia real durante o desempenho, não do potencial máximo.

Aplicação ao feedback: não é diretamente mensurável a partir do Strava (exige medição de gases), mas é conceitualmente equivalente ao que a Potência Normalizada/IF já capturam de forma prática no cânone via potência (NP como proxy do "custo metabólico real" de uma sessão, já nota-0059/0061 do Livro 1) — reforça que a métrica prática relevante para o produto é a intensidade real sustentada (potência), não o teto teórico (VO2máx/FTP).$m8639$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8640$nota-0002$m8640$, $m8641$Conversão de trabalho (kJ) do medidor de potência em gasto calórico estimado$m8641$, $m8642$nutricao-e-energia$m8642$,
  $m8643$direta$m8643$, $m8644$referencia$m8644$,
  ARRAY[$m8645$diario$m8645$]::text[], ARRAY[$m8646$trabalho-kJ$m8646$]::text[],
  0.9, $m8647$ativo$m8647$, $m8648$Medidores de potência registram o trabalho mecânico realizado em joules/kilojoules (kJ), que é diferente de gasto calórico (kcal), porque medem apenas o trabalho externo produzido nos pedais, não a energia metabólica total gasta (grande parte da energia vira calor dissipado, não trabalho mecânico).

Fórmula: gasto energético (kcal) ≈ (trabalho em kJ ÷ 4,184) × fator, onde o fator é 4 se a eficiência de conversão do ciclista for ~25% ou 5 se for ~20%. Para ciclistas treinados, a eficiência típica fica na faixa de 20–25%. Na prática, esses fatores se cancelam de forma que **o valor do trabalho em kJ registrado pelo medidor de potência pode ser usado diretamente como uma estimativa razoável do gasto calórico em kcal** (relação aproximadamente 1:1), sem necessidade de calcular a eficiência individual (que só é determinável com precisão em laboratório).

Ressalva de precisão: esta relação 1:1 é a simplificação didática que o próprio livro apresenta no capítulo introdutório (p. 32-33) para evitar o cálculo de eficiência individual. Mais adiante, no capítulo de nutrição em prova (p. 358), o mesmo livro usa um exemplo numérico real com razão de aproximadamente 1:1,1 (2.000 kJ ≈ 2.200 kcal — ver nota-0123). As duas fontes são do mesmo livro; a diferença reflete que 1:1 é uma simplificação de ordem de grandeza, não um fator exato — tratar o gasto calórico estimado a partir de kJ como tendo incerteza de até ~10%, não como um número preciso.

Aplicação: essa estimativa pode orientar o planejamento de reposição calórica pós-treino/prova e, quando o kJ acumulado é conhecido por trecho/segmento da atividade, permite planejar a ingestão de carboidratos ao longo do próprio percurso.

Aplicação ao feedback: ao gerar feedback pós-treino/prova, reportar o gasto calórico estimado (kJ ≈ kcal) junto com a potência/TSS da sessão, especialmente em atividades longas, para apoiar recomendações de reposição nutricional.$m8648$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;