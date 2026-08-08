BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10273$nota-0287$m10273$, $m10274$45 min de ciclismo vigoroso (73% VO2máx) elevam o gasto calórico de recuperação por até 14h — +190 kcal além das 520 kcal do próprio treino$m10274$, $m10275$recuperacao-e-fadiga$m10275$,
  $m10276$contexto$m10276$, $m10277$conceito$m10277$,
  ARRAY[$m10278$diario$m10278$]::text[], '{}'::text[],
  0.6, $m10279$revisar$m10279$, $m10280$Em um estudo com 10 homens jovens que pedalaram por **45 minutos a 73% do VO2máx** (intensidade vigorosa, tipicamente zona de limiar/tempo), o gasto calórico foi medido em câmara metabólica por 24h de recuperação. Resultado: nas **14 horas seguintes** ao treino, os participantes queimaram **190 kcal a mais** do que num dia sedentário equivalente — um "bônus" de recuperação de **37%** somado às 520 kcal já gastas durante a própria sessão de ciclismo.

Esse dado quantifica, para uma sessão específica de ciclismo, o fenômeno geral de EPOC (excesso de consumo de oxigênio pós-exercício, já descrito na nota-0232): sessões vigorosas (não apenas HIIT curto) produzem um efeito metabólico residual mensurável e prolongado (até 14h), que soma um gasto calórico adicional relevante ao gasto direto do treino.

Nota de confiança: resultado de um único estudo pequeno (n=10), condição controlada em câmara metabólica — a magnitude exata (37%, 190 kcal) não deve ser tratada como universal, mas o padrão qualitativo (esforço vigoroso → gasto elevado por várias horas pós-treino) é consistente com a literatura de EPOC mais ampla.

Aplicação ao feedback: ao estimar o gasto energético diário total de um ciclista, sessões vigorosas (ex.: treino de limiar, intervalados) não devem ser contabilizadas apenas pelas calorias durante a atividade — o efeito residual de recuperação pode adicionar dezenas a ~200 kcal nas horas seguintes, relevante para cálculos de balanço energético em dias de treino intenso.$m10280$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10281$nota-0006$m10281$, $m10282$Treino indoor produz dados de potência mais estáveis (menor variabilidade) que treino outdoor$m10282$, $m10283$tipos-de-treino$m10283$,
  $m10284$contexto$m10284$, $m10285$conceito$m10285$,
  ARRAY[$m10286$diario$m10286$]::text[], ARRAY[$m10287$potência-série-temporal$m10287$, $m10288$VI$m10288$]::text[],
  0.75, $m10289$ativo$m10289$, $m10290$Sem as influências externas de vento, subidas/descidas, trânsito e outros ciclistas, o treino em rolo/smart trainer permite manter a potência dentro de uma faixa (zona) de forma muito mais constante do que ao ar livre, onde a potência instantânea oscila bastante mesmo quando o esforço percebido é estável. Isso torna os dados de potência de sessões indoor mais "limpos" — com menor variação momento a momento — o que facilita tanto a execução precisa de intervalos em zonas exatas quanto a análise posterior do arquivo de potência.

Aplicação ao feedback: sessões indoor tendem a apresentar um Índice de Variabilidade (VI = NP/potência média) mais baixo do que sessões outdoor equivalentes em intensidade, simplesmente por causa do ambiente controlado — essa diferença de contexto (indoor vs. outdoor) deve ser considerada antes de interpretar um VI mais alto em treino externo como problema de pacing. (O conceito de VI é definido em detalhe em capítulo posterior sobre potência normalizada.)$m10290$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10291$nota-0007$m10291$, $m10292$Cadência abaixo de 70 rpm em potência de limiar associada a perda de contato com o grupo (estudo de caso)$m10292$, $m10293$tipos-de-treino$m10293$,
  $m10294$direta$m10294$, $m10295$regra-interpretacao$m10295$,
  ARRAY[$m10296$diario$m10296$]::text[], ARRAY[$m10297$cadência$m10297$, $m10298$potência-média$m10298$]::text[],
  0.55, $m10299$revisar$m10299$, $m10300$Estudo de caso de um único atleta (não uma regra fisiológica geral validada): analisando múltiplas corridas em que o ciclista foi "descolado" do pelotão, o treinador identificou um padrão — sempre que a cadência caía abaixo de 70 rpm por mais de 5 minutos enquanto o atleta pedalava na sua potência de limiar, ele perdia contato com o grupo; quando conseguia manter cadência acima de 95 rpm nessa mesma intensidade, conseguia se manter no grupo. A solução aplicada foi trocar a relação de marchas (cassete de 27 dentes em vez de 23) para permitir cadência mais alta em subidas íngremes.

Atenção: esta é uma correlação observada em um atleta específico (N=1), não uma norma fisiológica geral — confiança baixa por ser um caso anedótico apresentado como exemplo, não um achado sistemático. Pode ser útil como hipótese de leitura (cadência muito baixa sustentada em potência de limiar pode sinalizar ineficiência mecânica ou marcha inadequada), mas não deve ser aplicada como regra automática de feedback sem mais evidência do cânone. Marcada para revisão humana por confiança < 0.7.

Aplicação ao feedback: dado o caráter anedótico (N=1) desta observação, não gerar automaticamente uma recomendação de troca de marcha a partir de cadência baixa sustentada em potência de limiar — no máximo, sinalizar como hipótese de baixa confiança para revisão humana, nunca como regra automática de feedback.$m10300$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10301$nota-0039$m10301$, $m10302$Potência ao ar livre é estocástica: pacing deve mirar uma faixa, não um valor exato$m10302$, $m10303$tipos-de-treino$m10303$,
  $m10304$direta$m10304$, $m10305$regra-interpretacao$m10305$,
  ARRAY[$m10306$diario$m10306$]::text[], ARRAY[$m10307$potência-série-temporal$m10307$, $m10308$cadência$m10308$]::text[],
  0.8, $m10309$ativo$m10309$, $m10310$Fora de ambiente controlado (rolo, estrada plana sem vento), a potência instantânea é altamente variável (estocástica) por causa do terreno, vento e outros ciclistas — pode saltar de 500 W para 0 W para 220 W em segundos consecutivos. Por isso, ao interpretar aderência a um intervalo prescrito, não se deve esperar (nem cobrar) que o atleta mantenha um valor exato de potência — o critério correto é permanecer dentro de uma faixa (ex.: 300–320 W a 90 rpm para um intervalo de limiar), evitando cair longe demais por baixo ou ultrapassar muito o teto do esforço prescrito.

Aplicação ao feedback: ao avaliar se um intervalo foi bem executado, comparar a potência (média e distribuição) contra a faixa-alvo prescrita, não contra um único número — desvios pontuais dentro de terreno ondulado ou com vento não indicam necessariamente má execução.$m10310$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;