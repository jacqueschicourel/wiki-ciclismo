BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1452$nota-0003$m1452$, $m1453$Ganho de ~30 W por otimização de posição e aerodinâmica$m1453$, $m1454$contexto-atleta$m1454$,
  $m1455$contexto$m1455$, $m1456$referencia$m1456$,
  ARRAY[$m1457$mensal$m1457$]::text[], '{}'::text[],
  0.7, $m1458$ativo$m1458$, $m1459$Segundo testes em túnel de vento citados pelos autores, otimizar posição no equipamento e aerodinâmica pode permitir manter a mesma velocidade com cerca de 30 W a menos de potência — equivalente, em termos de velocidade, a um ganho de aproximadamente 30 W de potência. Os autores destacam que esse ganho costuma ser maior do que o progresso fisiológico que a maioria dos ciclistas obtém em um ano inteiro de treinamento.

Nota de aplicação: este é um dado de contexto sobre a importância relativa de posição/aerodinâmica frente ao treino fisiológico — não é, por si só, uma métrica derivada dos sinais de potência de uma sessão do Strava, por isso não tem `sinais` associados. Útil para calibrar expectativas do atleta sobre de onde vêm os ganhos de velocidade (equipamento/posição vs. fisiologia).$m1459$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1460$nota-0005$m1460$, $m1461$Os quatro benefícios do treino com medidor de potência (autoavaliação, colaboração, foco, performance de pico)$m1461$, $m1462$contexto-atleta$m1462$,
  $m1463$contexto$m1463$, $m1464$conceito$m1464$,
  ARRAY[$m1465$mensal$m1465$]::text[], '{}'::text[],
  0.8, $m1466$ativo$m1466$, $m1467$Os autores organizam os benefícios do treino com medidor de potência em quatro áreas que se sobrepõem e se reforçam mutuamente: (1) Autoavaliação — identificar pontos fortes e fracos a partir dos dados objetivos da pedalada; (2) Colaboração — compartilhar dados com técnico/equipe para trabalho mais eficiente; (3) Foco no treino — usar os dados para definir metas e métodos de treino mais apropriados; (4) Performance de pico — a combinação das três áreas anteriores posiciona o atleta para render o melhor possível nas provas.

Esse framework de quatro pilares funciona como fio condutor do restante do livro e serve de contexto geral para justificar por que a interpretação orientada por dados (e não apenas por sensação) é o eixo central da metodologia dos autores.$m1467$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1468$nota-0035$m1468$, $m1469$Fenótipos de ciclista pelo formato do Power Profile (all-rounder, sprinter, contrarrelogista/escalador, perseguidor)$m1469$, $m1470$contexto-atleta$m1470$,
  $m1471$direta$m1471$, $m1472$regra-interpretacao$m1472$,
  ARRAY[$m1473$mensal$m1473$]::text[], ARRAY[$m1474$potência-máx$m1474$, $m1475$relação-P/peso$m1475$]::text[],
  0.8, $m1476$ativo$m1476$, $m1477$Ao classificar as 4 durações-índice (5s, 1min, 5min, FTP) na Tabela 4.1 e observar o formato resultante (plano, descendente, ascendente, "V invertido"), emergem padrões típicos de fenótipo:

- **All-rounder**: perfil praticamente horizontal — as 4 durações caem no mesmo nível de categoria. Não se destaca em nada específico, mas é competitivo numa ampla gama de provas. É o perfil mais comum em ciclistas iniciantes/não especializados (forças específicas ainda não desenvolvidas pelo treino).
- **Sprinter**: perfil claramente descendente, sobretudo entre 1 min e 5 min (5s e 1min bem mais fortes, relativamente, que 5min e FTP).
- **Contrarrelogista / escalador / rider de estado estável**: perfil claramente ascendente, sobretudo entre 1 min e 5 min (e também entre 5 min e FTP) — fraco em potência neuromuscular e capacidade anaeróbia, mas com potência aeróbia e limiar de lactato relativamente altos.
- **Perseguidor (pursuiter)**: formato de "V invertido" nítido — indica capacidade anaeróbia E capacidade aeróbia altas ao mesmo tempo. É uma combinação relativamente incomum (dado que se espera relação inversa entre potência neuromuscular e limiar de lactato, e relação positiva entre VO2máx e limiar de lactato); um perfil "quase all-rounder" que ainda não desenvolveu o limiar de lactato ao máximo também pode gerar esse mesmo formato — vale checar se os valores realmente refletem o melhor esforço do atleta antes de concluir que é um "V invertido" real.

Aplicação ao feedback: o formato do perfil orienta tanto a interpretação de pontos fortes/fracos quanto sugestões de prova/especialização — mas o texto ressalta que essas comparações são sempre relativas ao desempenho de elite mundial em cada duração, então ciclistas de estrada tendem a parecer "fracos" em sprint de 5s comparados a sprinters de pista puros, e vice-versa.$m1477$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1478$nota-0036$m1478$, $m1479$Limitações do Power Profile: sem correção por idade; declínio anual estimado de VO2máx e força/potência$m1479$, $m1480$contexto-atleta$m1480$,
  $m1481$contexto$m1481$, $m1482$referencia$m1482$,
  ARRAY[$m1483$mensal$m1483$]::text[], '{}'::text[],
  0.75, $m1484$ativo$m1484$, $m1485$Os padrões do Power Profile (Tabela 4.1, nota-0031) foram construídos com base na capacidade de desempenho de adultos jovens, sem correção por idade — os autores consideraram criar um chart específico para masters, mas rejeitaram a ideia pela dificuldade de coletar dados suficientes e aplicar correções fisiológicas corretamente; a tabela deve ser aplicada igual, independente da idade do ciclista.

Dados de referência sobre envelhecimento citados pelos autores: a partir de ~30 anos, o VO2máx declina, em média, ~0,5 mL/kg/min por ano em homens e ~0,35 mL/kg/min por ano em mulheres. Já força e potência muscular tendem a se manter (com treino) até por volta dos 50 anos, quando passam a declinar mais rapidamente. Os autores julgam que essas mudanças diferenciais por idade não são suficientes para alterar significativamente o formato do perfil de um atleta, mas reconhecem que, para máxima precisão, fatores de correção por idade poderiam ser aplicados de forma diferente em cada coluna (duração) da tabela.

Aplicação ao feedback: ao comparar o Power Profile de atletas mais velhos com a Tabela 4.1, ter em mente que ela não tem correção etária — um resultado "mais fraco" nas colunas de maior duração (mais dependentes de VO2máx) pode refletir em parte o envelhecimento normal, não necessariamente falta de treino.$m1485$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;