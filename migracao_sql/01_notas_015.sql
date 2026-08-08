BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1983$nota-0252$m1983$, $m1984$Tabela ACSM de risco de lesão por calor (WBGT) para atividades contínuas de endurance, incluindo ciclismo$m1984$, $m1985$contexto-atleta$m1985$,
  $m1986$contexto$m1986$, $m1987$referencia$m1987$,
  ARRAY[$m1988$diario$m1988$]::text[], '{}'::text[],
  0.65, $m1989$ativo$m1989$, $m1990$O American College of Sports Medicine (ACSM) recomenda faixas de risco de lesão por calor especificamente para "atividades contínuas como corrida de endurance e ciclismo", baseadas no índice WBGT (nota-0251):

| Risco | WBGT | Recomendação |
|---|---|---|
| Muito alto | Acima de 28°C (82°F) | Adiar a prova |
| Alto | 23–28°C (73–82°F) | Indivíduos sensíveis ao calor (obesos, baixo condicionamento, não aclimatados, desidratados, histórico prévio de lesão por calor) não devem competir |
| Moderado | 18–23°C (65–73°F) | — |
| Baixo | Abaixo de 18°C (65°F) | — |

Importante: o WBGT não é a temperatura do ar simples — ele pondera fortemente a umidade relativa (peso 0,7) e a carga radiante (peso 0,2), então um dia de 24°C com alta umidade e sol forte pode ter WBGT classificado como "alto risco" mesmo parecendo ameno pela temperatura do ar isolada.

Aplicação ao feedback: o Strava fornece apenas temperatura do ar, não o WBGT completo (falta umidade e radiação solar) — portanto esta tabela não pode ser aplicada com precisão sem dados adicionais de clima. Como aproximação conservadora e explicitamente imprecisa, a `temperatura` do Strava cruzando os mesmos limiares em °C (18°C, 23°C, 28°C) pode disparar um alerta educativo de risco de calor "estimado" (sabendo que o WBGT real tende a ser igual ou maior que a temperatura do ar em dias úmidos/ensolarados, nunca menor) — mas não deve ser apresentado como o WBGT real. Reforça a recomendação de reduzir intensidade/pace-alvo ou adiar treinos-chave em dias com temperatura registrada acima de ~28°C.$m1990$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1991$nota-0253$m1991$, $m1992$Índice de estresse por calor (temperatura + umidade relativa) e faixas de risco de cãibra, exaustão e golpe de calor$m1992$, $m1993$contexto-atleta$m1993$,
  $m1994$contexto$m1994$, $m1995$referencia$m1995$,
  ARRAY[$m1996$diario$m1996$]::text[], '{}'::text[],
  0.6, $m1997$ativo$m1997$, $m1998$Alternativa mais simples ao WBGT (nota-0251) quando não se tem a temperatura de bulbo úmido medida: o "heat-stress index" combina apenas temperatura do ar e umidade relativa (ambas facilmente obtidas de estações meteorológicas) numa tabela que produz uma "sensação térmica" (°F) equivalente. A tabela mostra, por exemplo, que 80°F (26,7°C) a 0% de umidade tem sensação de 64°F, mas a 100% de umidade a mesma temperatura do ar tem sensação de 72°F — e a 90°F (32,2°C) com 50% de umidade a sensação sobe a 96°F.

A partir da sensação térmica resultante, três faixas de risco são definidas:
- **90–105°F (32–41°C) de sensação térmica**: possibilidade de cãibras por calor
- **105–130°F (41–54°C)**: cãibras ou exaustão por calor prováveis, golpe de calor possível
- **Acima de 130°F (54°C)**: golpe de calor é risco definitivo

Aplicação ao feedback: o Strava fornece temperatura do ar mas tipicamente não umidade relativa consistente por atividade, então este índice completo não é calculável automaticamente. Ainda assim, fundamenta por que dias de temperatura moderada (ex. 30-32°C) combinados com umidade alta podem ser tão perigosos quanto dias mais quentes e secos — útil como texto educativo ao lado de qualquer alerta de calor baseado apenas em `temperatura`, e para explicar por que o mesmo valor de temperatura do Strava pode representar riscos muito diferentes dependendo da umidade local (não capturada).$m1998$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1999$nota-0258$m1999$, $m2000$Desempenho de endurance piora progressivamente conforme a temperatura ambiente sobe de 10°C para 25°C, com efeito mais acentuado em atletas mais lentos$m2000$, $m2001$contexto-atleta$m2001$,
  $m2002$direta$m2002$, $m2003$regra-interpretacao$m2003$,
  ARRAY[$m2004$diario$m2004$]::text[], ARRAY[$m2005$temperatura$m2005$, $m2006$tempo-decorrido$m2006$]::text[],
  0.55, $m2007$ativo$m2007$, $m2008$Estudo (Ely et al., 2007, citado no McArdle) com dados de corrida de maratona mostra uma **relação progressiva e não-binária** entre WBGT e desempenho: conforme o WBGT sobe de 10°C para 25°C (50°F a 77°F), o tempo de prova piora de forma gradual e consistente — não existe um "limiar mágico" abaixo do qual não há efeito nenhum.

Achado importante: **o efeito negativo é maior para os atletas mais lentos** (menor performance relativa/fitness) do que para os atletas de elite/mais rápidos, no mesmo nível de calor. Isso é consistente com o princípio geral de que atletas mais bem condicionados toleram maiores níveis de hipertermia e se aclimatizam mais eficientemente (ver nota-0254).

Originalmente um dado de corrida (maratona), mas o princípio — desempenho de endurance degrada progressivamente com o calor, de forma mais acentuada em atletas de menor nível de condicionamento — é transferível ao ciclismo de endurance, já que o mecanismo subjacente (competição entre fluxo sanguíneo muscular e cutâneo, desidratação progressiva, elevação de temperatura central) não é específico da corrida.

Aplicação ao feedback: ao comparar desempenho (potência/pace, `tempo-decorrido`) do mesmo atleta em diferentes atividades, esperar uma degradação gradual (não um corte abrupto) conforme a `temperatura` registrada sobe de ~10°C para ~25°C+ — e não penalizar/alarmar apenas atletas mais lentos/menos condicionados como "underperformando" quando a causa provável é a maior sensibilidade ao calor desse perfil de atleta comparado a atletas de elite nas mesmas condições.$m2008$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;