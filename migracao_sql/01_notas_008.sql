BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1116$nota-0235$m1116$, $m1117$Protocolo do teste de Wingate (30s all-out em cicloergômetro): fórmulas de potência pico, potência relativa e fadiga anaeróbia, com exemplo numérico completo e tabela de percentis$m1117$, $m1118$avaliacao-e-testes$m1118$,
  $m1119$direta$m1119$, $m1120$protocolo$m1120$,
  ARRAY[$m1121$diario$m1121$]::text[], ARRAY[$m1122$potência-máx$m1122$, $m1123$potência-média$m1123$]::text[],
  0.8, $m1124$ativo$m1124$, $m1125$O **teste de Wingate** é o protocolo padrão-ouro para avaliar potência e capacidade anaeróbia em cicloergômetro — diretamente aplicável a ciclistas por usar a própria bicicleta estacionária como instrumento.

**Protocolo:**
1. Aquecimento de 3-5 minutos.
2. O atleta começa a pedalar o mais rápido possível, sem resistência.
3. Em até 3 segundos, aplica-se uma resistência fixa no volante: **0,075 kg por kg de massa corporal** (ex.: atleta de 70 kg → 5,25 kg de resistência); para atletas de potência/sprint, a resistência pode subir para 0,10-0,12 kg/kg.
4. O atleta pedala "all-out" (esforço máximo) por **30 segundos contínuos**, com as revoluções do volante registradas em intervalos de 5 segundos.

**Métricas calculadas (exemplo: homem de 73,3 kg, resistência 5,5 kg, revoluções por intervalo de 5s: 12,10,8,7,6,5):**

- **Potência Pico (PP)** = Força × Distância ÷ Tempo, medida no intervalo de 5s mais alto (tipicamente o primeiro). No exemplo: PP = 776,8 W. Reflete a capacidade do sistema fosfagênio (ATP-PCr).
- **Potência Pico Relativa (RPP)** = PP ÷ massa corporal. No exemplo: 776,8 ÷ 73,3 = **10,6 W/kg**.
- **Fadiga Anaeróbia (AF)** = (PP mais alta − PP mais baixa) ÷ PP mais alta × 100. No exemplo: (776,8 − 323,7) ÷ 776,8 × 100 = **58,3%** de queda de potência ao longo dos 30s — reflete a capacidade glicolítica/resistência à fadiga anaeróbia.
- **Trabalho Anaeróbio (AW)** = Força × distância total percorrida nos 30s. No exemplo: **15,5 kJ** — trabalho total acumulado.

**Tabela de percentis de referência (adultos jovens fisicamente ativos, Maud & Schultz 1989):**

| Percentil | Potência Média (H) | Potência Média (M) | Potência Pico (H) | Potência Pico (M) |
|---|---|---|---|---|
| 90 | 8,24 W/kg | 7,31 W/kg | 10,89 W/kg | 9,02 W/kg |
| 50 | 7,44 W/kg | 6,39 W/kg | 9,22 W/kg | 7,65 W/kg |
| 10 | 5,98 W/kg | 5,25 W/kg | 7,06 W/kg | 5,98 W/kg |

Aplicação ao feedback: se o atleta realizar um esforço "all-out" de ~30 segundos em terreno plano/trainer registrado no Strava, o produto pode extrair potência-máx (proxy de PP, idealmente a média dos primeiros 5s do esforço, não o pico instantâneo de 1s) e potência-média dos 30s completos (proxy de capacidade glicolítica) e calcular a Potência Pico Relativa (W/kg) e a Fadiga Anaeróbia (queda percentual de potência entre o início e o fim do esforço) para posicionar o atleta contra as normas de percentil acima — uma medida complementar ao FTP/Curva de Potência que foca especificamente em capacidade anaeróbia pura, útil para ciclistas de pista, BMX, ou provas com arrancadas decisivas.$m1125$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1126$nota-0245$m1126$, $m1127$FCmáx prevista por idade (três fórmulas: 220−idade; Tanaka 208−0,7×idade; Gellish 206,9−0,67×idade) e dois métodos para calcular zona de treino por FC (Percentage Method vs. Karvonen/HRR)$m1127$, $m1128$avaliacao-e-testes$m1128$,
  $m1129$direta$m1129$, $m1130$protocolo$m1130$,
  ARRAY[$m1131$diario$m1131$, $m1132$semanal$m1132$]::text[], ARRAY[$m1133$FC (média/máx)$m1133$]::text[],
  0.7, $m1134$ativo$m1134$, $m1135$McArdle apresenta três fórmulas concorrentes para estimar a FCmáx prevista por idade, cada uma com desvio-padrão significativo (o erro individual de ±10 b·min⁻¹ é citado como pouco relevante para prescrição de treino em pessoas saudáveis, mas relevante para interpretação individual):

1. **Clássica (220 − idade):** a mais usada popularmente, mas com viés documentado — superestima FCmáx em pessoas <40 anos e subestima em pessoas >40 anos.
2. **Gellish et al. 2007 (206,9 − 0,67 × idade):** ajuste longitudinal que corrige o viés da fórmula clássica; desvio-padrão de ±5 a ±8 b·min⁻¹, independente de sexo, IMC e FC de repouso. Exemplo: para 30 anos, FCmáx = 206,9 − (0,67×30) = 187 b·min⁻¹.
3. **Tanaka et al. 2001 (208 − 0,7 × idade):** usada como base do método de Karvonen no texto (ver abaixo).

Para calcular a **zona de treino (training-sensitive zone)** a partir da FCmáx, o livro descreve dois métodos:

**Método 1 — Percentage Method (percentual direto de FCmáx):** limite inferior (LLTHR) = FCmáx × 70% (60% para >60 anos); limite superior (ULTHR) = FCmáx × 90% (80% para >60 anos). Exemplo (homem, 55 anos, FCmáx=170): LLTHR = 170×0,70 = 119 b·min⁻¹; ULTHR = 170×0,90 = 153 b·min⁻¹.

**Método 2 — Karvonen / Frequência Cardíaca de Reserva (HRR):** usa a diferença entre FCmáx e FC de repouso (FCR). LLTHR = (FCmáx − FCrepouso) × 0,50 + FCrepouso; ULTHR = (FCmáx − FCrepouso) × 0,85 + FCrepouso. O método de Karvonen produz valores de zona **mais altos** que o Percentage Method para a mesma pessoa. Exemplo (homem, 55 anos, FCrepouso=60, FCmáx=170 via Tanaka): LLTHR = (170−60)×0,50+60 = 115 b·min⁻¹; ULTHR = (170−60)×0,85+60 = 154 b·min⁻¹.

Nota de ajuste para natação/atividades de membros superiores: FCmáx nessas modalidades é, em média, ~13 b·min⁻¹ menor que em corrida/ciclismo (não aplicável a ciclismo, mas registrado para diferenciação de contexto).

**Nota de reconciliação (2026-08-02, achado de auditoria adversarial):** o Percentage Method recebe, na fonte, um ajuste explícito para atletas >60 anos (70/90% cai para 60/80%), enquanto o método de Karvonen usa os mesmos coeficientes fixos (0,50/0,85) para qualquer idade — à primeira vista parece uma omissão do método de Karvonen. Busca externa confirma que essa assimetria é uma característica bem documentada da fisiologia do exercício, não uma lacuna da fonte: o %FCR (Karvonen/HRR) é fisiologicamente equivalente ao %VO2 de reserva (%VO2R) de forma praticamente constante — Swain & Leutholtz (1997) e replicações posteriores relatam correlação de r≈0,99 entre %FCR e %VO2R, ampla e independentemente de idade, condicionamento e sexo. Já o %FCmáx (Percentage Method) diverge do %VO2máx de forma sistemática conforme a idade e o nível de condicionamento do indivíduo — por isso a fonte aplica uma correção adicional só a esse método para atletas mais velhos. Ou seja: o método de Karvonen já é, por construção, mais robusto a variação de idade, então não precisa (nem faz sentido pedir) o mesmo tipo de correção adicional que o Percentage Method exige. Reforça a recomendação já dada acima de preferir Karvonen ao Percentage Method quando a FC de repouso estiver disponível.

Aplicação ao feedback: como o produto tem acesso direto a FC média/máx via Strava e (potencialmente) idade/FC de repouso do perfil do atleta, essas fórmulas permitem calcular zonas de treino por FC automaticamente. Prioridade sugerida: usar Gellish (206,9−0,67×idade) em vez da fórmula clássica (220−idade) por menor viés sistemático, e preferir o método de Karvonen (HRR) sobre o Percentage Method quando a FC de repouso do atleta estiver disponível, pois produz zonas mais individualizadas. Diferença notável: a mesma pessoa terá LLTHR/ULTHR mais altos pelo método de Karvonen do que pelo Percentage Method — o produto não deve misturar os dois métodos ao comparar zonas ao longo do tempo.$m1135$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;