BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34535$skill-gerais-multiesporte-corrida$m34535$, $m34536$skill-0007$m34536$, $m34537$Equivalência de carga bike-corrida (rTSS/FTp) e separação em 3 PMCs para multiesporte$m34537$,
  $m34538$metricas-de-potencia$m34538$, $m34539$detector$m34539$,
  ARRAY[$m34540$nota-0114$m34540$, $m34541$nota-0115$m34541$]::text[],
  $m34542$0.7$m34542$, $m34543$a nota-0114 define a EQUIVALÊNCIA DE ESCALA do rTSS (45min corrida FTp ≈ 100 pontos, mesmo que 60min bike FTP ≈ 100 pontos), mas NÃO fornece a fórmula matemática completa de rTSS por segundo (que exigiria NGP — Normalized Graded Pace — cuja fórmula não foi extraída no cânone destas 4 fontes). Por isso: esta skill NÃO calcula rTSS numérico de uma corrida — reporta apenas a equivalência de escala como contexto, e sinaliza a lacuna explicitamente. Sem essa fórmula, o PMC 'combinado' (bike+corrida) fica Ausente/incompleto — só o PMC de bike (via skill-gerais-tss-sessao) é calculável com o cânone atual. Isso é uma lacuna real do cânone, não um erro desta skill.$m34543$,
  $m34544$[{"campo": "lista_atividades_por_esporte", "tipo": "bruto", "obrigatorio": "true", "fonte": "Strava: tipo de atividade (Ride/Run) de cada entrada do histórico"}, {"campo": "tss_bike", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-tss-sessao (para as atividades de bike)"}]$m34544$::jsonb, $m34545$[{"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-pmc", "tipo": "pre-requisito"}]$m34545$::jsonb,
  $m34546$[]$m34546$::jsonb, $m34547$proposto$m34547$, $m34548$## O que faz

Para atletas multiesportivos (ex.: triatletas) com dados de bike e corrida no Strava: (a) sinaliza a equivalência de escala de carga entre os dois esportes (corrida gera mais estresse por hora que bike, por isso 100 pontos de rTSS correspondem a só ~45min de corrida no FTp, não 60min); (b) orienta a construção de PMC separado por esporte (bike, corrida, combinado) em vez de um único PMC que mistura os dois sem essa correção de escala.

**Não calcula rTSS numérico** — essa é uma lacuna explícita do cânone (ver `condicao_nao_calculavel`), registrada aqui em vez de inventar uma fórmula que as 4 fontes não fornecem.

## Quando usar

- Quando o atleta tiver atividades de corrida além de bike no histórico, e for necessário decidir como tratar a carga de treino combinada.
- Para evitar o erro de aplicar a fórmula de TSS de bike (nota-0062) diretamente ao tempo de corrida, que subestimaria a carga real da corrida (por não contar o estresse musculoesquelético adicional do impacto).

## Passo a passo

1. **Identificar atividades de corrida** no histórico do atleta, separadas das de bike.
2. **Para as atividades de bike:** usar `skill-gerais-tss-sessao` normalmente (TSS via NP/IF/FTP).
3. **Para as atividades de corrida:** sinalizar que a carga não pode ser somada diretamente ao TSS de bike sem conversão — reportar a equivalência de escala (nota-0114) como contexto qualitativo (corrida no FTp gera mais estresse por hora que bike no FTP), mas não produzir um número de rTSS (lacuna do cânone).
4. **Orientar a separação em 3 PMCs** (nota-0115): bike isolado (calculável via `skill-gerais-pmc` sobre o TSS de bike), corrida isolada (não calculável numericamente com o cânone atual — ver passo 3), e combinado (não calculável enquanto rTSS não tiver fórmula).
5. **Checar a condição de não-calculável** antes de reportar qualquer PMC como completo.

## Output

```
{
  "tem_atividades_corrida": <bool>,
  "pmc_bike": "calculável via skill-gerais-pmc" | null,
  "pmc_corrida": "não calculável — fórmula de rTSS ausente do cânone",
  "pmc_combinado": "não calculável — depende de rTSS",
  "equivalencia_escala_contexto": "~45min de corrida no FTp ≈ 60min de bike no FTP, em termos de carga de treino (nota-0114) — corrida gera mais estresse por hora devido ao impacto",
  "provenance": "Ausente",
  "motivo_provenance": "fórmula de rTSS não extraída do cânone (depende de Normalized Graded Pace, não documentado nas 4 fontes) — lacuna explícita, não erro de cálculo",
  "notas_citadas": ["nota-0114", "nota-0115"]
}
```$m34548$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34549$skill-gerais-nutricao-sessao$m34549$, $m34550$skill-0006$m34550$, $m34551$Faixa de ingestão de carboidrato sugerida por duração da sessão$m34551$,
  $m34552$nutricao-e-energia$m34552$, $m34553$calculadora$m34553$,
  ARRAY[$m34554$nota-0201$m34554$]::text[],
  $m34555$0.6$m34555$, $m34556$sem tempo-movimento nem tempo-decorrido da sessão → não é possível sugerir faixa, reportar Ausente. Esta skill NUNCA verifica ingestão real — o Strava não registra nutrição — só sugere a faixa esperada para a duração observada; nunca reportar 'provenance: Medido', mesmo com duração exata disponível, porque o que está sendo estimado é uma recomendação, não uma medição.$m34556$,
  $m34557$[{"campo": "duracao_sessao", "tipo": "bruto", "obrigatorio": "true", "fonte": "Strava: tempo-movimento (ou tempo-decorrido) da atividade"}]$m34557$::jsonb, $m34558$[]$m34558$::jsonb,
  $m34559$[]$m34559$::jsonb, $m34560$proposto$m34560$, $m34561$## O que faz

Sugere a faixa de ingestão de carboidrato (g/h) recomendada para uma sessão, a partir da duração observada (tempo-movimento ou tempo-decorrido) — não verifica ingestão real, que o Strava não registra.

## Quando usar

- Ao dar feedback educativo pós-sessão para sessões longas (>1h), como contexto nutricional complementar ao feedback de carga/potência.
- Ao planejar nutrição para uma sessão futura de duração conhecida (ex.: prova-alvo).

## Passo a passo

1. **Obter a duração da sessão** (tempo-movimento preferencialmente; tempo-decorrido como alternativa se tempo-movimento não disponível).
2. **Classificar na faixa da tabela (nota-0201)** — convenção de fronteira: o valor-limite exato pertence à faixa em que aparece como teto (60min ainda é faixa 1; 120min ainda é 1-2h; 180min ainda é 2-3h — ver nota-0201):
   - duração ≤ 60min → geralmente desnecessário (exceto bochecho de carboidrato em provas muito intensas perto de 60min, que pode ajudar via efeito central/sensorial sem ingestão real).
   - 60min < duração ≤ 120min → 30-60 g/h.
   - 120min < duração ≤ 180min → 60-90 g/h.
   - duração > 180min → 90-120 g/h (só para atletas com intestino treinado a tolerar essa quantidade).
3. **Reportar a faixa como sugestão**, nunca como verificação — deixar explícito que o Strava não captura ingestão real. Sempre incluir a ressalva de individualização (nota-0201: "recomendações devem ser individualizadas — nem todos toleram grandes quantidades") no campo `observacao` de toda faixa reportada, não apenas na faixa >3h — ver passo 3a.
3a. **Ressalva de individualização por faixa**: 1-2h e 2-3h → "faixa geral da nutrição esportiva; ajustar para baixo se houver desconforto gastrointestinal"; >3h → ressalva mais forte já existente ("faixa superior só recomendada com intestino treinado").
4. **Checar a condição de não-calculável** antes de reportar.

## Output

```
{
  "duracao_sessao_min": <float>,
  "faixa_carboidrato_g_h": "<texto, ex.: '60-90'>",
  "observacao": "<texto, obrigatório em toda faixa — ressalva de individualização específica da faixa (ver passo 3a), ex.: 'sessão >3h — faixa superior só recomendada com intestino treinado'>",
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "sugestão baseada em duração, não verificação de ingestão real (Strava não registra nutrição)",
  "notas_citadas": ["nota-0201"]
}
```$m34561$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;