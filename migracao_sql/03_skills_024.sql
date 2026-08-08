BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m35124$skill-subida-pacing$m35124$, $m35125$skill-0020$m35125$, $m35126$Pacing de prova — orçamento de TSS→NP-alvo, diretrizes de subida, sit-on vs. puxar, DNF por excesso de ritmo, estratégia por duração ultra, isopower em CRI plano$m35126$,
  $m35127$tipos-de-treino$m35127$, $m35128$calculadora+detector$m35128$,
  ARRAY[$m35129$nota-0111$m35129$, $m35130$nota-0112$m35130$, $m35131$nota-0120$m35131$, $m35132$nota-0121$m35132$, $m35133$nota-0117$m35133$, $m35134$nota-0138$m35134$, $m35135$nota-0118$m35135$, $m35136$nota-0137$m35136$]::text[],
  $m35137$0.55$m35137$, $m35138$sem FTP válido no perfil (pré-requisito: skill-gerais-ftp-e-zonas) → NP-alvo não é calculável. Sem duração-alvo e TSS orçado declarados pelo atleta para a prova → o orçamento de TSS→NP-alvo (nota-0111) fica Ausente. Sem perfil de elevação disponível → não é possível diferenciar subida-com-descida-de-recuperação de subida-platô (nota-0120), reportar Ausente para esse eixo. O valor '~15W' (nota-0117) nunca deve ser comunicado como limiar numérico confiável, apenas como justificativa qualitativa. Sem a modalidade/contexto da atividade (skill-classificacao-contexto-atividade) → não é possível saber se as diretrizes de início conservador (Passo 3/nota-0112 ou Passo 8/nota-0118) se aplicam ou se é um caso de MTB ultraresistência sem draft (Passo 2/nota-0137, Efeito Allen) — NÃO presumir modalidade de estrada por padrão; reportar Ausente para o eixo de contenção inicial até a modalidade ser conhecida.$m35138$,
  $m35139$[{"campo": "ftp_vigente", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-ftp-e-zonas"}, {"campo": "duracao_alvo_tss_orcado", "tipo": "manual", "obrigatorio": "false", "fonte": "declaração do atleta sobre duração-alvo e TSS orçado para a prova", "observacao": "sem isso, orçamento de TSS→NP-alvo fica Ausente"}, {"campo": "perfil_elevacao", "tipo": "bruto", "obrigatorio": "false", "fonte": "Strava: altimetria da atividade", "observacao": "sem isso, não dá para diferenciar subida-com-descida-de-recuperação de subida-platô"}, {"campo": "modalidade_contexto_atividade", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-classificacao-contexto-atividade", "observacao": "obrigatório para decidir entre início conservador (estrada/CRI) e Efeito Allen (MTB ultraresistência, nota-0137) — sem isso, o eixo de contenção inicial fica Ausente, nunca presumir estrada por padrão"}]$m35139$::jsonb, $m35140$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-classificacao-contexto-atividade", "tipo": "pre-requisito"}]$m35140$::jsonb,
  $m35141$[]$m35141$::jsonb, $m35142$proposto$m35142$, $m35143$## O que faz

Calcula a Potência Normalizada-alvo (NP-alvo) de pacing para uma prova longa a partir de um orçamento de TSS e da duração-alvo (método Endurance Nation), aplica as diretrizes práticas de execução (contenção inicial, ajustes em subidas), diferencia o pacing de subidas com descida de recuperação das subidas que "platô", aplica a regra da FTP para decidir entre sentar na roda ou puxar numa fuga, sinaliza o risco de excesso de ritmo no bike leg de triathlon, diferencia a estratégia esperada por duração em provas de ultraresistência, e aplica o protocolo isopower para contrarrelógio plano.

## Quando usar

- Ao planejar ou avaliar retrospectivamente o pacing de uma prova longa (contrarrelógio, triathlon, ultraresistência).
- Ao analisar trechos de subida dentro de uma prova com perfil de elevação disponível.
- Ao explicar por que um atleta foi "cuspido" de um grupo/fuga, ou por que não terminou uma prova (DNF).

## Passo a passo

1. **Calcular a NP-alvo**: `TSS_por_hora = TSS_orçado ÷ horas_de_prova`; `IF = sqrt(TSS_por_hora ÷ 100)`; `NP_alvo = IF × FTP`. Referência de orçamento para Ironman: ~280 TSS realista, 300 TSS é o teto de risco (nota-0111).
2. **Checar a modalidade antes de tudo (pré-requisito: skill-classificacao-contexto-atividade)**: se a modalidade for MTB ultraresistência ou offroad longa sem pelotão/draft real após os primeiros ~15min → **não aplicar início conservador nem o Passo 2 nem o Passo 7** — nota-0137 (Efeito Allen) mostra que segurar o ritmo cedo raramente ajuda em MTB: quem acelera numa seção mais rápida e abre um gap de distância cedo tende a mantê-lo, porque quem fica pra trás raramente consegue fechar a diferença depois. Reportar isso como contexto da modalidade, sem aplicar as diretrizes de contenção dos passos abaixo. Sem a modalidade conhecida, reportar Ausente para este eixo — nunca presumir estrada por padrão (ver `condicao_nao_calculavel`).
3. **Escolher o protocolo pelo perfil da prova** (só para modalidades de estrada/CRI, fora do caso do passo 2 acima), antes de aplicar diretrizes de execução: se a prova for um contrarrelógio plano (sem subidas significativas no perfil de elevação) → pular direto para o protocolo isopower do Passo 8 (nota-0118 já chama isso de "estratégia padrão para qualquer CRI", e a evidência de pacing esportivo confirma que pacing constante é o que funciona melhor em prova plana, enquanto pacing variável com mais força na subida ganha tempo em prova com relevo). Se a prova tiver subidas relevantes (triathlon, prova de estrada, gran fondo, CRI com relevo) → seguir para as diretrizes abaixo (nota-0112): primeiros 30-45min a 95% da NP-alvo (início conservador); restante da prova em plano o mais próximo possível da NP-alvo; subidas mais longas que 3min a 105% da NP-alvo; subidas de 30s-2min a 110% da NP-alvo. Os Passos 3 e 8 são protocolos **alternativos** escolhidos pelo perfil da prova, não etapas sequenciais do mesmo pacing.
4. **Diferenciar tipo de subida** (requer perfil de elevação): se há descida de recuperação logo em seguida, pode empurrar mais forte — usar como teto a potência máxima sustentável para aquela duração (Níveis de Coggan) menos 5-10 pontos percentuais de margem (ex.: ~105%FTP numa subida de 3min). Se a subida "platô" (sem descida imediata), manter na FTP ou levemente acima, e retomar rapidamente a velocidade ao cruzar o topo — qualquer tempo abaixo da FTP no platô/reta após o topo é tempo perdido para os concorrentes (nota-0120).
5. **Decidir sit-on vs. puxar numa fuga**: se a potência mesmo no vale de menor exigência da rotação (draft) já está acima da FTP do atleta, sinalizar que o ritmo do grupo é insustentável a médio prazo e recomendar sentar na roda em vez de continuar puxando (nota-0121).
6. **Triathlon — peso extra ao alerta de excesso de ritmo**: dar peso extra (não limiar numérico) a alertas de pacing agressivo no bike leg quando o NP/IF real excede o orçamento calculado (passo 1) — citar que mesmo pequenos excessos de ritmo são apontados qualitativamente como a principal causa de DNF em triathlon, sem tratar "~15W" como limiar validado (nota-0117).
7. **Ultraresistência — estratégia por duração**: para provas de ~24h, reconhecer que pacing agressivo nas primeiras 4-6h (estabelecer um gap) tende a se manter pelo resto da prova; para provas de 6-8h, esperar que os ataques decisivos ocorram perto do final — tratar ambas como tendências qualitativas, não regras rígidas (nota-0138).
8. **CRI plano — protocolo isopower**: primeiros 15-30s para atingir velocidade sem disparar a potência; corpo da prova o mais próximo possível da FTP, com a menor variação possível; últimos minutos aumentar a intensidade. Contenção inicial proporcional à duração: ~5min de contenção para CRI de 40km, ~2min para prova de 10 milhas, quase nenhuma para perseguição de 4km — quanto mais curta a prova, menos se deve segurar (nota-0118).
9. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer NP-alvo ou veredito de pacing.

## Output

```
{
  "np_alvo_w": <float, null>,
  "if_alvo": <float, null>,
  "tss_orcado": <float, null>,
  "modalidade_contexto": "<string ou null — obrigatório para decidir o protocolo de contenção inicial>",
  "protocolo_contencao_inicial": "estrada_diretrizes_execucao" | "estrada_isopower_cri_plano" | "mtb_ultra_efeito_allen_sem_contencao" | "nao_calculavel_modalidade_ausente",
  "diretrizes_execucao": {"primeiros_30_45min_pct": 95, "subida_longa_3min_pct": 105, "subida_curta_2min_pct": 110},
  "tipo_subida_identificado": "com_descida_recuperacao" | "plato" | "indeterminado",
  "sit_on_recomendado": <bool, null>,
  "risco_dnf_excesso_ritmo": {"sinalizado": <bool>, "np_real_vs_alvo_w": <float, null>},
  "estrategia_ultra_por_duracao": "agressivo_inicio_24h" | "conservar_para_final_6_8h" | null,
  "protocolo_isopower_cri_plano": {"contencao_inicial_min": <float, null>, "aderencia_ftp": <bool, null>},
  "alertas": [
    "inicio_muito_forte" | "subida_platô_perdeu_tempo_apos_topo" | "ritmo_insustentavel_no_vale_da_rotacao" | "excesso_ritmo_bike_leg_risco_dnf" | "modalidade_mtb_ultra_efeito_allen_contencao_nao_aplicavel" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0111", "nota-0112", "nota-0120", "nota-0121", "nota-0117", "nota-0138", "nota-0118", "nota-0137"]
}
```$m35143$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;