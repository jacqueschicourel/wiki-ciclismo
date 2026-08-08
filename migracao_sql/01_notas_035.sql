BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4355$nota-0095$m4355$, $m4356$Protocolo Plano A/B/C: como ajustar a semana de treino conforme o dia da prova (sábado, domingo ou sem prova)$m4356$, $m4357$metodologia-e-periodizacao$m4357$,
  $m4358$direta$m4358$, $m4359$protocolo$m4359$,
  ARRAY[$m4360$semanal$m4360$]::text[], ARRAY[$m4361$tempo-em-zona$m4361$]::text[],
  0.85, $m4362$ativo$m4362$, $m4363$Os autores descrevem um protocolo de 3 variantes ("Plan A", "Plan B", "Plan C") para ajustar a estrutura da última parte da semana de treino conforme a agenda de provas do atleta:

- **Plan A (prova no sábado):** quinta-feira é dia fácil (folga/recuperação, 2 dias antes da prova); sexta-feira é treino "tune-up" (ativação leve, específico) para preparar as pernas para o esforço da prova.
- **Plan B (prova no domingo):** quinta-feira é ride de Endurance moderado, com alguns tiros curtos para manter as pernas "afiadas"; sexta-feira é Recuperação Ativa; sábado é o dia de "tune-up".
- **Plan C (sem prova no fim de semana, treino normal):** quinta-feira é Endurance com tiros curtos; sexta-feira é Recuperação Ativa; sábado é Tempo sólido com esforços mais curtos; domingo é o "long ride" de Tempo da semana.

Aplicação ao feedback: este é um padrão útil para interpretar (ou recomendar) a estrutura dos últimos 2-3 dias antes de uma prova conhecida no calendário do atleta. Ao gerar feedback semanal, se houver uma prova marcada, o sistema pode comparar a sessão real da quinta/sexta-feira contra o padrão esperado do Plano A/B/C correspondente e sinalizar desvios (ex.: treino pesado demais 2 dias antes de uma prova de sábado).$m4363$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4364$nota-0098$m4364$, $m4365$Flexibilidade no momento da semana de recuperação: adiantar se muito fatigado, adiar se não; mas nunca pular$m4365$, $m4366$metodologia-e-periodizacao$m4366$,
  $m4367$direta$m4367$, $m4368$regra-interpretacao$m4368$,
  ARRAY[$m4369$semanal$m4369$, $m4370$mensal$m4370$]::text[], ARRAY[$m4371$TSS$m4371$, $m4372$esforço-relativo (Relative Effort)$m4372$]::text[],
  0.75, $m4373$ativo$m4373$, $m4374$Regra prática dos autores para decidir o momento exato de uma semana de recuperação programada: se o atleta terminar uma semana dura sentindo-se **excessivamente fatigado**, é válido **adiantar** a semana de recuperação. Por outro lado, se o atleta chegar ao ponto programado **sem estar realmente cansado**, é válido **adiar** a semana de recuperação por mais alguns dias/semana — os autores alertam que atletas frequentemente confundem fadiga normal e leve com overtraining e param de se desafiar cedo demais.

Restrição importante: se a semana de recuperação for adiada, ela **deve** ser cumprida na semana seguinte à originalmente programada — não pode simplesmente ser descartada.

Aplicação ao feedback: ao avaliar se um atleta "pulou" ou atrasou demais uma semana de recuperação planejada, este é o critério qualitativo dos autores — não é uma falha automática adiar por fadiga baixa, mas é um problema se a semana de recuperação nunca ocorre. Combinar com sinais objetivos de fadiga (TSB muito negativo por tempo prolongado, nota-0092) para diferenciar "fadiga normal a ser superada" de "sinal real de overreaching".$m4374$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4375$nota-0099$m4375$, $m4376$Evitar 'stacking' de treinos perdidos; critério para decidir se um treino perdido deve ser reposto$m4376$, $m4377$metodologia-e-periodizacao$m4377$,
  $m4378$direta$m4378$, $m4379$regra-interpretacao$m4379$,
  ARRAY[$m4380$semanal$m4380$]::text[], ARRAY[$m4381$TSS$m4381$, $m4382$tempo-em-zona$m4382$]::text[],
  0.8, $m4383$ativo$m4383$, $m4384$"Stacking" (termo cunhado pela treinadora Gale Bernhardt) é o padrão de comportamento em que o atleta, após perder treinos no meio da semana (geralmente por trabalho/vida pessoal), tenta compensar empilhando múltiplos treinos difíceis no mesmo dia ou em dias consecutivos no fim de semana. Os autores classificam isso como uma armadilha perigosa — "receita para desastre" — que aumenta risco de doença ou lesão pela concentração excessiva de carga em poucos dias.

Regra de decisão recomendada quando um treino é perdido:
1. **Regra geral:** simplesmente seguir para o próximo treino do plano (não tentar recuperar o que foi perdido).
2. **Exceção:** se o treino perdido era altamente específico e não vai se repetir por pelo menos 2 semanas, vale a pena tentar repô-lo o quanto antes (mas não empilhado com outro treino difícil no mesmo dia).

Aplicação ao feedback: ao detectar múltiplos treinos de alta intensidade/TSS elevado concentrados em 1-2 dias após um período de baixa atividade na semana, isso é um padrão de risco (stacking) a ser sinalizado — especialmente se for um comportamento recorrente do atleta. Também serve para não penalizar automaticamente a ausência de reposição de um treino perdido: é o comportamento esperado/recomendado, exceto no caso da exceção acima.$m4384$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4385$nota-0100$m4385$, $m4386$Protocolo dos 10 passos para implementar um plano de treino baseado em potência$m4386$, $m4387$metodologia-e-periodizacao$m4387$,
  $m4388$direta$m4388$, $m4389$protocolo$m4389$,
  ARRAY[$m4390$mensal$m4390$]::text[], ARRAY[$m4391$potência-média$m4391$, $m4392$FTP$m4392$, $m4393$TSS$m4393$]::text[],
  0.8, $m4394$ativo$m4394$, $m4395$Síntese dos autores, ao final do capítulo sobre planos de treino, do fluxo de trabalho completo para um atleta implementar treino baseado em potência:

1. Determinar a FTP (teste, ver protocolos já registrados).
2. Usar a FTP para estabelecer as zonas/níveis de treino.
3. Experimentar treinos-modelo e coletar dados no medidor de potência.
4. Entender os dados e o que os gráficos estão mostrando.
5. Usar Power Profile, Curva de Duração de Potência (PDC) e Quadrant Analysis para identificar pontos fortes e fracos.
6. Avaliar as restrições de tempo disponível do atleta.
7. Desenvolver um plano de treino baseado em potência voltado às melhorias necessárias para o objetivo.
8. Revisar os dados de potência regularmente como feedback do treino.
9. Ajustar a FTP e as zonas de treino conforme a forma física evolui.
10. Refinar o plano conforme necessário para obter descanso ou adaptação adicional.

Aplicação ao feedback: este é essencialmente o "loop" macro que o produto de IA deveria espelhar em nível de produto — não é uma regra de interpretação de um treino isolado, mas o ciclo geral (testar → definir zonas → coletar dados → identificar pontos fortes/fracos → planejar → revisar → reajustar). Útil como referência estrutural para o desenho do fluxo de feedback do produto, especialmente os passos 8-10 (revisão contínua e reajuste de FTP/zonas), que mapeiam diretamente para a cadência de recálculo de FTP já coberta em notas anteriores.$m4395$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;