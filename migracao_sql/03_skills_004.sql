BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m33986$skill-entrega-curadoria-diaria$m33986$, $m33987$skill-0023$m33987$, $m33988$Curadoria diária — selecionar os 3-4 pontos acionáveis do output técnico de 1 sessão para compor o feedback do atleta$m33988$,
  $m33989$entrega-feedback$m33989$, $m33990$curador$m33990$,
  '{}'::text[],
  $m33991$dinâmica = mínimo das confianca_herdada de todas as skills técnicas (skill-0001 a skill-0022) cujo campo entrou em algum ponto selecionado nesta sessão específica — nunca um valor fixo, porque depende de quais skills foram de fato acionadas$m33991$, $m33992$sem o arquivo de análise técnica completo da sessão (as 22 skills já aplicadas por skill-analisar-treino-lrf) → nada a curar, reportar Ausente. Se menos de 2 das 22 skills tiverem provenance diferente de Ausente (sessão com dado bruto muito incompleto), não forçar 3-4 pontos artificiais — reportar só 1 ponto avisando da baixa completude dos dados, citando skill-gerais-qualidade-de-dado.$m33992$,
  $m33993$[{"campo": "analise_tecnica_completa", "tipo": "calculado", "obrigatorio": "true", "fonte": "arquivo de análise gerado pelo pipeline principal (skill-analisar-treino-lrf, as 22 skills do cânone aplicadas a 1 sessão)"}, {"campo": "perfil_elevacao_sessao", "tipo": "bruto", "obrigatorio": "false", "fonte": "ganho de elevação total e, se disponível, correlação qualitativa entre trechos de subida/descida e zona/potência (skill-classificacao-contexto-atividade, skill-gerais-checklist-pos-treino)", "observacao": "sem isso, os pontos ficam sem a correlação com a altimetria — não bloqueia a curadoria, só perde uma forma de tornar o número mais concreto pro atleta"}, {"campo": "pontos_ja_comunicados_recentes", "tipo": "manual", "obrigatorio": "false", "fonte": "últimos feedbacks diários já enviados ao atleta", "observacao": "sem isso, risco de repetir o mesmo tipo de ponto vários dias seguidos (ex.: sempre 'fadiga na 2ª metade') sem perceber — sinalizar a ausência, não bloquear a curadoria por causa disso"}]$m33993$::jsonb, $m33994$[{"id": "skill-gerais-pmc", "tipo": "pre-requisito"}, {"id": "skill-gerais-tss-sessao", "tipo": "pre-requisito"}, {"id": "skill-gerais-qualidade-de-dado", "tipo": "pre-requisito"}, {"id": "skill-gerais-ambiente-termico", "tipo": "pre-requisito"}, {"id": "skill-gerais-checklist-pos-treino", "tipo": "pre-requisito"}, {"id": "skill-gerais-fadiga-carga-avancada", "tipo": "pre-requisito"}, {"id": "skill-classificacao-tipo-de-sessao", "tipo": "pre-requisito"}, {"id": "skill-classificacao-contexto-atividade", "tipo": "pre-requisito"}, {"id": "skill-entrega-redacao-atleta", "tipo": "consumida-por"}]$m33994$::jsonb,
  $m33995$[]$m33995$::jsonb, $m33996$proposto$m33996$, $m33997$## O que faz

Lê o arquivo de análise técnica completo de **1 sessão** (as 22 skills do cânone já aplicadas por `skill-analisar-treino-lrf`) e seleciona, no máximo, os 3-4 pontos realmente acionáveis/relevantes daquele treino específico — sem reescrever nada ainda, só decide **o quê** vale a pena dizer e **de onde** vem. É a ponte entre o motor técnico (rigoroso, completo, feito para auditoria) e a redação final (curta, sem jargão, feita para o atleta).

## Quando usar

- Sempre que o atleta pedir/receber feedback diário sobre uma sessão recém-analisada.
- Depois que `skill-analisar-treino-lrf` já rodou as 22 skills e gerou o arquivo de análise completo — nunca antes, nunca em paralelo (esta skill só lê o resultado, não recalcula nada).
- Antes de `skill-entrega-redacao-atleta`, que transforma a lista curada aqui em mensagem final.

## Passo a passo

1. **Ler o arquivo de análise técnica completo** da sessão: a tabela-resumo de auditoria (22 linhas) e os campos de output de cada skill.
2. **Filtrar candidatos**: manter só skills com `provenance` diferente de `Ausente` **e** cujo resultado seja um desvio real do neutro/esperado — não um "tudo normal, nada a dizer" (ex.: `skill-0011` só entra se houve alerta de calor/decoupling; `skill-0012` só entra se houve matches>0; `skill-0006` só entra se a duração cruzou o limiar de sugestão de carboidrato).
3. **Priorizar por categoria, nesta ordem fixa**:
   a. **Alerta de segurança/saúde** (calor extremo, hipotermia, overreaching, imunossupressão) — se existir, sempre entra, sempre em 1º lugar.
   b. **Carga do dia** (TSS/IF ou classificação do tipo de sessão) — 1 ponto, quase sempre presente.
   c. **Padrão observado dentro da sessão** (fadiga na 2ª metade, VI alto, decoupling, matches de esforço) — só o achado mais forte, nunca mais de 1.
   d. **Sugestão prática pra próxima sessão/recuperação** (nutrição, hidratação, repouso) — só se for de fato acionável antes do próximo treino.
4. **Limitar a no máximo 4 pontos** (menos é aceitável, mais nunca). Em caso de empate entre candidatos da mesma categoria, priorizar o de `provenance` mais forte (Medido/Calculado > Estimado) e o de maior relevância prática pro dia seguinte.
5. **Nunca selecionar um ponto cuja única substância seja `Ausente`** (ex.: "não consegui calcular CTL/TSB hoje") — isso é conteúdo de auditoria pro treinador, não motivo de frase pro atleta. Exceção: se a `condicao_nao_calculavel` desta própria skill disparar (ver frontmatter), aí sim reportar isso como o único ponto.
6. **Marcar quais métricas do `resumo_tecnico` são de fácil leitura pro atleta** (FC, IF, zonas de potência/FC, FTP, cadência — ele já tem intuição própria sobre elas) vs. agregadas/abstratas (TSS, NP, VI, CTL/ATL/TSB, W/kg, kJ — precisam de tradução na camada de redação). Isso é o que permite à `skill-entrega-redacao-atleta` decidir quais números citar direto e quais traduzir.
7. **Anotar a correlação com a altimetria sempre que disponível** (`perfil_elevacao_sessao`): se um achado de zona/potência/FC coincidir com um trecho de subida ou descida, registrar isso explicitamente no `resumo_tecnico` (ex.: "zona 5-7 concentrada nos trechos de subida, total de X m de ganho") — é a forma mais concreta de ancorar o número na experiência que o atleta lembra de ter vivido.
8. **Registrar a rastreabilidade de cada ponto escolhido**: skill de origem + campo exato do output — isso é o que permite à próxima camada (redação) e à auditoria de rastreabilidade final apontarem a frase final de volta à fonte técnica.
9. **Checar a condição de não-calculável** (ver frontmatter) antes de devolver a lista.

## Output

```
{
  "pontos_selecionados": [
    {
      "ordem": <int, 1-4>,
      "categoria": "alerta_seguranca" | "carga_do_dia" | "padrao_da_sessao" | "sugestao_pratica",
      "resumo_tecnico": "<1 frase técnica, ainda sem tradução pro atleta, incluindo correlação com altimetria quando houver>",
      "metricas_facil_leitura": ["fc" | "if" | "zonas_potencia" | "zonas_fc" | "ftp" | "cadencia", "..."],
      "fonte_skill": "skill-00XX",
      "fonte_campo": "<campo do output daquela skill>"
    }
  ],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Ausente ou se a sessão teve completude baixa>",
  "notas_citadas": []
}
```$m33997$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;