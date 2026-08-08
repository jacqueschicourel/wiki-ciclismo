BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5843$nota-0028$m5843$, $m5844$iLevels: níveis de potência individualizados (9 níveis, incluindo Sweet Spot 4a), baseados no modelo Potência-Duração$m5844$, $m5845$metricas-de-potencia$m5845$,
  $m5846$contexto$m5846$, $m5847$referencia$m5847$,
  ARRAY[$m5848$mensal$m5848$]::text[], ARRAY[$m5849$potência-máx$m5849$, $m5850$FTP$m5850$]::text[],
  0.75, $m5851$ativo$m5851$, $m5852$Os autores desenvolveram os iLevels (níveis individualizados) porque observaram atletas "outliers" que não se encaixavam bem nos 7 níveis clássicos de percentual fixo de FTP (nota-0022) — por exemplo, alguns atletas sustentam 150% do FTP por 5 minutos (o que a tabela clássica classificaria como Nível 6 alto), enquanto outros mal sustentam 105% do FTP por 5 minutos.

Os iLevels usam 9 níveis com 8 pontos de corte, determinados não por percentuais fixos, mas por pontos de inflexão/transição na curva de Potência-Duração ajustada individualmente ao atleta (modelo detalhado no Capítulo 8), refletindo mudanças no parâmetro de performance dominante (ex.: Pmax vs. FRC). Exemplo para um atleta com FTP = 290 W (Tabela 3.5 do livro): Nível 1 Recovery <171 W (<56%), Nível 2 Endurance 171–232 W (56–76%), Nível 3 Tempo 232–269 W (76–88%), **Nível 4a Sweet Spot 269–290 W (88–95%)**, Nível 4 FTP 290–321 W (95–105%), Nível 5 FRC/FTP 321–471 W (duração 17:40–1:33), Nível 6 FRC 471–711 W (1:33–0:28), Nível 7a Pmax/FRC 711–961 W (0:28–0:09), Nível 7 Pmax >961 W (<0:09).

Nota importante: acima do FTP, os cortes dos iLevels não são um percentual fixo generalizável — dependem do ajuste do modelo Potência-Duração aos dados de cada atleta ("secret sauce" dos autores), por isso esta nota é `aplicacao: contexto` (não é uma fórmula replicável diretamente a partir do texto). Abaixo/próximo do FTP (Níveis 1–4a), os iLevels são expressos como percentual do FTP modelado e são comparáveis aos níveis clássicos. O Nível 4a (Sweet Spot, 88–95% do FTP) é a introdução do conceito de "sweet spot", desenvolvido mais no Capítulo 5.$m5852$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5853$nota-0029$m5853$, $m5854$Mesma zona de potência média tem estresse diferente em prova vs. treino, por causa da variabilidade$m5854$, $m5855$metricas-de-potencia$m5855$,
  $m5856$direta$m5856$, $m5857$regra-interpretacao$m5857$,
  ARRAY[$m5858$diario$m5858$]::text[], ARRAY[$m5859$potência-média$m5859$, $m5860$VI$m5860$]::text[],
  0.8, $m5861$ativo$m5861$, $m5862$A potência média de uma prova de pelotão (mass-start) tipicamente cai no Nível 3 (Tempo), mas o estresse fisiológico de correr no Nível 3 é geralmente maior do que treinar no Nível 3, porque a prova envolve muito mais variabilidade de potência (picos mais altos e mais frequentes) do que um treino estruturado na mesma zona. Da mesma forma, por causa de pedaladas leves e trechos de roda livre, a potência média de um passeio com subidas ou treino em grupo não é fisiologicamente equivalente à mesma potência média obtida em percurso plano ou treino solo.

Isso já é parcialmente considerado na própria definição dos níveis (especialmente Níveis 2 e 3, mais amplos); em níveis mais altos o treino tende a ser mais estruturado, com menos variação de potência.

Aplicação ao feedback: ao interpretar a "zona" de uma atividade apenas pela potência média, considerar o contexto (prova vs. treino solo vs. treino em grupo, terreno plano vs. ondulado) e, quando disponível, a variabilidade da potência (VI) — uma potência média de Nível 3 em prova pode representar um estímulo/fadiga muito mais próximo de Nível 4–5 do que a mesma média em treino solo estruturado.$m5862$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5863$nota-0030$m5863$, $m5864$A potência média de uma sessão inteira pode não representar o tipo real de treino (estrutura importa mais que a média)$m5864$, $m5865$metodologia-e-periodizacao$m5865$,
  $m5866$direta$m5866$, $m5867$regra-interpretacao$m5867$,
  ARRAY[$m5868$diario$m5868$]::text[], ARRAY[$m5869$potência-média$m5869$, $m5870$tempo-em-zona$m5870$]::text[],
  0.85, $m5871$ativo$m5871$, $m5872$Duas regras de interpretação relacionadas à potência ao longo do tempo:

1. **Relação inversa entre potência e duração sustentável**: esforços/sessões mais curtos tendem a cair na extremidade superior de uma faixa de nível; sessões/esforços mais longos tendem a cair na extremidade inferior da mesma faixa.

2. **A média geral de uma sessão pode mascarar sua estrutura real**: exemplo do livro — uma sessão de 30 min em Nível 1 (aquecimento) + 60 min em Nível 3 (bloco principal) + 30 min em Nível 1 (volta à calma) tem potência média que cai no Nível 2, mas deveria ser classificada como um treino de **Tempo** (o que o bloco principal de 60 min realmente foi), não como um treino de Endurance/Nível 2.

Aplicação ao feedback: nunca classificar o tipo/intenção de uma sessão apenas pela potência média do arquivo inteiro — é necessário olhar a distribuição de tempo-em-zona (ou os blocos/intervalos marcados) para identificar corretamente qual foi o estímulo principal pretendido pelo treino.$m5872$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m5873$nota-0033$m5873$, $m5874$Fórmula da razão potência/peso (W/kg)$m5874$, $m5875$metricas-de-potencia$m5875$,
  $m5876$direta$m5876$, $m5877$referencia$m5877$,
  ARRAY[$m5878$diario$m5878$, $m5879$mensal$m5879$]::text[], ARRAY[$m5880$potência-máx$m5880$, $m5881$relação-P/peso$m5881$]::text[],
  0.9, $m5882$ativo$m5882$, $m5883$Fórmula: **razão potência/peso (W/kg) = potência (watts) ÷ peso corporal (kg)**. Para converter peso de libras para quilos: peso (kg) = peso (lb) ÷ 2,2. Exemplo do livro: 423 W sustentados por 5 min, atleta de 75 kg → 423 ÷ 75 = 5,64 W/kg.

A razão potência/peso é o que determina performance em subidas (onde o peso precisa ser vencido pela gravidade) — dois ciclistas com pesos e potências absolutas muito diferentes podem ter desempenho equivalente em subida se a razão W/kg for igual (exemplo do livro: 200 lb/350 W e 125 lb/218 W dão ambos 3,85 W/kg). É a unidade padrão em que o Power Profile (Tabela 4.1, nota-0031) é expresso.

Aplicação ao feedback: usar esta fórmula para converter qualquer potência (pico ou média, de qualquer duração) do Strava em W/kg, permitindo comparações justas entre atletas de pesos diferentes — é a base de cálculo para localizar o atleta no Power Profile (Tabela 4.1) e para reportar picos/médias normalizados por peso corporal.$m5883$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;