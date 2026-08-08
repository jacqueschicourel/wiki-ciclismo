BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1624$nota-0082$m1624$, $m1625$Mapa Fenotípico (Phenotypic Map): razões Pmax/FTP e FRC/Pmax substituem o Power Profile 1D por um mapa 2D$m1625$, $m1626$contexto-atleta$m1626$,
  $m1627$contexto$m1627$, $m1628$conceito$m1628$,
  ARRAY[$m1629$mensal$m1629$]::text[], ARRAY[$m1630$potência-máx$m1630$, $m1631$FTP$m1631$]::text[],
  0.7, $m1632$revisar$m1632$, $m1633$O Mapa Fenotípico é uma evolução do Power Profile: em vez de um perfil unidimensional (4 pontos discretos comparados a categorias fixas), usa duas razões contínuas como eixos — **Pmax/FTP** (eixo X) e **FRC/Pmax** (eixo Y) — permitindo posicionar o atleta num espaço bidimensional em vez de um rótulo único.

- Pmax/FTP baixo → perfil clássico ascendente de contrarrelogista/escalador (nota-0035): FTP alto relativo à potência neuromuscular, predominância de fibras lentas.
- Pmax/FTP alto → perfil clássico descendente de sprinter.
- Dentro do grupo de Pmax/FTP baixo (todos "contrarrelogistas" no sentido clássico), a razão **FRC/Pmax** diferencia contrarrelogistas puros (FRC/Pmax também baixo) de perseguidores/pursuiters (FRC/Pmax mais alto) — já que ambos os subgrupos têm Pmax baixo relativo ao FTP, usar Pmax como parte da segunda razão permite comparar sua capacidade anaeróbia (FRC) de forma normalizada dentro desse subgrupo.

Vantagem sobre o Power Profile clássico: por ser um mapa contínuo (não categorias fixas), é possível visualizar o "trânsito" de um atleta entre fenótipos ao longo do tempo conforme ele treina ou destreina (ex.: de all-rounder para perseguidor, depois para contrarrelogista, e de volta a all-rounder).

Nota de confiança: o mapeamento exato depende de software (WKO4) para calcular Pmax e FRC individualizados via ajuste de curva — a base não tem acesso a exemplos numéricos completos do mapa (apenas a lógica conceitual descrita no texto), por isso confiança um pouco mais baixa e marcada para revisão quanto à aplicabilidade prática sem a ferramenta de software específica.$m1633$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1634$nota-0097$m1634$, $m1635$Priorizar o limitante relevante para o objetivo do atleta, não necessariamente a fraqueza numérica absoluta do Power Profile$m1635$, $m1636$contexto-atleta$m1636$,
  $m1637$direta$m1637$, $m1638$regra-interpretacao$m1638$,
  ARRAY[$m1639$mensal$m1639$]::text[], ARRAY[$m1640$potência-máx$m1640$, $m1641$relação-P/peso$m1641$]::text[],
  0.85, $m1642$ativo$m1642$, $m1643$Estudo de caso: o Power Profile de Joe TriGuy (triatleta) mostra Potência Neuromuscular (Nível 7) muito fraca (abaixo de "novice" até 1 minuto). Apesar de tecnicamente ser uma fraqueza no perfil, os autores concluem que **não faz sentido dedicar tempo de treino a esse sistema**, porque potência neuromuscular/sprint não é relevante para o desempenho de um triatleta numa prova de estrada com poucas disputas de sprint — o tempo de treino é mais bem investido em FTP e capacidade anaeróbia (relevantes para as subidas curtas do percurso-alvo).

Princípio geral extraído: a identificação de "pontos fracos" via Power Profile/Curva de Duração de Potência (nota-0082 e correlatas) deve sempre ser filtrada pela relevância desse sistema energético para o objetivo específico do atleta (tipo de prova, perfil do percurso, modalidade). Uma fraqueza numérica absoluta não é automaticamente uma prioridade de treino.

Aplicação ao feedback: ao gerar recomendações de treino a partir do Power Profile/PDC de um atleta, o sistema não deve simplesmente apontar "seu ponto mais fraco é X" sem cruzar isso com o objetivo declarado do atleta (tipo de prova-alvo, perfil de percurso). Um sinal de "fraqueza" em um sistema energético irrelevante ao objetivo deve ter prioridade de recomendação baixa, mesmo com confiança estatística alta.$m1643$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1644$nota-0117$m1644$, $m1645$Excesso de ritmo no bike leg é apontado como a principal causa de DNF em triathlon; diferença entre pacing bom e ruim pode ser de apenas ~15W de NP$m1645$, $m1646$contexto-atleta$m1646$,
  $m1647$direta$m1647$, $m1648$regra-interpretacao$m1648$,
  ARRAY[$m1649$diario$m1649$]::text[], ARRAY[$m1650$NP$m1650$, $m1651$IF$m1651$]::text[],
  0.55, $m1652$revisar$m1652$, $m1653$Afirmação dos autores (não referenciada a estudo formal/estatística de DNFs): pedalar rápido demais no bike leg é a **principal causa de DNF (não terminar a prova)** em triathlon. A diferença entre um bike leg bem pacing e um mal pacing pode ser de apenas **~15 watts de Potência Normalizada média** ao longo de toda a prova — uma margem pequena com grande impacto no resultado final (capacidade de completar/desempenhar bem a corrida).

**Motivo da revisão:** afirmação qualitativa/anedótica dos autores ("number one cause"), sem citação de dados/estudo publicado que a sustente. O valor de 15W também não é acompanhado de contexto suficiente (independe de FTP absoluta do atleta? é uma cifra fixa ou percentual?) para ser tratado como regra numérica confiável.

Aplicação ao feedback: útil como justificativa qualitativa para dar peso extra a alertas de pacing agressivo no bike leg de provas de triathlon (IF/NP acima do orçamento calculado, nota-0111), mas não usar o valor "15W" como limiar quantitativo de alerta sem validação adicional.$m1653$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1654$nota-0138$m1654$, $m1655$Em provas de 24h, o gap criado nas primeiras 4-6h tende a se manter pelo resto da prova; em provas ultra de 6-8h, ataques decisivos ocorrem mais perto do final$m1655$, $m1656$contexto-atleta$m1656$,
  $m1657$direta$m1657$, $m1658$regra-interpretacao$m1658$,
  ARRAY[$m1659$diario$m1659$]::text[], ARRAY[$m1660$NP$m1660$, $m1661$TSS$m1661$]::text[],
  0.55, $m1662$revisar$m1662$, $m1663$Observação (baseada em análise de arquivos de potência de corredores de ultraresistência em MTB): em provas de **24 horas**, a maioria dos atletas fadiga a uma taxa similar ao longo das ~18 horas seguintes às primeiras 6 horas — então um gap estabelecido nas primeiras 4-6 horas (ex.: 45 minutos de vantagem na marca de 6h) **tende a se manter** pelo resto da prova, desde que não haja problemas de hidratação, nutrição ou mecânica. Isso reforça a lógica do Efeito Allen (nota-0137): vale a pena pedalar mais forte que o sustentável no início de uma prova de 24h para estabelecer esse gap.

**Contraste importante:** em provas ultra mais curtas (6-8 horas), a dinâmica é diferente — a prova é mais competitiva e se assemelha a corridas de estrada longas, onde os **ataques decisivos ocorrem perto do final** da prova, não no começo.

**Motivo da revisão:** conclusão qualitativa baseada em observação de poucos casos (arquivos de atletas de elite específicos), não um estudo estatístico controlado — tratar como heurística por faixa de duração, não regra numérica rígida.

Aplicação ao feedback: ao analisar provas de ultraresistência, diferenciar a estratégia esperada conforme a duração total: provas de ~24h favorecem pacing agressivo nas primeiras horas; provas de 6-8h favorecem conservação de energia para um ataque final.$m1663$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;