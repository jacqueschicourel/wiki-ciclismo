BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6022$nota-0037$m6022$, $m6023$Power Duration Curve (PDC): curva de melhor ajuste sobre a curva de Potência Média Máxima (conceito introdutório)$m6023$, $m6024$metricas-de-potencia$m6024$,
  $m6025$contexto$m6025$, $m6026$conceito$m6026$,
  ARRAY[$m6027$mensal$m6027$]::text[], ARRAY[$m6028$potência-máx$m6028$]::text[],
  0.75, $m6029$ativo$m6029$, $m6030$A Power Duration Curve (PDC) generaliza o Power Profile: em vez de comparar apenas 4 durações discretas (5s, 1min, 5min, FTP), usa a relação matemática entre tempo até a exaustão e a taxa de trabalho (tanto em exercício aeróbio quanto anaeróbio) para ajustar uma curva de "melhor encaixe" sobre a Curva de Potência Média Máxima do atleta (Mean Maximal Power Curve — os melhores valores reais de potência do atleta para cada duração possível, conceito do Capítulo 6).

Leitura da curva: pontos onde o desempenho real do atleta cai abaixo da PDC ajustada podem indicar (a) que o atleta simplesmente não fez um esforço máximo real naquela duração específica, ou (b) uma fraqueza fisiológica real a trabalhar. A PDC representa o melhor esforço histórico do atleta (possivelmente em pico de forma) — o atleta pode não conseguir replicar esse nível na forma atual, então essas "lacunas" devem ser revisitadas quando ele estiver mais em forma. Pontos onde a PDC cruza as linhas de categoria do Power Profile (Tabela 4.1) indicam onde a resistência à fadiga precisa melhorar.

Nota: este é o conceito introdutório da PDC; o modelo completo (com Potência Crítica, FRC — capacidade de trabalho anaeróbio finita — e Pmax) é desenvolvido em detalhe no Capítulo 8 do livro ("Shifting to the Power Duration Model") — por isso `aplicacao: contexto` aqui.$m6030$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6031$nota-0045$m6031$, $m6032$FRC (Functional Reserve Capacity): trabalho total possível acima do FTP; iLevels reais podem divergir muito dos níveis clássicos$m6032$, $m6033$metricas-de-potencia$m6033$,
  $m6034$direta$m6034$, $m6035$conceito$m6035$,
  ARRAY[$m6036$mensal$m6036$]::text[], ARRAY[$m6037$potência-máx$m6037$, $m6038$FTP$m6038$]::text[],
  0.75, $m6039$ativo$m6039$, $m6040$FRC (Functional Reserve Capacity) é a quantidade total de trabalho que um ciclista consegue realizar acima do seu FTP antes da exaustão — em teoria, é totalmente consumida quando o atleta pedala até a falha numa intensidade supra-FTP. É o conceito fisiológico por trás dos iLevels 5 (FTP/FRC, esforços "tweener"), 6 (FRC pura) e 7a (Pmax/FRC).

Exemplo concreto do livro mostrando por que os níveis clássicos (percentuais fixos de FTP) podem subestimar drasticamente a demanda real para atletas com FRC/capacidade anaeróbia elevada: para Joe Athlete (FTP = 290 W), o Nível 6 clássico (Capacidade Anaeróbia, 121–150% do FTP) prescreveria intervalos de 30s–2min entre 351–435 W. Mas ao usar o modelo Potência-Duração (WKO4) ajustado aos dados reais de Joe, seu iLevel 6 real exige 653–675 W para um esforço de 28 segundos e 435–449 W para 1:33 — muito acima da faixa clássica para a duração mais curta.

Aplicação ao feedback: quando houver dados suficientes para modelar a curva Potência-Duração individual do atleta (não apenas o FTP), os alvos de intensidade para esforços curtos e intensos (Níveis 6-7 clássicos) podem estar significativamente errados se calculados apenas como percentual fixo do FTP — isso é especialmente relevante para atletas com fenótipo mais anaeróbio/sprinter (ver nota-0035).$m6040$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6041$nota-0048$m6041$, $m6042$Checklist antes de analisar dados: taxa de amostragem máxima, zerar o medidor, visualizar sem suavização ou com 5 s$m6042$, $m6043$metricas-de-potencia$m6043$,
  $m6044$direta$m6044$, $m6045$protocolo$m6045$,
  ARRAY[$m6046$diario$m6046$]::text[], ARRAY[$m6047$potência-série-temporal$m6047$]::text[],
  0.8, $m6048$ativo$m6048$, $m6049$Checklist de preparação dos dados antes de qualquer análise mais profunda: (1) taxa de amostragem do medidor de potência na menor granularidade possível (maior taxa de gravação); (2) display do head unit em média de 3 segundos; (3) medidor zerado antes de começar; (4) medidor de potência calibrado; (5) ao visualizar os gráficos no software de análise, preferir dado bruto sem suavização (smoothing) ou, no máximo, suavização de 5 segundos — suficiente para reduzir ruído sem esconder picos/vales reais; (6) remover quaisquer picos de dado espúrios (ex.: pico de 2.000+ W quando o atleta nunca passou de 1.000 W) antes de interpretar a atividade.

Esta é a etapa de "arrumação da casa" recomendada antes de qualquer interpretação de distribuição de potência, FC, cadência ou curva de potência média máxima.

Aplicação ao feedback: antes de interpretar qualquer métrica derivada (NP, distribuição de zonas, curva de potência média máxima) de uma atividade do Strava, verificar se a fonte de dados tem qualidade suficiente (taxa de gravação alta, sem picos espúrios não tratados) — dados de baixa qualidade devem ser sinalizados como limitação antes de tirar conclusões sobre a sessão.$m6049$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m6050$nota-0050$m6050$, $m6051$As zonas de potência (em watts) devem ser recalculadas sempre que o FTP mudar — não usar limites antigos com FTP novo$m6051$, $m6052$metricas-de-potencia$m6052$,
  $m6053$direta$m6053$, $m6054$regra-interpretacao$m6054$,
  ARRAY[$m6055$semanal$m6055$, $m6056$mensal$m6056$]::text[], ARRAY[$m6057$potência-média$m6057$, $m6058$FTP$m6058$, $m6059$tempo-em-zona$m6059$]::text[],
  0.85, $m6060$ativo$m6060$, $m6061$Como as zonas de treino (Tabela 3.1) são definidas como percentual do FTP, os limites em watts absolutos mudam sempre que o FTP do atleta muda — usar limites de watts desatualizados classifica erradamente a intensidade de uma sessão. Exemplo do livro: em janeiro, com FTP = 200 W, o Nível 3 (Tempo, 76–90%) correspondia a 152–180 W. Em junho, com FTP elevado para 260 W, o Nível 3 passa a ser 197–234 W — e a faixa antiga (152–180 W) que antes era Tempo agora corresponde ao Nível 2 (Endurance) do atleta mais em forma.

Aplicação ao feedback: sempre usar o FTP mais recente e válido do atleta (não um valor desatualizado) para calcular os limites de zona em watts antes de classificar tempo-em-zona de qualquer atividade — recalcular a cada atualização de FTP (ver nota-0021 sobre frequência de reteste).$m6061$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;