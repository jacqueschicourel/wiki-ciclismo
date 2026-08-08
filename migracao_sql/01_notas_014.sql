BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1880$nota-0216$m1880$, $m1881$'Não respondedores' a treino de VO2máx existem em volume/intensidade padrão (10-20% no HERITAGE Study), mas a taxa de não-resposta cai para perto de zero com mais frequência/volume/intensidade — princípio transferível: se não há resposta, considerar mais estímulo, não menos$m1881$, $m1882$contexto-atleta$m1882$,
  $m1883$contexto$m1883$, $m1884$conceito$m1884$,
  ARRAY[$m1885$mensal$m1885$]::text[], '{}'::text[],
  0.5, $m1886$ativo$m1886$, $m1887$**Política de ativação aplicada:** a estatística central (10-20% de "não-respondedores" a VO2máx) vem de um único estudo, ainda que landmark e amplamente citado na área (HERITAGE Family Study) — mantido como `aplicacao: contexto` por depender de medição de VO2máx em laboratório (não derivável do Strava) e por se basear em um sistema de estudo único. Achado descrito: em programas de treino padrão (guidelines de saúde pública), 10-20% dos participantes não mostram ganho de VO2máx; porém, quando o treino intervalado intenso é feito 4-5x/semana, virtualmente todos os participantes respondem — sugerindo que "não resposta" é frequentemente um problema de dose insuficiente (volume/frequência/intensidade), não de "não-treinabilidade" genética real.

Aplicação ao feedback: o **princípio geral é transferível** mesmo sendo baseado em estudo único de VO2máx laboratorial — se o produto detectar estagnação prolongada de FTP/CTL apesar de treino consistente (já coberto por nota-0089 do Livro 1, "platô de CTL"), esta nota sugere que a causa mais provável não é uma limitação biológica fixa, mas volume/frequência/intensidade insuficientes — reforça, sem contradizer, a recomendação de progressão de carga já presente no cânone, mas não deve ser citada como "a maioria das pessoas não responde a treino padrão" sem essa ressalva de estudo único.$m1887$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1888$nota-0217$m1888$, $m1889$Genética explica ~47% da variação na resposta de VO2máx ao treino (HERITAGE Study), mas não existe um 'gene do VO2máx' único identificado — variantes de EPO encontradas apenas em casos raros isolados de atletas de elite$m1889$, $m1890$contexto-atleta$m1890$,
  $m1891$contexto$m1891$, $m1892$conceito$m1892$,
  ARRAY[$m1893$mensal$m1893$]::text[], '{}'::text[],
  0.5, $m1894$ativo$m1894$, $m1895$**Política de ativação aplicada:** estatística e conclusão vêm de um único sistema de estudo (HERITAGE Family Study e revisões relacionadas de Joyner/Lundby) — mantido como `aplicacao: contexto`. Aproximadamente 47% da variação na resposta de VO2máx ao treino é atribuível a fatores hereditários/genéticos (estudos com gêmeos e famílias). Apesar disso, não foi identificado um "gene do VO2máx" único e consistente — painéis genéticos de até 21 variantes têm poder preditivo parcial, mas nem todas as variantes se ligam diretamente aos determinantes fisiológicos conhecidos (débito cardíaco, volume sistólico, volume sanguíneo, massa de hemácias). Variantes raras ligadas à via da eritropoetina (EPO) foram encontradas em casos isolados de atletas de elite (ex.: um campeão olímpico de esqui), mas não emergem consistentemente em estudos com grandes populações de atletas de endurance de elite.

Aplicação ao feedback: puramente conceitual/contexto — não gera nenhuma regra de interpretação de dado do Strava. Relevante apenas se o produto precisar comunicar, de forma educativa e responsável, que a resposta ao treino tem um componente genético significativo (evitando culpar o atleta por progresso mais lento) sem alegar que existe um teste genético definitivo capaz de prever potencial de VO2máx.$m1895$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m1896$nota-0251$m1896$, $m1897$Fórmula do índice WBGT (wet bulb-globe temperature) para avaliar o estresse térmico ambiental$m1897$, $m1898$contexto-atleta$m1898$,
  $m1899$contexto$m1899$, $m1900$referencia$m1900$,
  ARRAY[$m1901$diario$m1901$]::text[], '{}'::text[],
  0.6, $m1902$ativo$m1902$, $m1903$O índice WBGT (wet bulb-globe temperature), desenvolvido pelo exército americano e adotado pela NCAA para estabelecer limiares de risco de lesão por calor, combina três leituras de temperatura em uma fórmula ponderada:

**WBGT = 0,1 × DBT + 0,7 × WBT + 0,2 × GT**

Onde: DBT = temperatura de bulbo seco (termômetro de mercúrio comum, mede temperatura do ar); WBT = temperatura de bulbo úmido (termômetro com um pavio molhado ao redor do bulbo — quanto menor a diferença entre DBT e WBT, maior a umidade relativa, pois pouca evaporação ocorre do bulbo molhado); GT = temperatura de globo (termômetro com esfera metálica preta que absorve energia radiante do ambiente, captando a carga de calor radiante/solar).

O peso de 0,7 dado ao bulbo úmido reflete que a umidade relativa é o fator mais importante para determinar a eficácia da perda de calor evaporativa (ver nota correlata sobre taxa de sudorese e umidade).

Aplicação ao feedback: o Strava só fornece temperatura do ar (equivalente ao DBT), não umidade relativa nem carga radiante — portanto o WBGT completo não pode ser calculado automaticamente a partir dos dados de atividade. Ainda assim, a fórmula serve de referência conceitual para explicar por que a temperatura do ar sozinha subestima o estresse térmico real em dias úmidos ou de sol forte, e justifica tratar a `temperatura` do Strava como um proxy imperfeito (subestima o risco em dias úmidos/ensolarados) ao gerar alertas de calor.$m1903$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;