BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34893$skill-gerais-zonas-fc$m34893$, $m34894$skill-0005$m34894$, $m34895$Zonas de treino por frequência cardíaca — FCmáx prevista e Percentage Method vs. Karvonen (HRR)$m34895$,
  $m34896$avaliacao-e-testes$m34896$, $m34897$calculadora$m34897$,
  ARRAY[$m34898$nota-0245$m34898$, $m34899$nota-0051$m34899$]::text[],
  $m34900$0.7$m34900$, $m34901$sem idade do atleta no perfil → nenhuma fórmula de FCmáx prevista é aplicável, zona de FC calculada (Calculado) fica indisponível — ver fallback de zona Manual abaixo antes de reportar Ausente. Sem FC de repouso no perfil → método de Karvonen (HRR) não é aplicável; usar Percentage Method, sinalizando que produz zonas mais conservadoras (limites mais baixos) que o Karvonen para a mesma pessoa. Nunca reportar zonas calculadas por métodos diferentes para o mesmo atleta em momentos diferentes sem sinalizar a mudança de método — isso invalida a comparação ao longo do tempo.$m34901$,
  $m34902$[{"campo": "idade_atleta", "tipo": "manual", "obrigatorio": "true", "fonte": "perfil do atleta"}, {"campo": "fc_repouso", "tipo": "manual", "obrigatorio": "false", "fonte": "perfil do atleta", "observacao": "se ausente, usa Percentage Method em vez de Karvonen/HRR"}, {"campo": "fc_maxima_medida", "tipo": "bruto", "obrigatorio": "false", "fonte": "teste real de FCmáx do atleta, se houver", "observacao": "quando disponível deveria prevalecer sobre a fórmula prevista, mas o cânone atual não documenta esse caso explicitamente — sinalizar como lacuna se ocorrer"}, {"campo": "zona_fc_manual_plataforma", "tipo": "manual", "obrigatorio": "false", "fonte": "Strava: campo heart_rate_zone_source=Manual, quando o atleta configura a zona diretamente na plataforma", "observacao": "fallback só usado quando não há idade cadastrada — ver fallback_zona_manual"}]$m34902$::jsonb, $m34903$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "complementar"}]$m34903$::jsonb,
  $m34904$[]$m34904$::jsonb, $m34905$proposto$m34905$, $m34906$## O que faz

Calcula a FCmáx prevista do atleta por idade (priorizando a fórmula de menor viés) e a zona de treino sensível por FC (limite inferior/superior), por um dos dois métodos do cânone: Percentage Method (percentual direto da FCmáx) ou Karvonen/HRR (baseado na reserva de FC). Serve como sinal complementar às zonas de potência (`skill-gerais-ftp-e-zonas`) — útil quando não há medidor de potência confiável, ou como sinal cruzado.

## Quando usar

- Quando houver FC média/máx do Strava e idade do atleta (perfil), e for útil reportar a zona de FC de uma sessão.
- Quando não houver medidor de potência (ou ele for suspeito de viés — ver `skill-gerais-qualidade-de-dado`) e a FC for o sinal de intensidade disponível.
- Ao comparar zonas de FC do atleta ao longo do tempo — sempre conferir que o mesmo método está sendo usado de ponta a ponta.

## Passo a passo

0. **Checar se há histórico de FC suficiente para estimar a FTHR observada** (nota-0051): se houver um conjunto de dados grande o bastante com tempo em e acima do FTP, montar a distribuição de tempo por faixa de FC (bins de 3-5bpm) e procurar o degrau/queda brusca — esse valor é uma estimativa de FTHR ancorada em dados reais do próprio atleta, não numa fórmula de idade. Quando disponível, esta estimativa **deve prevalecer** sobre a zona derivada de FCmáx prevista (passos 1-5), de forma análoga à prioridade de FTP medido sobre FTP estimado em `skill-gerais-ftp-e-zonas` — reportar com `provenance: "Estimado"` (nunca "Calculado" nem "Medido", pois não é fórmula nem teste de laboratório). Sem histórico suficiente, seguir para o cálculo por idade (passo 1).
1. **Obter idade do atleta** (perfil). Sem isso, nenhuma fórmula de FCmáx é aplicável.
2. **Calcular FCmáx prevista**, priorizando **Gellish (206,9 − 0,67×idade)** por ter o menor viés documentado (desvio-padrão ±5-8 bpm, independente de sexo/IMC/FC de repouso) — evitar a fórmula clássica (220−idade), que superestima em <40 anos e subestima em >40 anos. **Tanaka (208−0,7×idade)** é a fórmula-base usada pelo método de Karvonen no cânone (passo 4).
3. **Verificar se há FC de repouso no perfil.** Se sim → usar o método de Karvonen (passo 4). Se não → usar o Percentage Method (passo 5).
4. **Método de Karvonen (HRR), se FC de repouso disponível:** `LLTHR = (FCmáx − FCrepouso) × 0,50 + FCrepouso`; `ULTHR = (FCmáx − FCrepouso) × 0,85 + FCrepouso`.
5. **Percentage Method, se sem FC de repouso:** `LLTHR = FCmáx × 70%` (60% se idade >60 anos); `ULTHR = FCmáx × 90%` (80% se idade >60 anos). Sinalizar que este método produz zonas mais baixas/conservadoras que o Karvonen para a mesma pessoa.
6. **Registrar qual fórmula de FCmáx e qual método de zona foram usados** — nunca misturar métodos diferentes para o mesmo atleta ao comparar zonas ao longo do tempo (checar o método usado na última vez antes de recalcular).
7. **Antes de reportar Ausente**, checar se a plataforma de origem tem zona de FC configurada com fonte "Manual" (ver `fallback_zona_manual` no frontmatter). Se tiver, usar como fallback com `provenance: "Manual"` — nunca promovê-la a "Calculado" nem "Medido".
8. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer número como Medido/Calculado/Manual.

## Output

```
{
  "fcmax_prevista_bpm": <float>,
  "formula_fcmax_usada": "gellish" | "tanaka" | "classica",
  "fc_repouso_bpm": <float, null se ausente>,
  "metodo_zona": "karvonen_hrr" | "percentage_method",
  "fthr_estimado_distribuicao_bpm": <float, null se histórico insuficiente>,
  "zona_treino": {
    "limite_inferior_bpm": <float>,
    "limite_superior_bpm": <float>
  },
  "alertas": [
    "metodo_mudou_desde_ultima_medicao" | "sem_fc_repouso_zona_conservadora" | "zona_manual_origem_desconhecida" | "fthr_observada_disponivel_prevalece_sobre_formula_idade" | null
  ],
  "provenance": "Medido" | "Estimado" | "Calculado" | "Manual" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado, Calculado, Manual ou Ausente — ex.: 'FTHR estimada pelo degrau na distribuição de FC, não é teste de laboratório' (Estimado), 'FCmáx é prevista por fórmula, não medida diretamente' (Calculado), ou 'zona configurada manualmente na plataforma, origem dos limites não verificada' (Manual)>",
  "notas_citadas": ["nota-0245", "nota-0051"]
}
```

Nota de honestidade obrigatória: mesmo com todos os dados de entrada disponíveis, `provenance` aqui **nunca deve ser "Medido"** — FCmáx por fórmula de idade é sempre uma estimativa (desvio-padrão documentado de ±5-8 bpm mesmo na fórmula de menor viés), não uma medição direta do atleta. A zona derivada da FTHR observada por distribuição (nota-0051, passo 0) é **"Estimado"** — mais próxima do atleta real que uma fórmula de idade, mas ainda não é um teste dedicado de laboratório, então não é "Medido". Quando vier do fallback de plataforma, `provenance` é **"Manual"**, uma categoria à parte — não é cálculo do cânone (não é "Calculado") e não é medição de sensor (não é "Medido"); é a decisão operacional do projeto de 2026-07-19, documentada em `fallback_zona_manual` acima, não uma nota do cânone.$m34906$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;