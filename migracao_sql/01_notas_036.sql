BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4521$nota-0106$m4521$, $m4522$Assinatura de distribuição de tempo em zona por fase da temporada (base → construção → pico/corridas)$m4522$, $m4523$metodologia-e-periodizacao$m4523$,
  $m4524$direta$m4524$, $m4525$regra-interpretacao$m4525$,
  ARRAY[$m4526$mensal$m4526$]::text[], ARRAY[$m4527$tempo-em-zona$m4527$]::text[],
  0.75, $m4528$ativo$m4528$, $m4529$Padrão típico de evolução da distribuição de tempo-em-zona ao longo de uma temporada de treino (exemplo de caso real do livro):

- **Base (inverno/entressafra):** predomínio de Níveis 1-3 (Recuperação Ativa, Endurance, Tempo) — construção de base aeróbia.
- **Construção (primavera):** aumento de tempo em Nível 3 (Tempo), Nível 5 (VO2max) e Nível 6 (Capacidade Anaeróbia) à medida que a temporada de corridas se aproxima.
- **Pré-competição intensa (ex.: junho no caso do livro):** forte aumento de Nível 6 (Capacidade Anaeróbia, relacionado a critériuns/corridas curtas) **e simultaneamente** de Nível 1 (Recuperação Ativa) — os dois sobem juntos porque mais intensidade exige mais recuperação entre esforços.
- **Temporada de corridas (julho):** predomínio de tempo perto da FTP (Nível 4), com queda acentuada logo acima desse nível — mesmo um aumento de poucos pontos percentuais em Nível 4 pode representar carga crônica de treino significativa (ver ressalva do Cap.6 sobre "tempo em zona").

Aplicação ao feedback: comparar a distribuição real de tempo-em-zona do atleta num período contra esta assinatura esperada para a fase da temporada em que ele diz estar (base/construção/pico) pode servir como verificação de consistência — um atleta "em fase de base" com tempo desproporcional em Níveis 5-6, ou um atleta "em pico de temporada" ainda predominantemente em Nível 2, são desvios dignos de nota no feedback.$m4529$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4530$nota-0115$m4530$, $m4531$Multiesporte: construir 3 Performance Manager Charts separados (bike, corrida, combinado) para entender contribuição de carga por esporte$m4531$, $m4532$metodologia-e-periodizacao$m4532$,
  $m4533$direta$m4533$, $m4534$protocolo$m4534$,
  ARRAY[$m4535$mensal$m4535$]::text[], ARRAY[$m4536$TSS$m4536$]::text[],
  0.7, $m4537$ativo$m4537$, $m4538$Para atletas multiesportivos (ex.: triatletas), os autores recomendam construir **três** Performance Manager Charts (CTL/ATL/TSB) separados: um apenas com dados de ciclismo, um apenas com dados de corrida (usando rTSS, nota-0114), e um combinando os dois esportes. Comparar os três permite identificar: (a) quais treinos/esportes geram os melhores resultados de pico de forma; (b) em que esporte o atleta atinge maior carga de treino aguda; (c) em que fase do ano a carga de treino é maior; (d) qual esporte contribui mais, percentualmente, para a carga total de treino do atleta.

Aplicação ao feedback: para atletas com dados de múltiplos esportes no Strava, calcular CTL/ATL/TSB separadamente por esporte além do combinado. Isso evita que a carga de um esporte "mascare" a análise de fadiga/forma do outro — por exemplo, um TSB combinado neutro pode esconder um TSB de corrida muito negativo compensado por TSB de bike positivo.$m4538$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4539$nota-0129$m4539$, $m4540$Receita genérica de 4 passos para usar o medidor de potência em qualquer modalidade de ciclismo$m4540$, $m4541$metodologia-e-periodizacao$m4541$,
  $m4542$direta$m4542$, $m4543$protocolo$m4543$,
  ARRAY[$m4544$mensal$m4544$]::text[], ARRAY[$m4545$potência-média$m4545$]::text[],
  0.75, $m4546$ativo$m4546$, $m4547$Fórmula geral, aplicável a qualquer modalidade de ciclismo (estrada, ciclocross, pista, MTB ultraresistência), para usar o medidor de potência de forma eficaz:

1. **Determinar as demandas do evento** — registrar dados de potência do próprio evento/prova-alvo para entender exatamente o esforço necessário para completá-lo com sucesso.
2. **Entender pontos fortes e fracos** em relação a essas demandas específicas.
3. **Treinar tanto as demandas do evento quanto os pontos fracos** (desde que esses pontos fracos possam de fato impactar o desempenho no evento).
4. **Revisar os resultados** dos treinos e compará-los com os dados coletados em provas reais.

Aplicação ao feedback: este é o framework mínimo que qualquer módulo de análise por modalidade do produto deveria seguir — antes de recomendar treinos, primeiro caracterizar as demandas reais da prova-alvo do atleta (via histórico de provas anteriores, se disponível) em vez de aplicar recomendações genéricas de ciclismo de estrada a modalidades com demandas muito diferentes (ciclocross, pista, MTB ultraresistência).$m4547$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4548$nota-0143$m4548$, $m4549$Síntese do Epílogo: os 8 passos do livro e a cadência de reteste de FTP a cada 6-8 semanas$m4549$, $m4550$metodologia-e-periodizacao$m4550$,
  $m4551$contexto$m4551$, $m4552$conceito$m4552$,
  ARRAY[$m4553$mensal$m4553$]::text[], ARRAY[$m4554$FTP$m4554$]::text[],
  0.7, $m4555$ativo$m4555$, $m4556$O Epílogo (p. 400-402) resume o livro em 8 passos, todos já cobertos em detalhe pelas notas dos capítulos anteriores (determinar FTP → definir zonas de treino → identificar pontos fortes/fracos via Power Profile/PDC → criar treinos → interpretar dados → usar ferramentas avançadas de análise → correr com o medidor de potência → fazer ajustes). Não introduz conceitos técnicos novos, mas reafirma explicitamente a recomendação de **retestar a FTP a cada 6-8 semanas, ou sempre que a forma física parecer ter mudado** — consistente com a cadência já registrada na nota-0021.

Aplicação ao feedback: reforça, como referência de fechamento do cânone deste livro, a regra de que o produto deveria sugerir reteste de FTP num intervalo de 6-8 semanas (ou com base em sinais de mudança de forma, como os identificados nas notas de TTE/PMC), e não confiar indefinidamente num valor de FTP antigo.$m4556$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;