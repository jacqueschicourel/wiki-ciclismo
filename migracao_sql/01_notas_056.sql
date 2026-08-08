BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7665$nota-0110$m7665$, $m7666$Quadrantes III/IV e VI 1,04–1,07 como alvo para conservar glicogênio no bike leg do triathlon$m7666$, $m7667$metricas-de-potencia$m7667$,
  $m7668$direta$m7668$, $m7669$regra-interpretacao$m7669$,
  ARRAY[$m7670$diario$m7670$]::text[], ARRAY[$m7671$potência-série-temporal$m7671$, $m7672$potência-média$m7672$, $m7673$NP$m7673$, $m7674$VI$m7674$]::text[],
  0.75, $m7675$ativo$m7675$, $m7676$Para triatletas, o objetivo de conservar glicogênio muscular para a corrida se traduz em metas quantitativas específicas de pedalada:

- **Quadrant Analysis:** a maior parte da prova (bike leg) deveria ocorrer nos **Quadrantes III (baixa força, cadência lenta) e IV (baixa força, cadência rápida)** — ambos de baixa força. O Quadrante II (alta força, cadência lenta) é o pior para conservação de energia, pois recruta mais fibras de contração rápida (Tipo II), que consomem glicogênio mais rapidamente. Exemplo ruim do livro: 41% do tempo em Quadrante II. Exemplo bom: mais de 70% em Quadrante III, ou 51% Q3 + 36% Q4.
- **Variability Index (VI) alvo:** **1,04 a 1,07** no bike leg é considerado pedalada excelente/suave para triathlon (NP muito próxima da potência média, poucos picos/surtos).

Aplicação ao feedback: ao analisar uma atividade de bike leg de triathlon (ou treino específico de triathlon), calcular a distribuição por quadrante e o VI da sessão; VI acima de ~1,07 ou tempo elevado em Quadrante II são sinais de possível desperdício de glicogênio que pode prejudicar a corrida seguinte — vale sinalizar isso especialmente em treinos "brick" (bike+corrida) ou análises pós-prova.$m7676$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7677$nota-0111$m7677$, $m7678$Fórmula do 'orçamento de TSS' para calcular a Potência Normalizada-alvo de uma prova longa (método Endurance Nation)$m7678$, $m7679$metricas-de-potencia$m7679$,
  $m7680$direta$m7680$, $m7681$protocolo$m7681$,
  ARRAY[$m7682$mensal$m7682$]::text[], ARRAY[$m7683$TSS$m7683$, $m7684$IF$m7684$, $m7685$NP$m7685$, $m7686$FTP$m7686$]::text[],
  0.75, $m7687$ativo$m7687$, $m7688$Método (Endurance Nation / Rich Strauss e Patrick McCrann) para calcular a Potência Normalizada-alvo de pacing numa prova longa (ex.: Ironman) a partir de um "orçamento" de TSS e do tempo-alvo de prova:

1. **TSS por hora** = TSS orçado ÷ horas de prova planejadas.
   Exemplo: 280 TSS ÷ 6h = 46,7 TSS/hora.
2. **Intensity Factor (IF):** TSS/hora = IF² × 100, logo IF = raiz quadrada(TSS_por_hora ÷ 100).
   Exemplo: IF² = 46,7 ÷ 100 = 0,47 → IF = √0,47 ≈ 0,68.
3. **Potência Normalizada média-alvo:** NP_média = IF × FTP.
   Exemplo: 0,68 × 275 W = 187 W.

Referência de orçamento de TSS para prova de distância Ironman: **300 TSS é o teto máximo** (zona de risco de não conseguir correr até o fim); **280 TSS é um orçamento mais realista** para a maioria dos atletas amadores. Atletas de elite conseguem sustentar TSS bem mais altos (ex.: ~390 TSS a IF 0,83) e ainda correr bem, mas isso reflete volume de treino de 30+ horas/semana e vantagens genéticas — não é referência para o atleta amador.

Aplicação ao feedback: dado o FTP do atleta e a duração-alvo de uma prova longa, o sistema pode sugerir uma NP-alvo de pacing usando esta cadeia de fórmulas (TSS orçado → IF → NP-alvo), e depois comparar a execução real da prova (NP real, IF real, TSS real) contra esse orçamento para avaliar se o atleta pacing corretamente.$m7688$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7689$nota-0113$m7689$, $m7690$Assimetria subida/descida: potência acima da FTP em subida não é necessariamente erro de pacing; recuperação ocorre naturalmente na descida$m7690$, $m7691$metricas-de-potencia$m7691$,
  $m7692$direta$m7692$, $m7693$regra-interpretacao$m7693$,
  ARRAY[$m7694$diario$m7694$]::text[], ARRAY[$m7695$potência-série-temporal$m7695$, $m7696$FTP$m7696$]::text[],
  0.7, $m7697$ativo$m7697$, $m7698$Princípio físico: em subidas, o atleta consegue sustentar potências mais altas (na FTP ou até ~106% dela em subidas curtas) porque há mais resistência para empurrar contra; em descidas, mesmo pedalando ao máximo esforço, a marcha disponível na bicicleta não permite gerar a mesma força — a potência cai naturalmente para algo como 55% da FTP (faixa de Nível 1/Recuperação Ativa), funcionando como recuperação embutida no percurso.

Aplicação ao feedback: ao analisar um percurso com muitos desníveis (comum em ciclismo de estrada ou bike leg de triathlon hilly), picos de potência acima da FTP em trechos de subida **não devem ser automaticamente sinalizados como erro de pacing** — isso é esperado e compensado pela recuperação natural nas descidas subsequentes. O foco da análise de pacing deveria estar no IF/NP médio da prova inteira e no Variability Index, não em picos isolados correlacionados com o perfil de elevação do percurso.$m7698$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7699$nota-0114$m7699$, $m7700$rTSS e FTp (Functional Threshold Pace): TSS aplicado à corrida, com equivalência de carga bike-run (~45min corrida FTp ≈ 60min bike FTP)$m7700$, $m7701$metricas-de-potencia$m7701$,
  $m7702$direta$m7702$, $m7703$conceito$m7703$,
  ARRAY[$m7704$diario$m7704$, $m7705$semanal$m7705$]::text[], ARRAY[$m7706$TSS$m7706$, $m7707$tempo-movimento$m7707$]::text[],
  0.75, $m7708$ativo$m7708$, $m7709$**rTSS (Running Training Stress Score):** adaptação do TSS (Andrew Coggan) para a corrida, desenvolvida por Stephen McGregor. Usa **FTp (Functional Threshold Pace, "p" minúsculo)** — o ritmo de limiar funcional na corrida — como base, análogo à FTP no ciclismo.

**Diferença-chave em relação ao TSS de bike:** por causa do estresse musculoesquelético adicional do impacto do pé no chão (carga estrutural/gravitacional ausente no ciclismo), **1 hora correndo no FTp gera mais estresse de treino do que 1 hora pedalando na FTP** — e por isso exige mais tempo de recuperação. Para manter os 100 pontos = mesma carga de treino entre os dois esportes, a escala de tempo do rTSS não é de 1h como no TSS de bike: **aproximadamente 45 minutos correndo no FTp (ou um esforço máximo de ~15 km) equivalem a 100 pontos de rTSS**, o mesmo que 1 hora de bike na FTP gera 100 TSS.

Aplicação ao feedback: essencial para qualquer produto que combine dados de bike e corrida do Strava (a maioria dos usuários multiesportivos) — ao somar carga de treino entre os dois esportes (para CTL/ATL/TSB combinado), usar rTSS para as corridas em vez de aplicar a fórmula de TSS de bike diretamente ao tempo de corrida, já que a escala temporal de referência é diferente (45min ≠ 60min para 100 pontos).$m7709$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;