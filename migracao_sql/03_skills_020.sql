BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34936$skill-estrutural-fase-e-sequenciamento$m34936$, $m34937$skill-0022$m34937$, $m34938$Fase da temporada e sequenciamento semanal — stacking de treinos perdidos, assinatura de zonas por fase, ordem de estímulos na semana$m34938$,
  $m34939$metodologia-e-periodizacao$m34939$, $m34940$detector$m34940$,
  ARRAY[$m34941$nota-0099$m34941$, $m34942$nota-0106$m34942$, $m34943$nota-0190$m34943$, $m34944$nota-0089$m34944$]::text[],
  $m34945$0.5$m34945$, $m34946$sem histórico de pelo menos a semana anterior de sessões consecutivas → o sequenciamento (nota-0190) não é avaliável, reportar Ausente. Sem a fase da temporada declarada pelo atleta (base/construção/pico) → a assinatura de distribuição de zonas (nota-0106) não tem referência para comparação, reportar Ausente. O detector de stacking (nota-0099) exige saber se houve um período de baixa atividade recente seguido de concentração de carga — sem esse padrão temporal claro, não aplicar o alerta. Dentro de uma janela de taper detectada por skill-estrutural-taper (1-3 semanas antes de evento-alvo declarado, volume caindo 40-60%), o passo de consistência de fase (distribuição de zonas) fica suspenso — reportar como Ausente/não-aplicável nessa janela, nunca como desvio de fase (ver passo 3).$m34946$,
  $m34947$[{"campo": "historico_sessoes_semana_anterior", "tipo": "bruto", "obrigatorio": "true", "fonte": "histórico de pelo menos a semana anterior de sessões consecutivas"}, {"campo": "fase_temporada_declarada", "tipo": "manual", "obrigatorio": "false", "fonte": "declaração do atleta sobre a fase da temporada (base/construção/pico)", "observacao": "sem isso, a assinatura de distribuição de zonas fica Ausente"}, {"campo": "zonas_potencia_distribuicao", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-ftp-e-zonas + skill-classificacao-tipo-de-sessao (tempo-em-zona do período)"}]$m34947$::jsonb, $m34948$[{"id": "skill-classificacao-tipo-de-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-fadiga-carga-avancada", "tipo": "complementar"}, {"id": "skill-estrutural-taper", "tipo": "pre-requisito"}]$m34948$::jsonb,
  $m34949$[]$m34949$::jsonb, $m34950$proposto$m34950$, $m34951$## O que faz

Detecta o padrão de risco de "stacking" (empilhamento de múltiplos treinos difíceis em poucos dias após um período de baixa atividade), compara a distribuição real de tempo-em-zona de um período contra a assinatura esperada para a fase da temporada declarada pelo atleta (base, construção, pré-competição, temporada de corridas), e sinaliza sequenciamento subótimo de estímulos intensos dentro da semana.

## Quando usar

- Ao detectar múltiplas sessões de alta intensidade/TSS concentradas em poucos dias após um período de baixa atividade.
- Ao avaliar se a distribuição de treino de um atleta é consistente com a fase da temporada que ele diz estar vivendo.
- Ao revisar o calendário semanal de treino em busca de sequenciamento subótimo (ex.: intervalado intenso no dia seguinte a uma sessão muito exigente).

## Passo a passo

1. **Detectar stacking**: se múltiplos treinos de alta intensidade/TSS elevado se concentram em 1-2 dias, logo após um período de baixa atividade na semana, sinalizar padrão de risco — com mais peso se for comportamento recorrente do atleta (nota-0099).
2. **Regra sobre treino perdido**: por padrão, não penalizar a ausência de reposição de um treino perdido — seguir para o próximo treino do plano é o comportamento recomendado. Exceção: se o treino perdido era altamente específico e não se repetirá por pelo menos 2 semanas, repor o quanto antes é válido — mas nunca empilhado com outro treino difícil no mesmo dia (nota-0099).
3. **Checar se o atleta está em janela de taper antes de avaliar consistência de fase** (rodar/consultar `skill-estrutural-taper`): se a data de um evento-alvo estiver declarada e o período avaliado cair dentro de 1-3 semanas antes dela, com volume caindo 40-60% em relação à linha de base — tratar como taper legítimo, NÃO como desvio de fase. Volume baixo concentrado em sessões curtas de intensidade mantida (padrão esperado de taper) distorce a proporção de tempo-em-zona sem que isso seja um problema de periodização — pular o passo 4 ou reportá-lo com essa ressalva explícita, nunca sinalizar "inconsistente com fase declarada" nessa janela.
4. **Comparar distribuição de zonas contra a fase declarada** (só fora de janela de taper, ver passo 3): Base (inverno/entressafra) → predomínio de Níveis 1-3; Construção (primavera) → aumento de Nível 3, 5 e 6; Pré-competição intensa → Nível 6 e Nível 1 sobem juntos (mais intensidade exige mais recuperação); Temporada de corridas → predomínio perto da FTP (Nível 4), com queda acentuada logo acima (nota-0106).
5. **Sinalizar desvios de fase**: um atleta "em fase de base" com tempo desproporcional em Níveis 5-6, ou "em pico de temporada" ainda predominantemente em Nível 2 (fora de janela de taper), são desvios dignos de nota no feedback.
6. **Avaliar sequenciamento semanal** (tratar como sugestão fraca — nota-0190 tem confiança baixa, 0,5): avaliar separadamente os 4 princípios de nota-0190, não apenas o primeiro — (a) complexidade quando descansado: sessão de maior complexidade/intensidade (VO2máx, força) no dia seguinte a uma sessão muito longa/extenuante; (b) qualidade antes de quantidade: mais volume não deveria vir à custa de qualidade das sessões-chave; (c) recuperação ativa após sessão exigente: dia seguinte a uma sessão muito extenuante deveria ser recuperação ativa, não outro estímulo forte; (d) estímulos semelhantes empilhados: dois treinos do mesmo sistema energético (ex.: dois VO2máx) em dias consecutivos.
7. **Detectar estagnação por platô de CTL** (nota-0089): se o CTL ficar estável por 4-6 semanas sem mudança de foco de treino e sem evolução de performance correspondente, sinalizar possível estagnação e sugerir progressão de carga — sinal complementar à assinatura de fase (passo 4): um atleta "estagnado" segundo este critério, mesmo com distribuição de zonas nominalmente consistente com a fase declarada, pode estar apenas mantendo fitness, não progredindo.
8. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer alerta.

## Output

```
{
  "stacking_detectado": <bool, null>,
  "treino_perdido_reposicao_recomendada": <bool, null>,
  "fase_temporada_declarada": "base" | "construcao" | "pre_competicao" | "temporada_corridas" | null,
  "distribuicao_zonas_consistente_com_fase": <bool, null>,
  "sequenciamento": {
    "sessao_complexa_apos_sessao_exigente": <bool, null>,
    "qualidade_comprometida_por_volume": <bool, null>,
    "recuperacao_ativa_ausente_apos_sessao_exigente": <bool, null>,
    "estimulos_semelhantes_empilhados": <bool, null>,
    "confianca": "baixa"
  },
  "estagnacao_ctl": {"detectada": <bool, null>, "semanas_platô": <float, null>},
  "alertas": [
    "stacking_padrao_de_risco" | "distribuicao_zonas_inconsistente_com_fase_declarada" | "sequenciamento_subotimo_sugestao_fraca" | "estimulos_semelhantes_empilhados_dias_consecutivos" | "estagnacao_ctl_apesar_de_fase_consistente" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0099", "nota-0106", "nota-0190", "nota-0089"]
}
```$m34951$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;