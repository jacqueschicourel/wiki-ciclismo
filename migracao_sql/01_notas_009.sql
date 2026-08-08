BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1208$nota-0272$m1208$, $m1209$VO2max cai 7-9% a cada 1000m de altitude acima de ~590m (não-linear acima de 6300m); mesmo aclimatizado, permanece ~2% menor a cada 300m acima de 1500m$m1209$, $m1210$avaliacao-e-testes$m1210$,
  $m1211$contexto$m1211$, $m1212$referencia$m1212$,
  ARRAY[$m1213$mensal$m1213$]::text[], '{}'::text[],
  0.65, $m1214$ativo$m1214$, $m1215$Fórmula/curva quantitativa de queda de VO2max por altitude (McArdle, baseada em regressão de 146 pontos de dados de 67 estudos civis e militares — Figura 24.9A), que preenche a lacuna deixada pela nota-0134 (que descrevia apenas o princípio conceitual sem fórmula):

- Quedas mensuráveis de VO2max começam a ~589 m (1932 ft) de altitude.
- Daí em diante, a dessaturação arterial reduz o VO2max em **7 a 9% a cada 1000 m** de altitude adicional, até ~6300 m.
- Acima de 6300 m, a queda se torna **não-linear** (mais acentuada por metro adicional).
- Exemplos de referência: a 4000 m, VO2max médio ≈ 75% do valor ao nível do mar; a 7000 m, ≈ 50% do valor ao nível do mar.
- **Mesmo com aclimatização completa**, o VO2max não retorna ao valor de nível do mar: permanece **~2% menor a cada 300 m acima de 1500 m** de altitude residente — a aclimatização reduz o impacto agudo, mas não o elimina, porque a queda no débito cardíaco máximo (FC máxima e volume sistólico reduzidos) compensa apenas parcialmente o ganho hematológico.

Aplicação ao feedback: se o produto tiver acesso à altitude/elevação do local de uma atividade (dado de localização já presente no Strava, como mencionado na nota-0134), esta fórmula permite estimar quanto do VO2max/potência esperada de um atleta deve ser descontado para atividades feitas significativamente acima de ~600m, evitando interpretar uma queda de potência/NP em uma saída de montanha como perda de fitness. Mantido como `aplicacao: contexto` porque a fórmula é uma média de população heterogênea (estudos civis/militares, não ciclistas especificamente) e o Strava não fornece altitude de forma padronizada e limpa por atividade.$m1215$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1216$nota-0273$m1216$, $m1217$Tempo de aclimatização à altitude: ~2 semanas até 2300m, +1 semana adicional a cada 610m de ganho, até 4600m; benefícios se dissipam em 2-3 semanas ao retornar$m1217$, $m1218$avaliacao-e-testes$m1218$,
  $m1219$contexto$m1219$, $m1220$protocolo$m1220$,
  ARRAY[$m1221$mensal$m1221$]::text[], '{}'::text[],
  0.6, $m1222$ativo$m1222$, $m1223$Cronograma de referência (McArdle) para o tempo necessário de aclimatização à altitude, como diretriz ampla (grande variabilidade individual existe):

- **~2 semanas** para adaptar-se a altitudes de até 2300 m (7545 ft).
- Daí em diante, **cada 610 m (2000 ft) adicionais de altitude exige mais 1 semana** de aclimatização, até 4600 m (15.091 ft).
- Isso significa, por exemplo, que aclimatizar plenamente a ~3700 m (2300m + ~2×610m) levaria aproximadamente 4 semanas.
- Aclimatização a altitudes muito altas (>4600m) requer 4 a 6 semanas segundo o resumo do capítulo.
- **Os benefícios da aclimatização se dissipam em 2 a 3 semanas** após o retorno a uma altitude mais baixa/nível do mar — ou seja, é um investimento perecível, não permanente.
- Atletas que desejam competir em altitude devem iniciar treino intenso imediatamente durante a aclimatização, para minimizar o destreinamento induzido pela tendência natural de reduzir atividade física nos primeiros dias em altitude.

Aplicação ao feedback: útil como conteúdo de planejamento de viagem/camp de treinamento para atletas que vão treinar ou competir em altitude significativa (>2000m) — não é executável a partir de uma única atividade do Strava, mas pode orientar recomendações de cronograma (quantos dias chegar antes de uma prova em altitude) quando o produto tiver informação da localização/altitude do evento-alvo do atleta.$m1223$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1224$nota-0276$m1224$, $m1225$O limiar de altitude que já prejudica desempenho depende da duração do esforço: sem efeito abaixo de 2min, ~1600m para provas de 2-5min, apenas ~600-700m para provas de 20min+$m1225$, $m1226$avaliacao-e-testes$m1226$,
  $m1227$contexto$m1227$, $m1228$referencia$m1228$,
  ARRAY[$m1229$mensal$m1229$]::text[], '{}'::text[],
  0.55, $m1230$ativo$m1230$, $m1231$O impacto da altitude no desempenho depende fortemente da **duração do esforço**, porque eventos curtos dependem de vias energéticas anaeróbias (não afetadas por menor disponibilidade de oxigênio):

- **Esforços < 2 minutos**: nenhum efeito adverso da altitude (energia vem de fosfatos de alta energia e glicólise, sistemas que não dependem de O2 disponível). Esportes de potência/sprint podem até melhorar ligeiramente em altitude moderada por menor densidade do ar (menor resistência aerodinâmica).
- **Esforços de 2 a 5 minutos**: o limiar de altitude onde o desempenho começa a piorar é de **~1600 m**.
- **Esforços acima de 20 minutos** (a maioria dos esforços relevantes em ciclismo de endurance): o limiar cai para apenas **~600-700 m** de altitude — ou seja, mesmo altitudes moderadas (comuns em muitas regiões de treino/prova) já prejudicam mensuravelmente o desempenho de endurance.

Consequência complementar para interpretação de dados de treino em altitude (Tabela 24.3): a **mesma intensidade relativa** (% do VO2max) ao nível do mar corresponde a uma intensidade absoluta muito menor em altitude — por exemplo, um esforço que representa 78% do VO2max ao nível do mar equivale a apenas 39% de intensidade a 4000m para gerar a mesma % relativa de VO2max. Isso significa que **potência/NP mais baixos em atividades feitas em altitude não indicam necessariamente perda de fitness** — podem refletir simplesmente que o mesmo esforço relativo (RPE, %FCmax) produz menos potência absoluta.

Aplicação ao feedback: para provas/segmentos de endurance longos (>20min, o caso típico de subidas longas ou contrarrelógios), mesmo ganhos modestos de elevação (600-700m acima da altitude habitual do atleta) já são suficientes para justificar uma queda de potência/NP esperada — o sistema não deveria exigir grandes altitudes (tipo 2000m+) para começar a descontar o efeito de altitude na interpretação de desempenho, ao contrário do que se poderia supor intuitivamente.$m1231$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;