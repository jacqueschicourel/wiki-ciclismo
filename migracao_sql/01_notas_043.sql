BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5669$nota-0022$m5669$, $m5670$Os sete níveis clássicos de treino por potência de Coggan (% FTP, % FTHR, RPE, durações típicas)$m5670$, $m5671$metricas-de-potencia$m5671$,
  $m5672$direta$m5672$, $m5673$referencia$m5673$,
  ARRAY[$m5674$diario$m5674$, $m5675$semanal$m5675$, $m5676$mensal$m5676$]::text[], ARRAY[$m5677$potência-média$m5677$, $m5678$FTP$m5678$, $m5679$FC (média/máx)$m5679$, $m5680$tempo-em-zona$m5680$]::text[],
  0.95, $m5681$ativo$m5681$, $m5682$Tabela 3.1 do livro (Coggan's Classic Training Levels) — sete níveis de treino definidos como percentual do FTP (Functional Threshold Power) e do FTHR (frequência cardíaca no limiar funcional), com RPE (escala Borg CR10, 0–10) e durações típicas:

| Nível | Descrição | % FTP | % FTHR | RPE | Duração contínua típica | Duração típica de intervalo |
|---|---|---|---|---|---|---|
| 1 | Active Recovery (recuperação ativa) | <55 | <68 | <2 | 30–90 min | N/A |
| 2 | Endurance | 56–75 | 69–83 | 2–3 | 60–300 min | N/A |
| 3 | Tempo | 76–90 | 84–94 | 3–4 | 60–180 min | N/A |
| 4 | Lactate Threshold (limiar) | 91–105 | 95–105 | 4–5 | N/A | 8–30 min |
| 5 | VO2max | 106–120 | >106 | 6–7 | N/A | 3–8 min |
| 6 | Anaerobic Capacity | 121–150 | N/A | >7 | N/A | 30 s–3 min |
| 7 | Neuromuscular Power | N/A | Maximal | Maximal | N/A | <30 s |

Notas do próprio livro sobre a tabela: os percentuais de FTP/FTHR referem-se à potência/FC médias no limiar funcional; acima do Nível 4 a FC deixa de ser um guia confiável (esforços curtos demais para a FC estabilizar), por isso as colunas de %FTHR ficam "N/A" nos níveis 6 e 7.

Exemplo de cálculo (Tabela 3.4 do livro) para um atleta com FTP = 290 W: Nível 1 = 1–160 W, Nível 2 = 161–218 W, Nível 3 = 219–261 W, Nível 4 = 262–305 W, Nível 5 = 306–348 W, Nível 6 = 349–435 W, Nível 7 = sem teto definido (esforço máximo). Fórmula geral: limite do nível = FTP × percentual (ex.: 290 × 0,55 = 159,5 ≈ 160 W).

Aplicação ao feedback: dado o FTP do atleta e o tempo-em-zona/potência média de uma sessão, classificar a sessão (ou trechos dela) no nível correspondente permite interpretar o tipo de estímulo fisiológico predominante (ver nota-0023 sobre adaptações esperadas por nível).$m5682$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5683$nota-0026$m5683$, $m5684$Modelo de Potência Crítica (CP): protocolo básico e relação com o FTP$m5684$, $m5685$metricas-de-potencia$m5685$,
  $m5686$direta$m5686$, $m5687$protocolo$m5687$,
  ARRAY[$m5688$mensal$m5688$]::text[], ARRAY[$m5689$potência-máx$m5689$]::text[],
  0.75, $m5690$ativo$m5690$, $m5691$Protocolo resumido do modelo de Potência Crítica (Critical Power, CP), da literatura científica: realizar uma série de esforços máximos ("all-out") de curta duração, entre 3 e 30 minutos cada, registrando o trabalho total realizado em cada um (em joules). Plotar o trabalho total (eixo Y) contra a duração do esforço em segundos (eixo X) e ajustar uma reta aos pontos — a inclinação (slope) dessa reta é a Potência Crítica.

Quando o protocolo segue as recomendações da literatura original (duração dos esforços dentro da faixa 3–30 min), o valor de CP obtido é essencialmente equivalente ao FTP. Se os esforços testados forem curtos demais, a CP calculada fica mais alta que o FTP real, superestimando a verdadeira intensidade máxima de estado estável metabólico (medida por lactato sanguíneo, resposta hormonal, ventilação).

Aplicação: o paradigma de potência crítica também permite diferenciar se uma melhora de performance veio de ganho de função anaeróbia, aeróbia, ou ambas — útil para planejar o foco do treino seguinte. O modelo completo (com FRC — capacidade de trabalho anaeróbio finita) é aprofundado no Capítulo 8 do livro (modelo Potência-Duração) — esta nota cobre a introdução do conceito feita no Capítulo 3.

Aplicação ao feedback: quando o atleta tiver dados de múltiplos esforços máximos de curta duração (3-30min) num período recente, usar o modelo de Potência Crítica como validação cruzada do FTP estimado por outros métodos — grandes divergências entre CP e FTP testado podem indicar teste de FTP mal executado ou esforços de CP fora da faixa de duração recomendada.$m5691$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5692$nota-0027$m5692$, $m5693$mFTP: FTP modelado por software (ex. WKO4) e risco de sub/superestimação por janela de 90 dias$m5693$, $m5694$metricas-de-potencia$m5694$,
  $m5695$direta$m5695$, $m5696$regra-interpretacao$m5696$,
  ARRAY[$m5697$mensal$m5697$]::text[], ARRAY[$m5698$potência-máx$m5698$, $m5699$FTP$m5699$]::text[],
  0.8, $m5700$ativo$m5700$, $m5701$Alguns softwares de análise de potência (ex.: TrainingPeaks WKO4) calculam um FTP modelado ("modeled FTP", mFTP) a partir do modelo Potência-Duração ajustado aos dados de potência do atleta, sem exigir teste formal. É uma estimativa dependente da qualidade, quantidade e atualidade dos dados que a alimentam — pode ser bastante precisa em alguns casos e bem imprecisa em outros, por isso os autores recomendam usá-la apenas como mais um ponto de triangulação, junto com os outros métodos (não como substituto do teste).

Armadilha específica do mFTP no WKO4: por padrão, o modelo usa uma janela móvel dos últimos 90 dias de dados. Consequências práticas para a interpretação: (1) se o atleta não fez nenhum esforço realmente forte nos últimos 90 dias, o mFTP tende a ficar subestimado; (2) se um esforço de referência "sair" da janela de 90 dias (ficar velho demais), o mFTP pode cair de forma abrupta e enganosa em um único dia, sem que a fitness real do atleta tenha piorado.

Aplicação ao feedback: uma queda repentina de mFTP não deve ser automaticamente lida como perda de forma — verificar primeiro se não é efeito da janela de 90 dias "perdendo" um esforço de referência antigo.$m5701$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;