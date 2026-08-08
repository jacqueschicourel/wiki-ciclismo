BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m709$nota-0101$m709$, $m710$Teste combinado 5min + 20min: esgotar a FRC antes do teste de 20min para refinar a estimativa de FTP e medir potência de VO2max$m710$, $m711$avaliacao-e-testes$m711$,
  $m712$direta$m712$, $m713$protocolo$m713$,
  ARRAY[$m714$mensal$m714$]::text[], ARRAY[$m715$potência-média$m715$, $m716$FTP$m716$]::text[],
  0.75, $m717$ativo$m717$, $m718$Variação do teste padrão de FTP (20 minutos, subtraindo 5% da potência média — já registrado em nota anterior): no mesmo dia de teste, fazer primeiro um esforço máximo de **5 minutos** e, depois de recuperação, o teste de **20 minutos**.

Racional dos autores: o esforço de 5 minutos esgota parcialmente a Capacidade de Reserva Funcional (FRC) do atleta antes do teste de 20 minutos, o que — segundo os autores — torna a estimativa de FTP resultante (20min × 0,95) **mais precisa** (por reduzir a contribuição anaeróbia residual no teste de 20 minutos).

Uso adicional do resultado do teste de 5 minutos: serve como medida da potência de VO2max do atleta. Se esse valor for muito superior à faixa padrão dos Coggan Classic Levels para VO2max (106–120% da FTP) — por exemplo, 150% da FTP — é um indício de que o atleta deveria usar as **iLevels** (zonas individualizadas, já registradas em notas do Cap.3) em vez das zonas clássicas de Coggan como base do treino.

Aplicação ao feedback: ao processar uma sessão de teste que contenha dois esforços máximos estruturados (5min seguido de 20min), o sistema pode aplicar este protocolo combinado em vez do teste de 20min isolado, e usar a razão P5min/FTP resultante como sinal para recomendar zonas clássicas (Coggan) vs. individualizadas (iLevels).$m718$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m719$nota-0127$m719$, $m720$Métodos de teste de campo para CdA (área frontal efetiva) usando medidor de potência: velocidade/potência constante, regressão e elevação virtual$m720$, $m721$avaliacao-e-testes$m721$,
  $m722$contexto$m722$, $m723$protocolo$m723$,
  ARRAY[$m724$mensal$m724$]::text[], ARRAY[$m725$potência-média$m725$, $m726$velocidade$m726$]::text[],
  0.55, $m727$revisar$m727$, $m728$Três métodos de teste de campo (sem túnel de vento) para medir o CdA (área frontal efetiva de arrasto) de um ciclista usando apenas o medidor de potência:

1. **Velocidade/potência constante:** passadas em ambas as direções de um trecho sem vento, a velocidade constante (medindo potência) ou potência constante (medindo velocidade), corrigindo para energia cinética/potencial residual. Método mais simples, mas exige assumir um valor de coeficiente de resistência ao rolamento (Crr).
2. **Regressão:** múltiplas passadas (6-9) em velocidades variadas; ajustar `Potência = a·Velocidade + b·Velocidade³`, onde `a` é proporcional à resistência ao rolamento e `b` é proporcional a ½ × densidade do ar × CdA. Permite separar CdA de Crr e é mais preciso por usar múltiplas medições.
3. **Elevação virtual (Dr. Robert Chung):** o ciclista pedala repetidamente o mesmo trecho de estrada sem restrição de velocidade/potência; os dados de potência e velocidade são usados para resolver o "perfil de elevação aparente", ajustando CdA e Crr até que o perfil calculado fique nivelado (consistente) nas repetições. Não exige percurso perfeitamente plano nem trecho controlado — funciona melhor num curto trajeto "meia-pipa" (subidas moderadas em cada ponta, evitando frenagem).

Precisão: em condições ideais (sem vento significativo, testes de manhã cedo), a reprodutibilidade do CdA medido por esses métodos é **inferior a 2%** — comparável a um túnel de vento.

**Motivo da revisão:** é um protocolo de teste específico do atleta (posição/equipamento), não uma regra de interpretação de dados de treino do Strava — não diretamente aplicável a um produto de feedback baseado em atividades registradas, a menos que o produto ofereça uma funcionalidade dedicada de teste de aerodinâmica.

Aplicação ao feedback: mantido como cânone/contexto; não aplicável à análise retrospectiva de atividades Strava sem uma funcionalidade dedicada de teste de CdA (que exigiria protocolo de coleta específico, não apenas dados históricos).$m728$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m729$nota-0133$m729$, $m730$Cadência ótima (140-160 rpm) para potência máxima em sprint de pista; velocistas devem treinar resistência à fadiga nessa faixa de cadência$m730$, $m731$avaliacao-e-testes$m731$,
  $m732$contexto$m732$, $m733$referencia$m733$,
  ARRAY[$m734$diario$m734$]::text[], ARRAY[$m735$cadência$m735$, $m736$potência-máx$m736$]::text[],
  0.6, $m737$ativo$m737$, $m738$Pesquisa citada (Dr. Jim Martin, Universidade de Utah, em colaboração com o Instituto Australiano do Esporte): velocistas de pista de elite iniciam o "jump" (arrancada) num contrarrelógio voador de 200m exatamente na cadência que produz a potência máxima — além desse ponto, a potência cai continuamente com o aumento de cadência (por causa da relação força-velocidade muscular e da fadiga). Essa cadência ótima de potência máxima em sprint fica tipicamente na faixa de **140-160 rpm**.

Implicação de treino: velocistas devem treinar não só o pico de potência absoluto, mas também a **resistência à fadiga especificamente nessa faixa de cadência muito alta** (140-160 rpm). Uma tática de prova sugerida pela pesquisa: usar marchas maiores nas rodadas classificatórias (vs. rodadas eliminatórias de sprint direto) para permanecer mais tempo próximo da cadência ótima durante o esforço.

Aplicação ao feedback: referência de contexto para caracterizar/avaliar sessões de sprint de pista — cadências de pico na faixa 140-160 rpm em esforços máximos curtos são esperadas/desejáveis para velocistas; cadências de pico muito abaixo dessa faixa em um sprint máximo podem indicar uso de marcha excessivamente grande ou déficit de capacidade neuromuscular em alta cadência.$m738$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m739$nota-0134$m739$, $m740$Ajuste por altitude/pressão atmosférica para comparar objetivamente desempenhos do mesmo atleta em pistas diferentes$m740$, $m741$avaliacao-e-testes$m741$,
  $m742$contexto$m742$, $m743$conceito$m743$,
  ARRAY[$m744$mensal$m744$]::text[], ARRAY[$m745$potência-média$m745$, $m746$tempo-decorrido$m746$]::text[],
  0.55, $m747$ativo$m747$, $m748$Exemplo: um mesmo atleta completou um contrarrelógio de perseguição de 3 km quase 6 segundos mais rápido numa pista em altitude do que ao nível do mar. Ao ajustar os dados pelos efeitos da pressão atmosférica reduzida (que afeta tanto o arrasto aerodinâmico — menor em altitude — quanto a potência aeróbia máxima disponível — menor em altitude), a potência e o tempo previstos ficaram **idênticos** entre as duas provas — ou seja, o desempenho fisiológico real foi equivalente, apesar da diferença de tempo bruto.

Aplicação ao feedback: ao comparar recordes pessoais/tempos do mesmo atleta em locais/altitudes diferentes (informação de localização/elevação já presente no Strava), não comparar tempos brutos diretamente como indicador de mudança de forma física — a altitude local do percurso pode explicar boa parte da diferença. Nota de contexto: o ajuste completo exige modelagem física (densidade do ar, CdA, potência aeróbia vs. altitude) não trivial de implementar sem dados adicionais; mantido como princípio conceitual, não fórmula pronta.$m748$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;