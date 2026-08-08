BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9468$nota-0063$m9468$, $m9469$Escala de impacto do TSS na fadiga/recuperação (Tabela 7.3)$m9469$, $m9470$recuperacao-e-fadiga$m9470$,
  $m9471$direta$m9471$, $m9472$referencia$m9472$,
  ARRAY[$m9473$diario$m9473$, $m9474$semanal$m9474$]::text[], ARRAY[$m9475$TSS$m9475$]::text[],
  0.9, $m9476$ativo$m9476$, $m9477$Tabela 7.3 do livro — escala aproximada de impacto do TSS de uma única sessão sobre a fadiga e o tempo de recuperação esperado:

| TSS da sessão | Intensidade do estresse | Status de recuperação esperado |
|---|---|---|
| <150 | Baixa | Recuperação geralmente completa até o dia seguinte |
| 150–300 | Moderada | Pode haver fadiga residual no dia seguinte, mas recuperação geralmente completa até o segundo dia |
| 300–450 | Alta | Pode haver fadiga residual mesmo depois de 2 dias |
| >450 | Muito alta | Fadiga residual durando vários dias é provável |

Aplicação ao feedback: esta tabela é uma referência objetiva para estimar quantos dias de recuperação uma sessão específica provavelmente vai exigir, com base apenas no TSS calculado daquela atividade — útil tanto para o feedback do dia seguinte (explicar por que o atleta ainda está cansado) quanto para o planejamento da semana seguinte.$m9477$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9478$nota-0086$m9478$, $m9479$Ajuste da constante de tempo do ATL por idade (Tabela 9.1)$m9479$, $m9480$recuperacao-e-fadiga$m9480$,
  $m9481$direta$m9481$, $m9482$referencia$m9482$,
  ARRAY[$m9483$semanal$m9483$]::text[], '{}'::text[],
  0.8, $m9484$ativo$m9484$, $m9485$Tabela 9.1 do livro — como ajustar a constante de tempo do ATL (padrão de 7 dias) conforme a idade do atleta, já que a velocidade de recuperação diminui com a idade:

| Idade | Constante de tempo do ATL |
|---|---|
| <19 anos | 2–4 dias |
| 20–29 anos | 4–7 dias |
| 30–49 anos | 6–8 dias |
| 50–59 anos | 7–10 dias |
| 60–65 anos | 9–12 dias |
| 66–70+ anos | 11–14 dias |

Quanto mais velho o atleta, maior a constante de tempo recomendada (ATL "enxerga" um período mais longo do passado), refletindo recuperação mais lenta. Além da idade, a constante de tempo ideal também depende da duração do evento-alvo (ver nota-0087) — os dois fatores podem ser combinados.

Aplicação ao feedback: ao calcular ATL/TSB para atletas mais velhos, ajustar a constante de tempo conforme a faixa etária desta tabela em vez de usar sempre os 7 dias padrão — isso evita interpretar erroneamente uma recuperação mais lenta (esperada pela idade) como fadiga anômala.$m9485$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m9486$nota-0090$m9486$, $m9487$Taxa segura de aumento de CTL (ramp rate): 3-7 TSS/dia por semana; acima de 7 por mais de 4 semanas arrisca overreaching$m9487$, $m9488$recuperacao-e-fadiga$m9488$,
  $m9489$direta$m9489$, $m9490$regra-interpretacao$m9490$,
  ARRAY[$m9491$semanal$m9491$, $m9492$mensal$m9492$]::text[], ARRAY[$m9493$TSS$m9493$]::text[],
  0.7, $m9494$ativo$m9494$, $m9495$**Taxa segura de referência: aumentar o CTL a 3–7 TSS/dia por semana** é sustentável para a maioria dos ciclistas. Ultrapassar 7 TSS/dia por semana por mais de 4 semanas seguidas arrisca entrar numa espiral de overreaching. Picos de ramp rate acima de 7 são toleráveis por 1 semana (possivelmente 2), mas períodos mais longos tendem a levar a um estado de overreaching crônico.

A taxa segura também depende da "idade de treino" (anos de treino sério) do atleta e do CTL atual — quanto mais experiente o atleta e quanto mais distante do teto (CTL <100 vs. >100), maior a taxa de aumento tolerável. Tabela 9.2 do livro (seleção representativa, blocos de 14-28 dias vs. <14 dias):

| Idade de treino | Duração do bloco | CTL <100 | CTL >100 |
|---|---|---|---|
| 5+ anos | Longo prazo (14-28 dias) | 7–10 TSS/dia | 5–7 TSS/dia |
| 3-5 anos | Longo prazo | 5–8 TSS/dia | 3–6 TSS/dia |
| 1-3 anos | Longo prazo | 4–7 TSS/dia | 3–5 TSS/dia |
| <1 ano | Longo prazo | 3–5 TSS/dia | 3–4 TSS/dia |
| 5+ anos | Curto prazo (<14 dias, ex. training camp) | 14–20 TSS/dia | 10–14 TSS/dia |
| 3-5 anos | Curto prazo | 10–16 TSS/dia | 6–12 TSS/dia |
| 1-3 anos | Curto prazo | 8–14 TSS/dia | 6–12 TSS/dia |
| <1 ano | Curto prazo | 6–10 TSS/dia | 6–8 TSS/dia |

Padrão geral: quanto mais próximo do teto de CTL (>100) e quanto menos experiente o atleta, mais conservadora deve ser a taxa de aumento. Rampas curtas e agressivas (ex.: semana de training camp) devem ser seguidas de uma semana de descarga.

**Ressalva de citação parcial da tabela (2026-08-02, achado de auditoria adversarial):** só a linha "5+ anos" (longo e curto prazo) tem trecho-fonte verbatim no frontmatter. As outras 6 linhas (3-5 anos, 1-3 anos, <1 ano, em ambas as durações) foram transcritas da Tabela 9.2 do livro sem que o trecho literal correspondente tenha sido capturado no frontmatter — não podem ser conferidas contra a fonte a partir do que está registrado aqui. Busca externa (2026-08-02) tentou localizar a tabela completa de forma independente e não teve sucesso — nenhuma fonte terciária reproduz a tabela inteira por idade de treino. As 6 linhas não confirmadas são, porém, internamente consistentes com o padrão da linha confirmada e com a lógica geral do texto (taxa tolerável cai de forma monotônica conforme a idade de treino diminui e conforme o CTL sobe acima de 100, em ambas as colunas de duração, sem nenhuma inversão ou salto anômalo) — tratadas como plausíveis por consistência interna, não como número inventado, mas com confiança mais baixa que a linha citada literalmente. `confianca` da nota rebaixada de 0,8 para 0,7 para refletir essa citação parcial (mesmo critério de downgrade por indireção usado em nota-0256/nota-0270 do domínio fisiologia). Ao comunicar as faixas das 6 linhas não confirmadas ao atleta, tratar como estimativa razoável, não como número garantido do livro.

Aplicação ao feedback: calcular a taxa de variação do CTL ao longo das últimas semanas e comparar com essas faixas de referência (ajustadas por idade de treino e CTL atual) para sinalizar risco de overreaching antes que ele se manifeste como queda de performance ou doença.$m9495$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;