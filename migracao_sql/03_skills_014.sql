BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34614$skill-gerais-perfil-de-potencia-longo-prazo$m34614$, $m34615$skill-0010$m34615$, $m34616$Perfil de potência de longo prazo — MMP/PDC, Pmax, FRC, TTE, Stamina, Mapa Fenotípico, Power Profile, resistência à fadiga$m34616$,
  $m34617$metricas-de-potencia$m34617$, $m34618$calculadora+detector$m34618$,
  ARRAY[$m34619$nota-0053$m34619$, $m34620$nota-0103$m34620$, $m34621$nota-0037$m34621$, $m34622$nota-0077$m34622$, $m34623$nota-0078$m34623$, $m34624$nota-0080$m34624$, $m34625$nota-0081$m34625$, $m34626$nota-0082$m34626$, $m34627$nota-0031$m34627$, $m34628$nota-0032$m34628$, $m34629$nota-0034$m34629$, $m34630$nota-0124$m34630$, $m34631$nota-0104$m34631$, $m34632$nota-0105$m34632$, $m34633$nota-0097$m34633$, $m34634$nota-0038$m34634$, $m34635$nota-0035$m34635$, $m34636$nota-0036$m34636$, $m34637$nota-0200$m34637$]::text[],
  $m34638$0.5$m34638$, $m34639$sem pelo menos ~6 meses de histórico de potência (idealmente 1 ano) → MMP Curve não é confiável (nota-0053) — todos os cálculos derivados dela (PDC, Pmax, FRC, TTE, Stamina, Mapa Fenotípico) ficam Estimados na melhor hipótese, nunca Medidos. Um ponto da MMP só é válido se veio de um esforço genuinamente máximo naquela duração específica — não inferir o pico de 6min a partir de um esforço de 5min. Mapa Fenotípico (nota-0082): sem acesso a um ajuste de curva PDC individualizado (tipicamente feito por software como WKO4), reportar como Ausente ou Estimado de baixa confiança — o cânone não fornece a fórmula de ajuste completa, só a lógica conceitual das razões Pmax/FTP e FRC/Pmax. Power Profile (nota-0031, nota-0036): a tabela não tem correção por idade — não inferir isso ao aplicá-la a atletas mais velhos; a partir de ~30 anos, esperar declínio de VO2máx da ordem de ~0,5mL/kg/min/ano em homens e ~0,35 em mulheres (afetando mais as colunas de maior duração, 5min/FTP), enquanto força/potência (colunas 5s/1min) tende a se manter com treino até ~50 anos — um resultado mais fraco nas colunas longas de um atleta mais velho pode refletir em parte envelhecimento normal, não necessariamente falta de treino.$m34639$,
  $m34640$[{"campo": "historico_potencia_longo_prazo", "tipo": "bruto", "obrigatorio": "true", "fonte": "streams de potência de todas as atividades do período (idealmente ≥6 meses)"}, {"campo": "ftp_vigente", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-ftp-e-zonas (para localizar no Power Profile)"}, {"campo": "pdc_individualizada_software", "tipo": "estimado", "obrigatorio": "false", "fonte": "software externo (ex.: WKO4) com ajuste de curva Potência-Duração", "observacao": "sem isso, Mapa Fenotípico fica Ausente ou de baixa confiança"}, {"campo": "sexo_atleta", "tipo": "manual", "obrigatorio": "true", "fonte": "perfil do atleta (Tabela 4.1 do Power Profile é por sexo)"}, {"campo": "idade_atleta", "tipo": "manual", "obrigatorio": "false", "fonte": "perfil do atleta", "observacao": "sem isso, não é possível contextualizar um resultado fraco nas colunas 5min/FTP com o declínio etário esperado (nota-0036) — a tabela permanece sem correção por idade de qualquer forma"}]$m34640$::jsonb, $m34641$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-qualidade-de-dado", "tipo": "pre-requisito"}]$m34641$::jsonb,
  $m34642$[]$m34642$::jsonb, $m34643$proposto$m34643$, $m34644$## O que faz

Constrói o perfil de potência de longo prazo do atleta: a MMP Curve (dado real dos melhores esforços por duração) e a PDC (modelo ajustado sobre ela), derivando Pmax, FRC, TTE e Stamina; o Power Profile clássico (Tabela 4.1, 4 durações-índice) e o fenótipo resultante (all-rounder/sprinter/CRI-escalador/perseguidor); o Mapa Fenotípico 2D (Pmax/FTP × FRC/Pmax, com cautela extra por ser uma nota "revisar" no cânone); e a curva de resistência à fadiga (queda de potência de pico fresco vs. após acúmulo de trabalho). Sempre expõe o dado real (MMP) ao lado do modelado (PDC), nunca só o modelo.

## Quando usar

- Ao construir ou atualizar o perfil de longo prazo do atleta (mensal, após acumular histórico suficiente).
- Ao identificar picos de potência de uma sessão de teste dedicada (5s/1min/5min, protocolo da nota-0034) para atualizar o Power Profile.
- Ao gerar recomendações de treino a partir de "pontos fracos" do perfil — sempre filtrando pela relevância ao objetivo do atleta, nunca pela fraqueza numérica isolada.
- Para provas longas (>3h), ao avaliar a resistência à fadiga do atleta comparando potência fresca vs. pós-acúmulo de kJ.

## Passo a passo

1. **Construir a MMP Curve**: melhor potência média real por duração, extraída do histórico (idealmente ≥6 meses). Interpretar mudanças de inclinação como candidatas a transições de sistema energético, e "vales"/inversões locais como artefato normal de dados reais esparsos — nunca como erro de medição (nota-0053, nota-0104).
2. **Ajustar a PDC** (curva de melhor ajuste sobre a MMP) — usar como modelo complementar, sempre expondo a MMP real ao lado (nota-0037, nota-0103).
3. **Derivar Pmax**: maior potência numa volta completa de pedal; aproximar pelo pico de 1s disponível se não houver PDC individualizada (nota-0077).
4. **Derivar FRC** (joules acima do FTP): `potência sustentável acima do FTP = FRC ÷ duração(s)`; potência total = FTP + esse valor (nota-0078).
5. **Derivar TTE**: duração que o atleta sustenta o próprio mFTP — reportar mesmo quando o mFTP for igual ao de outro momento/atleta, pois o TTE pode diferir bastante (nota-0080).
6. **Derivar Stamina**: % de resistência à fadiga sub-FTP prolongada, cauda da PDC além do mFTP; comparar contra a faixa típica de 75-85% (nota-0081).
7. **Mapa Fenotípico** (com cautela extra — nota-0082, status "revisar"): se houver PDC individualizada confiável, calcular Pmax/FTP (eixo X) e FRC/Pmax (eixo Y); sem isso, não calcular — reportar Ausente.
8. **Power Profile**: localizar os melhores W/kg do atleta nas 4 durações-índice (5s→potência neuromuscular, 1min→capacidade anaeróbia, 5min→VO2máx, FTP→limiar de lactato) contra a Tabela 4.1, por sexo (nota-0031, nota-0032). Usar picos de sessão de teste dedicada quando disponível (nota-0034), não picos incidentais.
9. **Classificar o fenótipo** pelo formato resultante: horizontal→all-rounder; descendente (1min>5min)→sprinter; ascendente→CRI/escalador; "V invertido"→perseguidor (checar se os valores realmente refletem esforço máximo antes de concluir "V invertido") (nota-0035). **Camada narrativa opcional** (nota-0200): ao comunicar o fenótipo ao atleta, pode-se traduzi-lo para um dos 6 arquétipos por especialidade — escalador (potência/peso, baixo %gordura), contrarrelogista (potência absoluta, aerodinâmica), velocista (potência neuromuscular/anaeróbia), especialista em clássicas (durabilidade + recuperação repetida), mountain biker (VO2máx + técnica + recuperação rápida), ultraciclista (economia + eficiência de gordura) — sempre como tradução acessível dos mesmos dados quantitativos (MMP/Power Profile), nunca como classificação independente ou substituta.
10. **Resistência à fadiga**: se houver dado de prova longa (>3h) ou sessão com acúmulo de kJ registrado, comparar potência de pico (5min/20min) fresca vs. após o acúmulo; para sprints, calcular a degradação percentual ao longo de ~35s (nota-0124).
11. **Ao comparar recordes/picos >1h**, usar NP em vez de potência média bruta (nota-0105).
12. **Filtrar recomendações pela relevância ao objetivo**: uma "fraqueza" num sistema energético irrelevante à prova-alvo do atleta (ex.: potência neuromuscular fraca num triatleta de estrada) tem prioridade de recomendação baixa, mesmo com confiança estatística alta (nota-0097).
13. **Sinalizar revisão periódica**: se passaram mais de 4-6 semanas desde a última atualização do Power Profile, sinalizar necessidade de retestar (nota-0038).
14. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer número como Medido/Estimado.

## Output

```
{
  "mmp_disponivel": <bool>,
  "profundidade_historico_meses": <float>,
  "pmax_w": <float, null>,
  "frc_j": <float, null>,
  "tte_min": <float, null>,
  "stamina_pct": <float, null>,
  "mapa_fenotipico": {"pmax_ftp": <float, null>, "frc_pmax": <float, null>, "provenance_especifica": "Ausente" },
  "power_profile": {
    "5s_w_kg": <float, null>, "1min_w_kg": <float, null>, "5min_w_kg": <float, null>, "ftp_w_kg": <float, null>,
    "categoria_por_duracao": {"5s": "<texto>", "1min": "<texto>", "5min": "<texto>", "ftp": "<texto>"}
  },
  "fenotipo": "all-rounder" | "sprinter" | "cri-escalador" | "perseguidor" | null,
  "arquetipo_narrativo": "escalador" | "contrarrelogista" | "velocista" | "classicas" | "mtb" | "ultraciclista" | null,
  "resistencia_fadiga": {"queda_5min_pct": <float, null>, "queda_20min_pct": <float, null>, "degradacao_sprint_35s_pct": <float, null>},
  "alertas": [
    "historico_insuficiente_menos_6_meses" | "revisar_power_profile_4_6_semanas" | "fraqueza_irrelevante_ao_objetivo" | "mapa_fenotipico_baixa_confianca" | "power_profile_sem_correcao_etaria_atleta_mais_velho" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0053", "nota-0103", "nota-0037", "nota-0077", "nota-0078", "nota-0080", "nota-0081", "nota-0082", "nota-0031", "nota-0032", "nota-0034", "nota-0124", "nota-0104", "nota-0105", "nota-0097", "nota-0038", "nota-0035", "nota-0036", "nota-0200"]
}
```$m34644$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;