BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1042$nota-0218$m1042$, $m1043$Protocolo do teste submáximo de Astrand (bike): FC-alvo pela Reserva de FC (220−idade − FCrepouso), 6 min em carga constante, fórmula de VO2máx por sexo a partir de watts e FC estável, com fator de correção por idade$m1043$, $m1044$avaliacao-e-testes$m1044$,
  $m1045$direta$m1045$, $m1046$protocolo$m1046$,
  ARRAY[$m1047$mensal$m1047$]::text[], ARRAY[$m1048$potência-média$m1048$, $m1049$FC (média/máx)$m1049$]::text[],
  0.55, $m1050$ativo$m1050$, $m1051$Protocolo clássico de teste submáximo (Astrand-Ryhming) para estimar VO2máx usando bike estacionária com medidor de potência e monitor de FC — não exige esforço máximo:

1. Calcular FC-alvo: FC-alvo = FC máxima (220 − idade) − FC de repouso.
2. Pedalar a uma potência (watts) que produza a FC-alvo, com cadência de 50-80 rpm (ponto de partida sugerido: homens ~150W, mulheres ~100W, ajustável ao nível de condicionamento).
3. Buscar FC estável próxima do alvo nos primeiros 2 minutos; continuar por mais 4 minutos (6 min total); registrar FC a cada minuto.
4. Se a FC do último minuto não estiver dentro de 5 bpm do alvo (ou ainda estiver subindo), ajustar a carga e repetir por mais 6 minutos.

**Nota sobre a fórmula de FC-alvo (2026-08-02):** o passo 1 usa 220−idade (citação literal do protocolo-fonte), enquanto nota-0245/skill-gerais-zonas-fc recomenda evitar essa fórmula em favor de Gellish para cálculo de zonas de treino. Isso não é uma inconsistência a corrigir: a FC-alvo aqui serve só para calibrar a carga inicial do teste e checar se a FC estabilizou perto do esperado (passo 4) — o VO2máx final (passo 6) usa a FC estável **medida**, não a FC-alvo prevista. O viés conhecido de 220−idade (superestima <40 anos, subestima >40 anos) é absorvido pelo próprio passo 4 de ajuste-e-repetição, não pela precisão da FC-alvo em si. Manter 220−idade aqui por fidelidade ao protocolo publicado.

**Correção de nomenclatura (2026-08-02, achado de auditoria adversarial):** a fórmula do passo 1 (`FCmáx(220−idade) − FCrepouso`) era rotulada nesta nota e na skill que a usa como "fórmula de Karvonen" — mas estruturalmente ela só calcula a Reserva de FC (HRR), sem o fator de intensidade nem a soma da FC de repouso de volta que caracterizam o método de Karvonen de verdade (ver nota-0245: `LLTHR=(FCmáx−FCrepouso)×0,50+FCrepouso`, etc.). Chamar as duas coisas de "Karvonen" cria confusão real entre uma FC-alvo de calibração de teste (esta nota) e uma zona de treino (nota-0245). Corrigido: esta nota e a skill-gerais-testes-deliberados agora se referem à fórmula do passo 1 como "Reserva de FC (HRR) simplificada para calibração do teste de Astrand", nunca como "fórmula de Karvonen".
5. Calcular carga em kg-m/min: watts × 6,12.
6. Aplicar a fórmula (VO2máx absoluto em L/min): Mulheres = (0,00193×carga + 0,326) / (0,769×FC_estável − 56,1) × 100; Homens = (0,00212×carga + 0,299) / (0,769×FC_estável − 48,5) × 100.
7. Aplicar fator de correção por idade (tabela citada na fonte, mas não extraída em formato de texto do PDF — apenas imagem/gráfico).
8. Para VO2máx relativo (mL/kg/min): dividir o resultado do passo 6 pelo peso corporal (kg) e multiplicar por 1000.

Aplicação ao feedback: protocolo executável usando dados que o Strava já capta (potência média, FC média) de um trecho estruturado de 6 minutos em carga constante — se o produto quisesse oferecer uma estimativa de VO2máx sem exigir teste de laboratório, este protocolo é aplicável diretamente a uma sessão gravada com esse padrão específico (carga constante, FC estabilizada). Requer, porém, que o atleta siga deliberadamente o protocolo (não é derivável de uma sessão de treino arbitrária) e que o produto colete idade/peso/FC de repouso como dados de perfil. O fator de correção por idade citado na fonte não pôde ser extraído em texto (aparece apenas como tabela/imagem no PDF) — lacuna a resolver se o protocolo for implementado.$m1051$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1052$nota-0219$m1052$, $m1053$Equações de teste de campo de corrida para estimar VO2máx: Cooper 12min, 1 milha e 1,5 milha — não aplicáveis ao ciclismo, registradas como contexto$m1053$, $m1054$avaliacao-e-testes$m1054$,
  $m1055$contexto$m1055$, $m1056$referencia$m1056$,
  ARRAY[$m1057$mensal$m1057$]::text[], '{}'::text[],
  0.5, $m1058$ativo$m1058$, $m1059$Três equações de predição de VO2máx (mL/kg/min) baseadas em testes de campo de corrida: (1) Cooper 12 minutos — correr a maior distância possível em 12 min; VO2máx = (distância em metros − 504,9) / 44,73; (2) 1 milha — correr 1 milha o mais rápido possível; VO2máx = 75,056 − (3,879 × tempo em minutos); (3) 1,5 milha — mesma lógica; VO2máx = 76,775 − (2,543 × tempo em minutos).

Aplicação ao feedback: **não aplicável ao produto** (que interpreta dados de ciclismo via Strava) — protocolos e equações são específicos de corrida a pé, sem equivalente direto no ciclismo apresentado nesta fonte. Registrado por completude/não-descarte, mas sem uso previsto a menos que o produto expanda escopo para multiesporte (nesse caso, ver também nota-0114 do Livro 1 sobre equivalência de carga bike-corrida).$m1059$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1060$nota-0234$m1060$, $m1061$VO2max medido em cicloergômetro é tipicamente 6,4-11,2% menor que o mesmo indivíduo em esteira; ciclistas competitivos são exceção e igualam o valor da esteira$m1061$, $m1062$avaliacao-e-testes$m1062$,
  $m1063$contexto$m1063$, $m1064$referencia$m1064$,
  ARRAY[$m1065$mensal$m1065$]::text[], '{}'::text[],
  0.65, $m1066$revisar$m1066$, $m1067$Comparação clássica (McArdle et al. 1973, N=15 estudantes universitários) entre protocolos de VO2max em esteira e em cicloergômetro: o VO2max medido em **cicloergômetro é, em média, 6,4-11,2% menor** do que o mesmo indivíduo obtém em esteira rolante. Em contraste, a diferença entre os três protocolos de corrida em esteira testados foi de apenas 1,2%.

A explicação provável é a quantidade de massa muscular ativada: o teste em esteira envolve mais massa muscular total (incluindo estabilização de tronco/membros superiores) do que o ciclismo, que isola predominantemente os membros inferiores contra a resistência do pedal — o VO2max tende a ser maior quanto maior a massa muscular ativa envolvida no teste.

**Exceção importante**: ciclistas competitivos que pedalam nas cadências rápidas típicas de competição atingem valores de VO2max no cicloergômetro **equivalentes** aos valores em esteira — ou seja, a especificidade do treino/modalidade elimina essa diferença para atletas bem treinados especificamente em ciclismo (mesmo padrão de especificidade documentado para nadadores e race-walkers).

Confiança rebaixada (0,65) e status `revisar`: valor específico (6,4-11,2%) vem de um único estudo com amostra pequena (N=15, "McArdle WD, et al. Comparison of continuous and discontinuous treadmill and bicycle tests for max VO2. Med Sci Sports 1973;5:156"), embora citado como comparação clássica/consolidada no próprio livro-texto.

Aplicação ao feedback: relevante apenas como contexto para interpretação de testes de VO2max de laboratório (não medível via Strava) — se um ciclista comparar seu VO2max medido em cicloergômetro contra normativas populacionais baseadas em esteira, deve esperar um valor menor por padrão, a menos que seja um ciclista competitivo bem adaptado à modalidade.$m1067$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;