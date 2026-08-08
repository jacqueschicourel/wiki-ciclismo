BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34978$skill-estrutural-taper$m34978$, $m34979$skill-0021$m34979$, $m34980$Taper (polimento) pré-prova — verificar redução de volume de 40-60% mantendo intensidade$m34980$,
  $m34981$metodologia-e-periodizacao$m34981$, $m34982$detector$m34982$,
  ARRAY[$m34983$nota-0247$m34983$]::text[],
  $m34984$0.65$m34984$, $m34985$sem data do evento-alvo declarada pelo atleta → a janela de taper (1-3 semanas antes) não pode ser identificada, reportar Ausente. Sem histórico de volume/TSS de pelo menos algumas semanas antes do período avaliado → não há linha de base para calcular o percentual de redução, reportar Ausente. Sem IF por sessão dentro da janela de taper (campo if_por_sessao_na_janela_taper) → o passo 4 (verificar se a intensidade foi mantida) não é calculável; reportar `if_medio_mantido_moderado_alto: null` e Ausente só para esse subcomponente, sem impedir o cálculo dos passos 1-3 (janela/linha de base/redução de volume), que dependem só de historico_tss_semanal. A faixa de ganho de 0,5-6,0% nunca deve ser comunicada como previsão exata — é uma expectativa de evidência agregada de um estudo, sujeita a variação individual.$m34985$,
  $m34986$[{"campo": "data_evento_alvo", "tipo": "manual", "obrigatorio": "true", "fonte": "declaração do atleta sobre a data da prova-alvo"}, {"campo": "historico_tss_semanal", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-tss-sessao (série de TSS/volume semanal anterior ao período avaliado)"}, {"campo": "if_por_sessao_na_janela_taper", "tipo": "calculado", "obrigatorio": "true", "fonte": "IF = NP÷FTP de cada sessão dentro da janela de taper (nota-0059/nota-0247), agregado em média simples para o passo 4", "observacao": "campo adicionado 2026-08-02 (auditoria adversarial, moderados) — antes o passo 4 exigia 'IF médio das sessões remanescentes' sem que nenhum campo de dados_necessarios cobrisse isso explicitamente, apesar de IF já constar nos sinais da própria nota-0247. Sem esse campo por sessão (só o total agregado de historico_tss_semanal), o passo 4 não é calculável e deve reportar Ausente."}]$m34986$::jsonb, $m34987$[{"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-pmc", "tipo": "pre-requisito"}, {"id": "skill-classificacao-semana-recuperacao", "tipo": "complementar"}, {"id": "skill-estrutural-fase-e-sequenciamento", "tipo": "consumida-por"}]$m34987$::jsonb,
  $m34988$[]$m34988$::jsonb, $m34989$proposto$m34989$, $m34990$## O que faz

Verifica se o padrão de redução de volume de treino nas semanas anteriores a uma prova-alvo corresponde ao protocolo de taper (polimento) com melhor evidência — redução de volume de 40-60%, de forma progressiva ao longo de 1-3 semanas, mantendo a intensidade das sessões remanescentes em nível moderado a alto — e reporta a faixa de ganho de desempenho esperado quando o padrão é seguido corretamente.

## Quando usar

- Ao se aproximar de uma prova-alvo declarada pelo atleta (data conhecida).
- Ao avaliar retrospectivamente se o taper de uma prova recente seguiu o padrão de melhor evidência, como parte da explicação de um resultado bom ou ruim.

## Passo a passo

1. **Identificar a janela de taper**: 1 a 3 semanas antes da data do evento-alvo informada pelo atleta. **Atenção — são dois objetivos diferentes, não uma janela única (nota-0247, mesma citação-fonte para ambos):** um taper de 4-7 dias já é suficiente para a recuperação básica (reposição de glicogênio muscular/hepático, alívio de dor residual, cicatrização de pequenas lesões), mas o protocolo completo que produz o ganho de desempenho documentado (0,5-6,0%) exige a redução exponencial de volume ao longo de 1-3 semanas. Um taper de 4-7 dias até ~2 semanas cobre a recuperação básica mas fica fora da janela ideal de otimização de desempenho — tratar como categoria intermediária, não como "insuficiente" (ver passo 5).
2. **Calcular a linha de base de volume**: usar o TSS semanal total (ou tempo-movimento total) das semanas anteriores ao início do taper como referência.
3. **Calcular a redução real de volume**: comparar o TSS/volume de cada semana da janela de taper contra a linha de base — a redução ideal fica entre 40% e 60%, de forma progressiva (exponencial), não um corte abrupto único numa única semana.
4. **Verificar que a intensidade foi mantida**: calcular o IF de cada sessão dentro da janela de taper (campo `if_por_sessao_na_janela_taper`, IF=NP÷FTP) e tirar a média simples — deve permanecer moderado a alto, não cair junto com o volume (reduzir intensidade junto com volume tende a produzir resultado pior que reduzir só o volume). Sem esse campo, reportar `if_medio_mantido_moderado_alto: null` (ver condição de não-calculável).
5. **Concluir o veredito**, distinguindo três casos: (a) janela de 1-3 semanas com redução progressiva de 40-60% e intensidade mantida → `seguiu_protocolo_de_melhor_evidencia`; (b) janela de pelo menos 4-7 dias mas menor que ~2 semanas, com redução de volume observada → `taper_curto_recuperacao_basica_ganho_incerto` (recuperação fisiológica básica provavelmente atingida, mas fora da janela associada ao ganho de desempenho de 0,5-6,0% — não é "insuficiente", é uma categoria diferente); (c) volume permanece alto até menos de 4 dias antes da prova, ou intensidade cai junto com o volume → `taper_insuficiente_ou_tardio` ou `intensidade_caiu_junto_com_volume`, sinalizando que nem a recuperação básica está garantida.
6. **Reportar a expectativa de ganho** (0,5-6,0%) apenas como referência de evidência agregada quando o padrão foi seguido corretamente — nunca como previsão garantida individual (nota-0247, status "revisar").
7. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer veredito.

## Output

```
{
  "evento_alvo_data": "<data ou null>",
  "janela_taper_semanas": <float, null>,
  "volume_linha_de_base_tss_semana": <float, null>,
  "volume_durante_taper_tss_semana": [<float>],
  "reducao_pct": <float, null>,
  "dentro_da_faixa_40_60pct": <bool, null>,
  "reducao_progressiva": <bool, null>,
  "if_medio_mantido_moderado_alto": <bool, null>,
  "veredito": "seguiu_protocolo_de_melhor_evidencia" | "taper_curto_recuperacao_basica_ganho_incerto" | "taper_insuficiente_ou_tardio" | "intensidade_caiu_junto_com_volume" | "nao_calculavel",
  "ganho_desempenho_esperado_pct": {"min": 0.5, "max": 6.0, "aplicavel": <bool>},
  "alertas": ["taper_insuficiente" | "taper_curto_ganho_incerto" | "intensidade_nao_mantida" | null],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório — esta skill nunca reporta Medido, só Estimado (evidência agregada) ou Ausente>",
  "notas_citadas": ["nota-0247"]
}
```$m34990$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;