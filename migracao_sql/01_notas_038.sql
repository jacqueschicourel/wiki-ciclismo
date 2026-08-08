BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4834$nota-0188$m4834$, $m4835$Hierarquia da periodização: Macrociclo (temporada/plurianual) > Mesociclo (3-6 semanas, objetivo específico) > Microciclo (~1 semana, unidade prática de planejamento)$m4835$, $m4836$metodologia-e-periodizacao$m4836$,
  $m4837$contexto$m4837$, $m4838$conceito$m4838$,
  ARRAY[$m4839$mensal$m4839$]::text[], '{}'::text[],
  0.55, $m4840$ativo$m4840$, $m4841$Terminologia hierárquica padrão da periodização esportiva: Macrociclo (temporada completa, podendo abranger ciclos plurianuais) → Mesociclo (bloco de 3-6 semanas com objetivo fisiológico específico, ex.: desenvolvimento aeróbio, aumento de VO2máx, preparação competitiva) → Microciclo (organização semanal prática, onde se distribuem sessões intensas, regenerativas, força, técnica e descanso).

Aplicação ao feedback: fornece vocabulário/estrutura temporal de referência para qualquer feedback de "camada mensal" do produto (ex.: análise de fase da temporada, já prevista na taxonomia como camada `mensal`) — não gera regra de interpretação de dado isolado, mas organiza a escala temporal em que outras notas (CTL/ATL/TSB, distribuição de zonas por fase) se aplicam.$m4841$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4842$nota-0189$m4842$, $m4843$Periodização clássica de Matveyev (Preparatório → Competitivo → Transição) vs. Periodização em blocos (Verkhoshansky/Issurin: blocos especializados sequenciais) — modelos alternativos, escolha depende do calendário/nível do atleta$m4843$, $m4844$metodologia-e-periodizacao$m4844$,
  $m4845$contexto$m4845$, $m4846$conceito$m4846$,
  ARRAY[$m4847$mensal$m4847$]::text[], '{}'::text[],
  0.55, $m4848$ativo$m4848$, $m4849$Dois modelos clássicos de periodização, ambos válidos e não mutuamente exclusivos (muitos treinadores usam modelos híbridos): (1) Periodização clássica (Matveyev, anos 1960) — divide a temporada em 3 fases sequenciais: Preparatório (grande volume, baixa intensidade relativa, desenvolvimento geral da base), Competitivo (redução de volume, aumento de especificidade, manutenção de adaptações), Transição (recuperação física/psicológica, redução significativa de carga); (2) Periodização em blocos (Verkhoshansky, expandida por Issurin) — concentra estímulos semelhantes em blocos curtos especializados sequenciais (bloco de força → bloco aeróbio → bloco de VO2máx → bloco competitivo), em vez de desenvolver todas as capacidades simultaneamente; mais usada em atletas de alto rendimento. A escolha entre os modelos depende do calendário competitivo, nível do atleta, tempo disponível e modalidade.

Aplicação ao feedback: nomeia e formaliza modelos que provavelmente já influenciam implicitamente a lógica de fases de temporada do produto (via distribuição de zonas por fase, já no Livro 1 nota-0106) — útil como vocabulário de referência caso o feedback do produto precise identificar/nomear em que fase/modelo de periodização o plano do atleta se encaixa. Não gera regra de interpretação direta de dado do Strava.$m4849$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4850$nota-0190$m4850$, $m4851$Sequenciamento de estímulos no microciclo: sessões complexas/intensas quando o atleta está descansado; evitar sobreposição de estímulos semelhantes em dias consecutivos$m4851$, $m4852$metodologia-e-periodizacao$m4852$,
  $m4853$direta$m4853$, $m4854$regra-interpretacao$m4854$,
  ARRAY[$m4855$semanal$m4855$]::text[], ARRAY[$m4856$tempo-em-zona$m4856$, $m4857$tempo-decorrido$m4857$]::text[],
  0.5, $m4858$ativo$m4858$, $m4859$Princípios de sequenciamento de sessões dentro da semana: sessões de maior complexidade/intensidade (ex.: VO2max, força) devem ser realizadas quando o atleta está descansado, não após sessões longas/extenuantes; priorizar qualidade sobre quantidade; inserir recuperação ativa após sessões muito exigentes; evitar empilhar estímulos semelhantes (ex.: dois treinos de VO2max) em dias consecutivos.

Aplicação ao feedback: o produto pode usar esse princípio para sinalizar padrões subótimos no histórico do atleta — ex.: um intervalado de alta intensidade agendado/realizado no dia seguinte a uma sessão muito longa ou outro intervalado intenso pode ser sinalizado como sequenciamento potencialmente subótimo (risco de qualidade reduzida do estímulo), desde que o produto tenha acesso ao histórico de sessões consecutivas via Strava.$m4859$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m4860$nota-0192$m4860$, $m4861$TRIMP (Training Impulse, Banister): quantifica carga interna combinando duração e intensidade baseada em FC — útil quando não há medidor de potência$m4861$, $m4862$metodologia-e-periodizacao$m4862$,
  $m4863$contexto$m4863$, $m4864$conceito$m4864$,
  ARRAY[$m4865$diario$m4865$]::text[], '{}'::text[],
  0.5, $m4866$ativo$m4866$, $m4867$TRIMP (Training Impulse), proposto por Eric Banister, foi um dos primeiros métodos amplamente usados para quantificar carga interna de treino, combinando duração da sessão e intensidade baseada em FC (não em potência). O Manual não fornece a fórmula matemática exata de Banister (apenas descreve o princípio: maior tempo e maior intensidade → maior TRIMP), citando-o como precursor histórico do TSS, útil especificamente quando o atleta não possui medidor de potência (só FC).

Aplicação ao feedback: relevante apenas como fallback conceitual para usuários do Strava sem medidor de potência (que só têm dados de FC/tempo) — hoje o produto usa TSS (via potência/FTP, nota-0062) como padrão; o TRIMP poderia servir de método alternativo de quantificação de carga para sessões sem dados de potência, mas o cânone não fornece a fórmula exata de Banister, então não deve ser implementado sem essa fórmula ser localizada em fonte adicional.$m4867$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;