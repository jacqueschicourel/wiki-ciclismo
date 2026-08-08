BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34845$skill-gerais-tss-sessao$m34845$, $m34846$skill-0002$m34846$, $m34847$TSS por sessão — cálculo completo (NP → VI → IF → TSS) a partir de potência bruta$m34847$,
  $m34848$metricas-de-potencia$m34848$, $m34849$calculadora$m34849$,
  ARRAY[$m34850$nota-0059$m34850$, $m34851$nota-0060$m34851$, $m34852$nota-0061$m34852$, $m34853$nota-0062$m34853$, $m34854$nota-0012$m34854$, $m34855$nota-0132$m34855$]::text[],
  $m34856$0.65$m34856$, $m34857$sem stream de potência do dispositivo (has_device_watts=false) → NP real (nota-0059) não é calculável — ver fallback_potencia_estimada abaixo antes de reportar Ausente. Menos de 30s de dados válidos de potência → NP não é interpretável (nota-0059 exige janela ≥30s); reportar Ausente, nunca um NP calculado sobre janela menor. Taxa de gravação reduzida/'smart recording' detectada → reportar NP/VI como Estimado, nunca Medido, com a ressalva da nota-0012. Atividade de pista ou com trechos longos sem pedalada → é obrigatório recortar esses trechos antes de calcular (nota-0132); se não for possível identificar/recortar os trechos parados, reportar TSS como Estimado (provavelmente inflado). Sem FTP válido do atleta na data da atividade (Calculadora FTP #8, fora do escopo desta skill) → IF e TSS ficam Ausentes; NP e VI ainda podem ser Medidos (não dependem de FTP).$m34857$,
  $m34858$[{"campo": "potencia_serie_temporal", "tipo": "bruto", "obrigatorio": "true", "fonte": "Strava: stream de potência da atividade (has_device_watts=true)", "observacao": "sem medidor real, cai no fallback_potencia_estimada (average_watts da plataforma) — o tipo passa a ser 'estimado'"}, {"campo": "ftp_vigente", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-gerais-ftp-e-zonas (FTP vigente na data da atividade)"}, {"campo": "qualidade_dado_flags", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-qualidade-de-dado (sinalização de viés/picos espúrios antes do cálculo)"}, {"campo": "zona_fc_sessao", "tipo": "calculado", "obrigatorio": "false", "fonte": "skill-gerais-zonas-fc (para cruzar o IF implícito com a intensidade por FC, quando o fallback de potência estimada é usado)"}]$m34858$::jsonb, $m34859$[{"id": "skill-gerais-ftp-e-zonas", "tipo": "pre-requisito"}, {"id": "skill-gerais-qualidade-de-dado", "tipo": "pre-requisito"}, {"id": "skill-gerais-pmc", "tipo": "consumida-por"}, {"id": "skill-classificacao-tipo-de-sessao", "tipo": "consumida-por"}]$m34859$::jsonb,
  $m34860$[]$m34860$::jsonb, $m34861$proposto$m34861$, $m34862$## O que faz

Calcula a cadeia completa de métricas de intensidade/carga de uma única sessão a partir da série bruta de potência: Potência Normalizada (NP) → Variability Index (VI, sinal secundário) → Intensity Factor (IF) → TSS (Training Stress Score). É a skill de base que `skill-gerais-pmc` (CTL/ATL/TSB) e qualquer skill de classificação de sessão/semana precisam consumir — nenhuma delas deve recalcular TSS por conta própria.

## Quando usar

- Sempre que houver uma atividade nova do Strava com stream de potência do dispositivo, antes de qualquer leitura de carga diária/semanal.
- Como pré-requisito obrigatório de `skill-gerais-pmc` — a série diária de TSS que alimenta o EWMA de CTL/ATL deve vir desta skill, não de um cálculo ad-hoc.
- Ao investigar se o FTP cadastrado do atleta está desatualizado (IF alto em esforço de ~1h).

## Passo a passo

1. **Confirmar dado de entrada.** Verificar `has_device_watts` da atividade. Se `false`, checar o fallback (`fallback_potencia_estimada` no frontmatter) antes de reportar Ausente — se a plataforma tiver uma potência média calculada, seguir com `NP ≈ potência_média`, provenance Estimado, e os passos 5-8 abaixo normalmente (pulando o passo 4, já que não há série pra calcular NP real).
2. **Checar qualidade da gravação.** Se a atividade foi gravada em "smart recording" ou com taxa reduzida (menos de ~1 registro/segundo), sinalizar essa limitação (nota-0012) — o resultado final não poderá ser reportado como Medido.
3. **Recortar trechos sem pedalada.** Especialmente relevante em pista/critérium/treino intermitente: remover da série os trechos em que o atleta não estava pedalando ativamente (potência ~0 prolongado) antes de qualquer cálculo (nota-0132). Guardar o tempo efetivamente pedalado (s) separado do tempo decorrido total.
4. **Calcular NP** sobre a série já recortada: (a) média móvel de 30s da potência ao longo de todo o trecho; (b) elevar cada valor da média móvel à 4ª potência; (c) calcular a média de todos esses valores; (d) extrair a raiz quarta (nota-0059). Exige ≥30s de dados válidos — abaixo disso, não calcular, reportar Ausente.
5. **Calcular VI = NP ÷ potência-média** do mesmo trecho recortado (nota-0060). Comparar à Tabela 7.1 (faixas por tipo de prova) como sinal secundário — não bloqueia o cálculo de TSS, é informativo.
6. **Calcular IF = NP ÷ FTP** (nota-0061), usando o FTP vigente do atleta **na data da atividade**, não necessariamente o FTP atual do perfil.
7. **Calcular TSS = [(s × NP × IF) ÷ (FTP × 3.600)] × 100**, onde s é o tempo efetivamente pedalado em segundos (nota-0062).
8. **Aplicar o detector de FTP desatualizado:** se IF > 1,05 numa prova de aproximadamente 1h de duração, sinalizar suspeita de FTP desatualizado (nota-0061) — não ajustar o FTP automaticamente, apenas sinalizar.
9. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer número como Medido/Estimado.

## Output

```
{
  "activity_id": "<string>",
  "data": "AAAA-MM-DD",
  "duracao_pedalada_s": <int>,
  "np_w": <float>,
  "potencia_media_w": <float>,
  "vi": <float>,
  "vi_faixa_esperada": "<texto, ex.: 'prova de estrada com subidas: 1,20-1,35' | null se tipo de prova desconhecido>",
  "ftp_usado_w": <float>,
  "if": <float>,
  "tss": <float>,
  "alertas": [
    "ftp_provavelmente_desatualizado (IF>1,05 em ~1h)" | "gravacao_taxa_reduzida" | "trechos_sem_pedalada_nao_recortados" | "np_aproximado_por_media_sem_stream_real" | "divergencia_com_zona_fc" | null
  ],
  "provenance": "Calculado" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente — se Estimado por fallback de potência média, citar as duas fontes de incerteza (potência estimada + FTP estimado, se aplicável)>",
  "notas_citadas": ["nota-0059", "nota-0060", "nota-0061", "nota-0062", ...]
}
```

O `tss` deste output é a entrada diária que `skill-gerais-pmc` espera (somar todas as sessões do mesmo dia antes de rodar o EWMA).$m34862$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;