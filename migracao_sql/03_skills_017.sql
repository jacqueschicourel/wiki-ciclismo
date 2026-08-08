BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34795$skill-gerais-testes-deliberados$m34795$, $m34796$skill-0008$m34796$, $m34797$Testes deliberados de laboratório de campo — Astrand submáximo (VO2máx) e Wingate (potência/capacidade anaeróbia)$m34797$,
  $m34798$avaliacao-e-testes$m34798$, $m34799$calculadora$m34799$,
  ARRAY[$m34800$nota-0218$m34800$, $m34801$nota-0235$m34801$, $m34802$nota-0101$m34802$, $m34803$nota-0234$m34803$, $m34804$nota-0163$m34804$, $m34805$nota-0072$m34805$]::text[],
  $m34806$0.55$m34806$, $m34807$escopo restrito por definição: NUNCA aplicar a uma sessão arbitrária do Strava — só reconhecer quando o atleta CONFIRMA ter executado deliberadamente um dos protocolos (não inferir silenciosamente pelo padrão de potência, risco de falso positivo alto). Astrand: o fator de correção de VO2máx por idade citado na fonte não foi extraído em texto (aparece só como tabela/imagem no PDF) — reportar o VO2máx SEM correção etária como Estimado, nunca aplicar uma correção inventada, e sinalizar essa lacuna explicitamente em todo output. Wingate: Potência Pico deve vir da média dos primeiros 5s do esforço, não do pico instantâneo de 1s — se só houver pico instantâneo disponível, reportar como Estimado com essa ressalva. Teste de assimetria (nota-0072): exige balanço esquerda/direita disponível (medidor bilateral) nos 4 dias e marcação de lap distinguindo os 3 intervalos (em pé/sentado/alternado) de cada dia — sem esses dois dados, o teste não é diferenciável de 4 sessões comuns de VO2máx, reportar Ausente.$m34807$,
  $m34808$[{"campo": "confirmacao_atleta_protocolo", "tipo": "manual", "obrigatorio": "true", "fonte": "declaração explícita do atleta de que executou Astrand ou Wingate deliberadamente", "observacao": "nunca inferir silenciosamente pelo padrão de potência"}, {"campo": "fc_serie_temporal", "tipo": "bruto", "obrigatorio": "false", "fonte": "sensor de FC durante os 6min de carga constante", "observacao": "obrigatório apenas para o protocolo Astrand"}, {"campo": "potencia_serie_temporal", "tipo": "bruto", "obrigatorio": "false", "fonte": "stream de potência dos 30s all-out", "observacao": "obrigatório apenas para o protocolo Wingate"}, {"campo": "idade_atleta", "tipo": "manual", "obrigatorio": "false", "fonte": "perfil do atleta", "observacao": "usada na FC-alvo do protocolo Astrand"}, {"campo": "peso_corporal", "tipo": "manual", "obrigatorio": "true", "fonte": "perfil do atleta (RPP no Wingate e VO2máx relativo no Astrand)"}, {"campo": "ciclista_competitivo_adaptado", "tipo": "manual", "obrigatorio": "false", "fonte": "perfil do atleta ou declaração", "observacao": "se marcado, o ajuste de modalidade cicloergômetro→esteira (nota-0234) não é aplicado, pois ciclistas competitivos bem adaptados tendem a igualar os dois valores"}, {"campo": "balanco_esquerda_direita_serie", "tipo": "bruto", "obrigatorio": "false", "fonte": "medidor bilateral, nos 4 dias do teste de assimetria", "observacao": "obrigatório apenas para o protocolo de assimetria de pedalada (nota-0072)"}, {"campo": "marcacoes_de_lap", "tipo": "bruto", "obrigatorio": "false", "fonte": "marcações de lap distinguindo os 3 intervalos (em pé/sentado/alternado) de cada dia", "observacao": "obrigatório apenas para o protocolo de assimetria de pedalada (nota-0072)"}]$m34808$::jsonb, $m34809$[]$m34809$::jsonb,
  $m34810$[]$m34810$::jsonb, $m34811$proposto$m34811$, $m34812$## O que faz

Reconhece quando uma atividade corresponde a um dos dois protocolos de teste deliberado do cânone — Astrand submáximo (estima VO2máx sem esforço máximo) ou Wingate (mede potência e capacidade anaeróbia em esforço máximo de 30s) — e aplica as fórmulas correspondentes. Diferente de todas as outras skills `gerais/`, esta **não roda sobre sessões arbitrárias**: exige confirmação de que o atleta executou o protocolo de propósito.

## Quando usar

- Quando o atleta confirma (input próprio, não inferência automática) ter feito deliberadamente um teste de Astrand (carga constante buscando FC-alvo por 6min), Wingate (30s all-out com resistência fixa por kg de peso corporal), combinado 5min+20min, ou o teste de assimetria de pedalada em subida (4 dias, 3 intervalos de 5min por dia em pé/sentado/alternado).
- Nunca para classificar retroativamente uma sessão comum como se fosse um desses testes.

## Passo a passo

### Astrand (nota-0218)
1. Confirmar que o atleta executou deliberadamente o protocolo.
2. Calcular FC-alvo: `FCmáx (220−idade) − FCrepouso` (Reserva de FC/HRR **simplificada**, usada especificamente por esta nota para calibrar a carga do teste — **não é a fórmula de Karvonen** de `skill-gerais-zonas-fc`, que usa fator de intensidade e soma a FC de repouso de volta para definir zona de treino, não a diferença crua; corrigido nome em 2026-08-02 após achado de auditoria adversarial, ver nota de nomenclatura em nota-0218). Manter 220−idade aqui é deliberado, não uma inconsistência: é citação literal do protocolo-fonte do teste de Astrand (nota-0218), usada só para calibrar a carga inicial e checar se a FC estabilizou perto do esperado no passo 3 — o VO2máx final (passo 5) usa a FC estável **medida**, não essa FC-alvo prevista. O viés conhecido de 220−idade (superestima <40 anos, subestima >40 anos) é absorvido pelo ajuste-e-repetição do protocolo, não afeta a precisão do resultado.
3. Confirmar que a sessão tem ~6min em carga constante com FC estabilizando próxima do alvo nos últimos minutos.
4. Converter carga: `kg-m/min = watts × 6,12`.
5. Aplicar a fórmula por sexo (FC = FC estável do platô, em bpm):
   - Mulheres: `VO2máx (L/min) = (0,00193×carga + 0,326) / (0,769×FC − 56,1) × 100`
   - Homens: `VO2máx (L/min) = (0,00212×carga + 0,299) / (0,769×FC − 48,5) × 100`
6. **Não aplicar fator de correção por idade** — não está disponível em texto no cânone (lacuna registrada). Reportar o valor do passo 5 como Estimado, com a ressalva explícita de que falta a correção etária.
7. Para VO2máx relativo: `mL/kg/min = (VO2máx L/min ÷ peso corporal kg) × 1000`.
8. **Ajuste de modalidade** (nota-0234, achado de auditoria adversarial 2026-08-02 — antes era só ressalva textual, agora aplicado): calcular também um VO2máx "equivalente-esteira" estimado, somando 6,4-11,2% ao valor relativo do passo 7 (usar o ponto médio, ~8,8%, como estimativa central; reportar a faixa completa) — **exceto** se o atleta for sinalizado como ciclista competitivo bem adaptado à modalidade, caso em que não aplicar o ajuste (valores tendem a se igualar). Rotular sempre como "Estimado", nunca "Medido". Não tratar a diferença original (cicloergômetro vs. esteira) como erro de medição.
9. **Classificar contra a tabela de referência** (nota-0163): comparar o VO2máx relativo (equivalente-esteira, se ajustado) contra as faixas Sedentário (25-40) / Ativo (40-55) / Amador (50-65) / Elite nacional (65-75) / Elite internacional (75-85) / Excepcional (>85) mL/kg/min, e reportar a faixa em que o atleta se encaixa. Sempre acompanhar essa classificação da ressalva explícita da própria fonte (nota-0163): "o desempenho competitivo nunca deve ser previsto exclusivamente a partir do VO2máx" — nunca apresentar a classificação como um veredito de nível de desempenho isolado.

### Combinado 5min+20min (nota-0101)
1. Confirmar que o atleta executou deliberadamente os dois esforços máximos estruturados no mesmo dia: primeiro **5 minutos** all-out, depois (após recuperação) **20 minutos** all-out.
2. **FTP**: `20min × 0,95` (mesmo protocolo padrão de nota-0020) — a diferença deste protocolo é que o esforço de 5min prévio esgota parcialmente a Capacidade de Reserva Funcional (FRC), o que os autores afirmam tornar essa estimativa de FTP mais precisa (menor contribuição anaeróbia residual).
3. **Potência de VO2máx**: usar a potência média do teste de 5min diretamente como medida de campo da potência de VO2máx do atleta.
4. **Decisão Coggan Classic vs. iLevels**: calcular a razão P5min/FTP. Se essa razão exceder claramente a faixa padrão dos 7 níveis clássicos de Coggan para VO2máx (106-120% do FTP) — ex.: 150% — sinalizar que o atleta pode se beneficiar de zonas individualizadas (iLevels) em vez das zonas clássicas como base de treino.

### Wingate (nota-0235)
1. Confirmar que o atleta executou deliberadamente o protocolo (resistência fixa ~0,075-0,12 kg/kg de peso corporal, 30s all-out).
2. **Potência Pico (PP)**: maior potência média num intervalo de 5s dentro dos 30s (idealmente o primeiro).
3. **Potência Pico Relativa (RPP)**: `PP ÷ massa corporal (kg)`.
4. **Fadiga Anaeróbia (AF)**: `(PP mais alta − PP mais baixa) ÷ PP mais alta × 100`, comparando os intervalos de 5s ao longo dos 30s.
5. **Trabalho Anaeróbio (AW)**: soma do trabalho (J) ao longo dos 30s completos.
6. Comparar RPP e potência média (W/kg) contra a tabela de percentis (Tabela 11.2, por sexo).

### Assimetria de pedalada em subida (nota-0072)
1. Confirmar que o atleta executou deliberadamente o protocolo de 4 dias: numa mesma rota repetível (subida), 3 intervalos de 5min ao Nível 5/VO2máx (~113-115% FTP) em cada dia — um em pé o tempo todo, um sentado o tempo todo, um alternando.
2. **Dia 1 (linha de base)**: identificar, pelo balanço E/D, qual perna libera menos potência (GPR mais baixo) sem nenhuma ênfase consciente.
3. **Dia 2**: comparar o balanço E/D enfatizando conscientemente a perna mais fraca (identificada no Dia 1), em pé e sentado.
4. **Dias 3 e 4**: comparar o balanço E/D enfatizando apenas a perna esquerda (Dia 3) e apenas a direita (Dia 4).
5. **Diagnóstico**: se o desequilíbrio se corrige ao enfatizar a perna mais fraca **em pé** mas não sentado, é mais provável ser um efeito de postura/padrão de movimento, não de força muscular; se o desequilíbrio se corrige da mesma forma **sentado** (onde a postura tem menos influência), é mais provável ser uma discrepância real de força muscular entre os lados. Reportar como diagnóstico qualitativo (`postural` vs. `forca_muscular` vs. `indeterminado`), nunca como certeza absoluta — a nota-fonte é um exemplo único de atleta, não um estudo controlado.

## Output

```
{
  "protocolo": "astrand" | "wingate" | "combinado_5min_20min" | "assimetria_pedalada",
  "confirmado_pelo_atleta": <bool>,
  "astrand": {
    "vo2max_l_min_sem_correcao_idade": <float, null se não aplicável>,
    "vo2max_relativo_ml_kg_min": <float, null>,
    "correcao_idade_aplicada": false,
    "vo2max_relativo_equivalente_esteira_ml_kg_min": <float, null — ajuste de modalidade (nota-0234) aplicado, null se atleta sinalizado como ciclista competitivo>,
    "classificacao_nivel_nota0163": "sedentario" | "ativo" | "amador" | "elite_nacional" | "elite_internacional" | "excepcional" | null
  },
  "wingate": {
    "pp_w": <float, null>,
    "rpp_w_kg": <float, null>,
    "af_percentual": <float, null>,
    "aw_kj": <float, null>,
    "percentil_estimado": "<texto, ex.: 'entre P50 e P90 para potência média'>"
  },
  "combinado_5min_20min": {
    "ftp_w": <float, null>,
    "potencia_vo2max_5min_w": <float, null>,
    "razao_p5min_ftp": <float, null>,
    "recomendacao_zonas": "coggan_classic" | "ilevels" | null
  },
  "assimetria_pedalada": {
    "perna_mais_fraca_dia1": "esquerda" | "direita" | null,
    "corrige_em_pe": <bool, null>,
    "corrige_sentado": <bool, null>,
    "diagnostico": "postural" | "forca_muscular" | "indeterminado" | null
  },
  "alertas": ["correcao_idade_ausente_astrand" | "pico_instantaneo_usado_em_vez_de_media_5s" | "vo2max_cicloergometro_menor_que_esteira_esperado" | "razao_p5min_ftp_sugere_ilevels" | "classificacao_nao_prediz_desempenho_isoladamente" | null],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório>",
  "notas_citadas": ["nota-0218", "nota-0235", "nota-0101", "nota-0234", "nota-0163", "nota-0072"]
}
```$m34812$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;