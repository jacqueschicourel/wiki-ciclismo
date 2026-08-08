BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10406$nota-0040$m10406$, $m10407$Regra do \"intervalo repetível\": usar a 3ª repetição como referência e parar quando a potência cair 5% abaixo dela$m10407$, $m10408$tipos-de-treino$m10408$,
  $m10409$direta$m10409$, $m10410$regra-interpretacao$m10410$,
  ARRAY[$m10411$diario$m10411$]::text[], ARRAY[$m10412$potência-por-lap$m10412$, $m10413$tempo-em-zona$m10413$]::text[],
  0.85, $m10414$ativo$m10414$, $m10415$Regra desenvolvida pelos autores (baseada em revisão de mais de 3.000 arquivos de potência e 1.000+ atletas) para determinar objetivamente quando parar uma série de intervalos repetidos (ex.: 5×5min, 8×2min): a potência do **3º intervalo completo é usada como referência "repetível"** — descartam-se os dois primeiros esforços porque, estando o atleta fresco, eles tendem a ser mais fortes do que o atleta consegue de fato repetir ao longo da série (mais glicogênio disponível e capacidade de trabalho anaeróbio ainda intacta). A partir da potência média do 3º intervalo, **subtrai-se 5%** para obter o limiar de parada: quando o atleta não conseguir mais atingir, em média, esse valor num intervalo, a série deve ser encerrada, pois a intensidade já não é suficiente para gerar o estímulo/adaptação pretendidos.

Fórmula: **potência de parada = potência do 3º intervalo × 0,95**. Exemplo do livro: FTP = 300 W, meta de VO2máx (106–120% FTP), 3º intervalo médio de 340 W → 340 × 0,05 = 17 → 340 − 17 = 323 W é o piso; quando o atleta não atingir mais 323 W de média no intervalo, para.

Nuance: essa regra do descarte dos 2 primeiros esforços vale para intervalos mais curtos (relevante sobretudo até ~3 min); para intervalos mais longos, em que o atleta só completa 2 repetições no total, a regra não se aplica da mesma forma. Também não se aplica igual a atletas muito experientes, que já sabem de saída a potência que conseguem sustentar (não precisam "gastar" os 2 primeiros esforços para descobrir isso).

Aplicação ao feedback: dado um arquivo de intervalos marcados (laps), comparar a queda percentual de potência de cada repetição em relação ao 3º intervalo — se a queda ultrapassar ~5% antes do fim da série planejada, é sinal de que a série foi bem otimizada (ou até que poderia ter continuado, se a queda ainda não tiver chegado a 5% no fim da série); se o atleta parou antes da queda de 5%, é sinal de que poderia ter feito mais repetições.$m10415$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10416$nota-0041$m10416$, $m10417$Sweet Spot (sub-limiar): faixa de ~88–94% do FTP e papel na periodização$m10417$, $m10418$tipos-de-treino$m10418$,
  $m10419$direta$m10419$, $m10420$conceito$m10420$,
  ARRAY[$m10421$semanal$m10421$, $m10422$mensal$m10422$]::text[], ARRAY[$m10423$potência-média$m10423$, $m10424$FTP$m10424$, $m10425$tempo-em-zona$m10425$]::text[],
  0.8, $m10426$ativo$m10426$, $m10427$Sweet Spot (também chamado de Sub-Threshold, parte inferior do Nível 4) é a faixa de intensidade entre o topo do Tempo e o limiar de lactato, definida no texto como aproximadamente **88–94% do FTP** (na tabela de iLevels do Capítulo 3, o mesmo intervalo aparece como 88–95% — ver nota de conflito interno). Não é um nível oficial dos 7 clássicos, mas é tratado como uma das faixas de treino mais úteis do livro.

Papel na periodização recomendado pelos autores: treinar pesado nessa faixa no **início da temporada de corrida**, antes de progredir para treino direto no FTP (91–105%); revisitar a faixa de Sweet Spot por volta de **meados de junho**, na preparação para um segundo pico de forma no outono. Mesmo fora desses períodos-chave, os autores recomendam incorporar Sweet Spot **pelo menos 1–2 vezes a cada 14 dias**.

Por que funciona: treinar nessa faixa não ajuda muito o sprint, a potência de VO2máx ou a capacidade anaeróbia, mas é uma das formas mais eficientes de elevar o FTP com bom retorno por unidade de tempo/fadiga, servindo de base sólida e ampla antes de avançar para trabalho de limiar mais específico. Um erro comum apontado no texto é avançar cedo demais para Nível 4/acima sem construir essa base de Sweet Spot, comprometendo essa "fundação".

Aplicação ao feedback: ao classificar o tempo-em-zona de uma sessão pela potência média, tratar a faixa de 88–94% do FTP como uma zona funcional distinta (Sweet Spot) e não apenas como Tempo alto ou limiar baixo — especialmente útil para reconhecer blocos de base no início de temporada ou em torno de meados de junho, conforme a periodização recomendada.$m10427$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10428$nota-0042$m10428$, $m10429$Janela de duração para estímulo eficaz de VO2máx: mínimo 3 min, máximo ~8 min por esforço$m10429$, $m10430$tipos-de-treino$m10430$,
  $m10431$direta$m10431$, $m10432$regra-interpretacao$m10432$,
  ARRAY[$m10433$diario$m10433$]::text[], ARRAY[$m10434$potência-média$m10434$, $m10435$tempo-em-zona$m10435$]::text[],
  0.8, $m10436$ativo$m10436$, $m10437$Para que um esforço realmente estimule adaptação do sistema de VO2máx, ele precisa durar pelo menos 3 minutos (esforços mais curtos não dão tempo suficiente ao sistema para ser adequadamente estressado) e no máximo cerca de 8 minutos (além disso, a maioria dos atletas não consegue mais sustentar 106–120% do FTP, a intensidade que caracteriza o Nível 5/VO2máx).

Aplicação ao feedback: ao avaliar se um bloco de intervalos foi eficaz para desenvolvimento de VO2máx, verificar se a duração de cada repetição caiu dentro dessa janela de 3–8 minutos com a intensidade correspondente (106–120%+ do FTP) — esforços fora dessa janela (mesmo na intensidade certa) tendem a treinar predominantemente outro sistema (ex.: capacidade anaeróbia, se muito curtos e intensos; limiar, se a intensidade cair para sustentar mais tempo).$m10437$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;