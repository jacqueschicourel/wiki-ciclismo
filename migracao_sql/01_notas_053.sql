BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7121$nota-0083$m7121$, $m7122$CTL (Chronic Training Load): média móvel exponencial do TSS diário, constante padrão de 42 dias$m7122$, $m7123$metricas-de-potencia$m7123$,
  $m7124$direta$m7124$, $m7125$referencia$m7125$,
  ARRAY[$m7126$semanal$m7126$, $m7127$mensal$m7127$]::text[], ARRAY[$m7128$TSS$m7128$]::text[],
  0.9, $m7129$ativo$m7129$, $m7130$CTL (Chronic Training Load) é uma média móvel exponencialmente ponderada (EWMA) dos valores diários de TSS, com constante de tempo padrão de **42 dias** — na prática, o CTL reflete principalmente o treino feito nos últimos ~3 meses, sendo um proxy de "fitness" acumulada (quanto o atleta vem treinando cronicamente). É a versão simplificada, sem fator de ganho (ka), do termo "adaptação positiva" do modelo de impulso-resposta de Banister.

Nota: o Performance Manager (CTL/ATL/TSB) é uma simplificação matemática deliberada do modelo de impulso-resposta original de Banister — mais fácil de calcular e aplicar fora de laboratório, mas com a ressalva de que CTL/ATL/TSB são indicadores *relativos* de mudança de fitness/fadiga, não preditores absolutos de performance (isso é explicado em mais detalhe nas notas sobre o modelo de Banister).

Aplicação ao feedback: usar o CTL como indicador de tendência de fitness de médio/longo prazo ao gerar feedback semanal/mensal — quedas ou platôs prolongados de CTL (ver nota-0089) e a taxa de subida (ramp rate, nota-0090) são mais informativos que o valor absoluto isolado em um único dia.$m7130$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7131$nota-0084$m7131$, $m7132$ATL (Acute Training Load): média móvel exponencial do TSS diário, constante padrão de 7 dias$m7132$, $m7133$metricas-de-potencia$m7133$,
  $m7134$direta$m7134$, $m7135$referencia$m7135$,
  ARRAY[$m7136$diario$m7136$, $m7137$semanal$m7137$]::text[], ARRAY[$m7138$TSS$m7138$]::text[],
  0.9, $m7139$ativo$m7139$, $m7140$ATL (Acute Training Load) é uma média móvel exponencialmente ponderada (EWMA) dos valores diários de TSS, com constante de tempo padrão de **7 dias** — reflete principalmente o treino feito nas últimas ~2 semanas, funcionando como proxy de fadiga recente/aguda. É a versão simplificada, sem fator de ganho (kf), do termo "efeito negativo/fadiga" do modelo de impulso-resposta de Banister.

A constante de tempo do ATL pode/deve ser ajustada conforme a idade do atleta e a duração do evento-alvo (ver notas específicas sobre esses ajustes) — o valor padrão de 7 dias não é universal.

Aplicação ao feedback: usar o ATL (com a constante de tempo apropriada à idade/evento do atleta) como indicador de fadiga recente ao gerar feedback diário/semanal — um ATL subindo rapidamente em relação ao CTL é sinal de acúmulo de fadiga aguda a monitorar.$m7140$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7141$nota-0085$m7141$, $m7142$TSB (Training Stress Balance) = CTL − ATL: \"forma = fitness + frescor\"$m7142$, $m7143$metricas-de-potencia$m7143$,
  $m7144$direta$m7144$, $m7145$regra-interpretacao$m7145$,
  ARRAY[$m7146$diario$m7146$, $m7147$semanal$m7147$]::text[], ARRAY[$m7148$TSS$m7148$]::text[],
  0.9, $m7149$ativo$m7149$, $m7150$**Fórmula: TSB = CTL − ATL.** TSB (Training Stress Balance) mede o quanto o atleta vem treinando recentemente/agudamente (ATL) em comparação com o quanto vem treinando cronicamente (CTL) — funciona como indicador de "frescor" (freshness): TSB positivo indica mais frescor (o atleta está descansado relativo ao seu próprio histórico recente); TSB negativo indica mais fadiga acumulada.

**Conceito central: Forma = Fitness (CTL) + Frescor (TSB).** Um atleta pode estar muito em forma física (CTL alto) mas exausto (TSB muito negativo) e não conseguir expressar essa fitness numa prova; ou pode estar muito descansado (TSB muito positivo) mas destreinado (CTL baixo) e também não performar bem. A "forma" real depende do equilíbrio certo entre os dois — não existe um TSB "ideal" universal, ele depende do CTL simultâneo e do tipo de evento (ver nota-0091 sobre TSB ideal por tipo de prova — corrigido em 2026-08-02; a referência antiga apontava para nota-0090, sobre ramp rate de CTL, assunto não relacionado).

Ressalva importante: TSB **não deve ser interpretado como preditor absoluto de performance** (diferente do modelo de Banister original) — é melhor entendido como um indicador relativo de o quão adaptado o atleta está à sua carga de treino recente, não como um número que prevê exatamente o resultado.

Aplicação ao feedback: reportar o TSB junto com o CTL ao interpretar a forma atual do atleta — nunca usar TSB isoladamente para prever performance; cruzar com o tipo de evento-alvo (ver nota-0091) e com a tendência recente de CTL antes de recomendar mais carga ou mais descanso.$m7150$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7151$nota-0087$m7151$, $m7152$Ajuste da constante de tempo do ATL pela duração do evento-alvo (eventos curtos → constante maior; longos → menor)$m7152$, $m7153$metricas-de-potencia$m7153$,
  $m7154$direta$m7154$, $m7155$regra-interpretacao$m7155$,
  ARRAY[$m7156$mensal$m7156$]::text[], '{}'::text[],
  0.75, $m7157$ativo$m7157$, $m7158$A potência em durações curtas (perto do Pmax) depende muito mais do "frescor" (freshness) do atleta do que a potência em durações longas (perto do FTP, que depende mais de fitness/CTL). Isso motiva ajustar a constante de tempo do ATL conforme a duração do evento-alvo:

- **Provas curtas, onde potência neuromuscular/capacidade anaeróbia decide o resultado** (pista, BMX, subidas curtas): usar constante de ATL mais longa (10–14 dias em vez do padrão de 7) para garantir que o TSB realmente reflita a dissipação completa da fadiga antes do evento.
- **Provas muito longas** (ex.: maratona de mountain bike): usar constante de ATL mais curta (3–5 dias em vez de 7), o que obriga o atleta a manter treino mais próximo do evento, evitando que o TSB fique positivo demais cedo demais.

Aplicação ao feedback: o "tempo de antecedência" recomendado para começar a reduzir carga (taper) antes de uma prova deve variar conforme o perfil de duração/intensidade do evento-alvo — provas curtas/explosivas pedem tapers mais longos; provas longas/aeróbias pedem tapers mais curtos.$m7158$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;