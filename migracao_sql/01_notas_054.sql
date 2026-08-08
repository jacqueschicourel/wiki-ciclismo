BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7289$nota-0091$m7289$, $m7290$TSB ideal no dia da prova varia com a duração do evento: eventos curtos pedem TSB mais positivo, longos toleram TSB mais neutro/negativo$m7290$, $m7291$metricas-de-potencia$m7291$,
  $m7292$direta$m7292$, $m7293$regra-interpretacao$m7293$,
  ARRAY[$m7294$mensal$m7294$]::text[], ARRAY[$m7295$TSS$m7295$]::text[],
  0.65, $m7296$revisar$m7296$, $m7297$Com base numa pesquisa informal com ~200 atletas (perguntando qual era o TSB no dia em que bateram recordes pessoais de potência em diferentes durações), os autores encontraram:

- **Considerando todas as durações**: recordes pessoais ocorreram numa faixa ampla de TSB (-30 a +30), mas a maioria caiu entre **-5 e +15**.
- **Esforços curtos (<5 min)**: recordes ocorreram com TSB ainda mais deslocado para o lado positivo — faz sentido fisiologicamente, já que esforços curtos dependem mais de potência neuromuscular/capacidade anaeróbia, que são maximizadas quando o atleta está bem descansado. Conclusão prática: em provas curtas e muito anaeróbias (pista, BMX, subidas curtas), é melhor estar muito bem descansado (TSB bem positivo).
- **Esforços de 5 minutos ou mais**: distribuição em formato de sino, com recordes ocorrendo numa faixa de TSB de -10 a +25 — mostrando que esses atletas tinham tanta chance de bater recorde com TSB de -10 quanto com +25. Conclusão prática: em provas mais longas/aeróbias (estrada, mountain bike, provas por etapas), não é recomendável tapear/descansar demais antes, sob risco de perder a "janela" de pico de forma.

**Regra geral: quanto mais anaeróbio o evento, mais importante é estar fresco (TSB alto); quanto mais aeróbio o evento, mais importante é estar em forma (CTL alto), tolerando TSB mais neutro ou até levemente negativo.**

Ressalva do próprio livro: os valores exatos de TSB dependem das constantes de tempo usadas para CTL e ATL (os valores acima assumem os padrões de 42 e 7 dias) — não aplicar esses números de forma rígida sem considerar as constantes de tempo realmente usadas para aquele atleta. Confiança marcada como "revisar" por se tratar de uma pesquisa informal (não um estudo controlado formalmente publicado) com amostra não totalmente descrita.

Aplicação ao feedback: ao aproximar-se de uma prova, cruzar a duração/tipo do evento-alvo com o TSB atual do atleta — para provas curtas e anaeróbias, recomendar tapering para TSB bem positivo; para provas longas e aeróbias, alertar contra descanso excessivo que jogue fora a janela de pico de forma.$m7297$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7298$nota-0094$m7298$, $m7299$TSB não precisa ser positivo para gerar pico de performance — precisa estar subindo (recuperando)$m7299$, $m7300$metricas-de-potencia$m7300$,
  $m7301$direta$m7301$, $m7302$regra-interpretacao$m7302$,
  ARRAY[$m7303$semanal$m7303$, $m7304$mensal$m7304$]::text[], ARRAY[$m7305$TSS$m7305$]::text[],
  0.75, $m7306$ativo$m7306$, $m7307$Estudo de caso do livro: um atleta produziu sua 3ª melhor potência de 20 minutos da temporada logo após um aumento íngreme de CTL (ramp rate de 12 TSS/dia por 2 semanas) — nesse momento, o TSB ainda estava negativo, mas estava claramente subindo (recuperando) em direção ao positivo.

Conclusão prática dos autores: **o TSB não precisa necessariamente ser um número positivo para gerar um pico de performance — ele precisa estar subindo/recuperando**, mesmo que ainda negativo no momento do esforço. Isso é consistente com a observação (nota-0091) de que recordes pessoais em esforços mais longos ocorrem numa distribuição ampla de TSB, incluindo valores negativos.

Aplicação ao feedback: ao avaliar se um atleta está "pronto" para uma prova ou teste, não olhar apenas o valor absoluto do TSB no dia, mas também a tendência dos últimos dias — um TSB negativo mas em trajetória de subida pode ser tão favorável quanto um TSB já positivo, dependendo do tipo de evento.$m7307$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7308$nota-0102$m7308$, $m7309$WAC Score (Williams, Allen, Coggan): pontuação de desempenho ajustada por idade vs. melhores do mundo$m7309$, $m7310$metricas-de-potencia$m7310$,
  $m7311$contexto$m7311$, $m7312$conceito$m7312$,
  ARRAY[$m7313$mensal$m7313$]::text[], ARRAY[$m7314$potência-máx$m7314$]::text[],
  0.55, $m7315$revisar$m7315$, $m7316$O WAC Score é uma ferramenta citada pelos autores (Peaks Coaching Group) que atribui, para cada duração de esforço, uma pontuação percentual comparando a potência do atleta contra a melhor marca mundial (pro) naquela duração, com ajuste por idade/categoria do atleta. Exemplo do livro: um WAC de 74 aos 22:48 minutos significa que o atleta produziu 74% da potência do melhor do mundo nessa duração.

**Motivo da baixa confiança/revisão:** o livro não fornece a tabela de referência completa (valores mundiais por duração) nem a fórmula exata de ajuste por idade — é uma ferramenta proprietária do Peaks Coaching Group (mesmo grupo dos autores), citada apenas conceitualmente. Não é possível reproduzir o cálculo do WAC Score sem acesso à tabela/software original, e não está claro se a ferramenta continua disponível/atualizada.

Aplicação ao feedback: manter como contexto — é conceitualmente semelhante ao Power Profile (nota-0032) mas usando referência absoluta mundial ajustada por idade em vez de categorias fixas por W/kg. Não implementável diretamente no produto sem a tabela de referência original; não usar para gerar recomendações até validação.$m7316$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7317$nota-0103$m7317$, $m7318$Mean Maximal Power (MMP) Curve vs. Power Duration Curve (PDC): dados reais vs. modelo ajustado$m7318$, $m7319$metricas-de-potencia$m7319$,
  $m7320$direta$m7320$, $m7321$conceito$m7321$,
  ARRAY[$m7322$mensal$m7322$]::text[], ARRAY[$m7323$potência-máx$m7323$]::text[],
  0.85, $m7324$ativo$m7324$, $m7325$Distinção técnica importante entre duas curvas relacionadas mas diferentes:

- **MMP Curve (Mean Maximal Power Curve):** plotagem de todos os "melhores esforços" reais do atleta, para cada incremento de duração (melhor 39s, melhor 56s, melhor 1:38, etc.), extraídos diretamente dos dados brutos de potência coletados. É dado real, não modelado.
- **PDC (Power Duration Curve):** a linha de melhor ajuste (curva matemática) sobre a MMP Curve — é o **modelo** usado para derivar métricas como FRC, Pmax, Stamina e FTP modelada (mFTP).

Os autores recomendam revisar as duas: a PDC (modelo) é útil para extrair os parâmetros padronizados, mas a **MMP Curve real oferece o retrato mais fiel** da forma física, pontos fortes e fracos do atleta, já que é dado bruto e não uma aproximação matemática.

Aplicação ao feedback: ao calcular métricas derivadas (FRC, Pmax, mFTP) a partir de um ajuste de curva sobre os dados de potência do atleta, é importante não tratar esses valores modelados como substitutos completos dos picos reais de potência — o sistema deveria expor ambos (picos reais por duração E os parâmetros modelados) para evitar decisões baseadas apenas no ajuste matemático, que pode ter erro de fit em certas faixas de duração.$m7325$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;