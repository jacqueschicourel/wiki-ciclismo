BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2792$nota-0157$m2792$, $m2793$Débito cardíaco = FC × Volume sistólico; valores de referência (repouso vs. atleta treinado vs. esforço máximo)$m2793$, $m2794$fisiologia$m2794$,
  $m2795$contexto$m2795$, $m2796$referencia$m2796$,
  ARRAY[$m2797$mensal$m2797$]::text[], '{}'::text[],
  0.55, $m2798$ativo$m2798$, $m2799$Débito cardíaco (litros de sangue bombeados por minuto) = Frequência Cardíaca × Volume Sistólico. Valores de referência citados pelo Manual: FC de repouso — 60-80 bpm em não treinados, <40 bpm comum em ciclistas altamente treinados; Volume sistólico — 60-90 mL/batimento em sedentários, >150 mL/batimento em atletas treinados; débito cardíaco em esforço máximo de elite próximo de 40 L/min (citação direta da fonte). A FC de repouso mais baixa em atletas não reflete um coração "mais lento", mas mais eficiente (maior volume ejetado por batimento).

**Ressalva de proveniência (2026-08-02, achado de auditoria adversarial):** os valores "~5 L/min" (repouso) e "35 L/min" (esforço máximo de treinados não-elite) que apareciam no parágrafo original **não são citação direta da fonte** — nenhum dos 3 trechos-fonte do frontmatter contém esses números. O "~5 L/min" é uma inferência razoável a partir de FC×VS de repouso usando os próprios valores citados da fonte (ex.: 70 bpm × 70 mL ≈ 4,9 L/min, consistente com a fisiologia descrita), mas é cálculo derivado, não citação. O "35 L/min" para treinados-não-elite não tem nenhum lastro, direto ou inferido, na fonte — foi removido do corpo da nota. Único valor de esforço máximo mantido é "próximos de 40 litros por minuto" para ciclistas de elite, que é citação literal da fonte.

Aplicação ao feedback: valores de referência de contexto fisiológico — úteis apenas se o produto algum dia incorporar FC de repouso como sinal de tendência de forma física (FC de repouso em queda ao longo de meses pode indicar melhora de condicionamento cardiovascular; FC de repouso elevada pode ser sinal de fadiga não recuperada, conforme literatura de HRV/monitoramento — mas nenhuma nota do cânone até aqui define regra operacional específica para isso a partir de dados do Strava).$m2799$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2800$nota-0159$m2800$, $m2801$Ventilação (VE) = Volume Corrente × Frequência Respiratória; de ~8 L/min em repouso a >180-220 L/min em esforço máximo$m2801$, $m2802$fisiologia$m2802$,
  $m2803$contexto$m2803$, $m2804$referencia$m2804$,
  ARRAY[$m2805$diario$m2805$]::text[], '{}'::text[],
  0.55, $m2806$ativo$m2806$, $m2807$Ventilação minuto (VE) = Volume Corrente (VT) × Frequência Respiratória (FR). Em repouso, ~8 L/min; em esforço máximo, tipicamente >180 L/min, podendo superar 220 L/min em ciclistas profissionais. Em intensidades baixas/moderadas, o aumento da ventilação ocorre principalmente por aumento do volume corrente; perto do máximo, o volume corrente satura e novos aumentos dependem da frequência respiratória (respiração mais curta e ofegante).

Aplicação ao feedback: nota de referência fisiológica de fundo — o Strava não fornece dados de ventilação, então não gera regra de interpretação direta; útil apenas como contexto explicativo caso o produto precise justificar por que a "respiração ofegante"/RPE sobe desproporcionalmente perto de esforços máximos.$m2807$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2808$nota-0161$m2808$, $m2809$VO2 absoluto (L/min) vs. VO2 relativo (mL·kg⁻¹·min⁻¹) — o relativo facilita comparação entre atletas de massas diferentes$m2809$, $m2810$fisiologia$m2810$,
  $m2811$contexto$m2811$, $m2812$conceito$m2812$,
  ARRAY[$m2813$mensal$m2813$]::text[], '{}'::text[],
  0.5, $m2814$ativo$m2814$, $m2815$VO2 (consumo de oxigênio) pode ser expresso em valor absoluto (L/min, ex.: 5,2 L/min) ou valor relativo à massa corporal (mL·kg⁻¹·min⁻¹, ex.: 72 mL·kg⁻¹·min⁻¹). O valor relativo é mais usado para comparar atletas de massas diferentes (relevante em subidas), enquanto o valor absoluto pode ser mais informativo para potência absoluta em contrarrelógio/pista.

Aplicação ao feedback: definição de referência — o Strava não fornece VO2max diretamente (alguns wearables estimam e podem sincronizar, mas isso está fora do escopo confirmado do cânone atual); nota de contexto para caso o produto venha a receber esse dado de fontes externas integradas ao perfil do atleta.$m2815$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m2816$nota-0162$m2816$, $m2817$Equação de Fick: VO2 = Débito Cardíaco × Diferença Arteriovenosa de O2 — componente central (transporte) vs. periférico (extração muscular)$m2817$, $m2818$fisiologia$m2818$,
  $m2819$contexto$m2819$, $m2820$conceito$m2820$,
  ARRAY[$m2821$mensal$m2821$]::text[], '{}'::text[],
  0.6, $m2822$ativo$m2822$, $m2823$A Equação de Fick decompõe o VO2máx em dois componentes multiplicativos: (1) componente central — capacidade de transportar oxigênio até o músculo, determinada por débito cardíaco, volume sistólico e concentração de hemoglobina; (2) componente periférico — capacidade do próprio músculo de extrair e utilizar o oxigênio disponível, determinada por capilarização, densidade mitocondrial, atividade enzimática oxidativa e conteúdo de mioglobina. Essa divisão explica por que diferentes métodos de treinamento produzem adaptações distintas: treinos intervalados de alta intensidade tendem a estimular mais o componente central (débito cardíaco), enquanto volume aeróbio consistente favorece adaptações periféricas (mitocôndrias, capilares, enzimas).

Aplicação ao feedback: fundamenta, em nível mecanístico, por que a prescrição de treino para "aumentar VO2max" geralmente combina intervalados de alta intensidade (estímulo central) com volume de base (estímulo periférico) — não gera regra de interpretação direta de dado do Strava, mas serve de justificativa de fundo para recomendações de tipo de treino.$m2823$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;