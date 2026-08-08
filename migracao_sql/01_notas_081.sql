BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10891$nota-0112$m10891$, $m10892$Diretrizes de execução de pacing: 95% da potência-alvo nos primeiros 30-45min; +5%/+10% em subidas conforme duração$m10892$, $m10893$tipos-de-treino$m10893$,
  $m10894$direta$m10894$, $m10895$regra-interpretacao$m10895$,
  ARRAY[$m10896$diario$m10896$]::text[], ARRAY[$m10897$potência-por-lap$m10897$, $m10898$potência-média$m10898$, $m10899$NP$m10899$]::text[],
  0.7, $m10900$ativo$m10900$, $m10901$Diretrizes práticas (Endurance Nation) para executar o pacing de uma potência-alvo (NP-alvo) numa prova longa:

- **Primeiros 30-45 minutos:** manter apenas **95% da potência-alvo** (começar mais conservador).
- **Restante da prova em terreno plano:** manter a potência-alvo o mais próximo possível.
- **Subidas mais longas que 3 minutos:** subir a intensidade para **105% da potência-alvo**.
- **Subidas de 30 segundos a 2 minutos:** subir a intensidade para **110% da potência-alvo**.

Nota de contexto: normalmente um esforço máximo de 3 minutos seria feito a 115-120% da FTP (Nível 5) e um esforço de 30s-2min entre 120-150% da FTP — os valores de 105%/110% da potência-alvo (não da FTP) aqui são deliberadamente mais conservadores que o esforço máximo possível, para minimizar picos de potência e poupar glicogênio.

Aplicação ao feedback: ao segmentar uma prova longa por trecho (plano vs. subida, por duração de subida), o sistema pode comparar a potência real executada em cada segmento contra estas diretrizes percentuais relativas à NP-alvo calculada (nota-0111), sinalizando excesso de esforço nos primeiros 30-45min ou subidas com intensidade muito acima do recomendado.$m10901$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10902$nota-0118$m10902$, $m10903$Protocolo de pacing em contrarrelógio plano: início contido, isopower na FTP, contenção proporcional à duração$m10903$, $m10904$tipos-de-treino$m10904$,
  $m10905$direta$m10905$, $m10906$protocolo$m10906$,
  ARRAY[$m10907$diario$m10907$]::text[], ARRAY[$m10908$potência-série-temporal$m10908$, $m10909$potência-média$m10909$, $m10910$FTP$m10910$]::text[],
  0.75, $m10911$ativo$m10911$, $m10912$Estratégia padrão ("isopower") de pacing para um contrarrelógio plano sem vento:

1. **Largada:** usar os primeiros 15-30 segundos para atingir a velocidade, sem disparar a potência (RPE não reflete o esforço real nos primeiros minutos — risco de largar forte demais).
2. **Corpo da prova:** manter a potência o mais próximo possível da FTP (estratégia isopower), com o mínimo de variação possível.
3. **Últimos minutos:** aumentar a intensidade para o final, terminando com o máximo esforço possível na linha de chegada.

**Regra de contenção proporcional à duração da prova:** o tempo de contenção inicial (ritmo levemente abaixo da FTP no começo) escala com a duração total do evento — quanto mais curta a prova, menos se deve segurar o ritmo:
- Contrarrelógio de ~40 km: reter o ritmo nos primeiros ~5 minutos.
- Prova mais curta (~10 milhas): reter por ~2 minutos.
- Perseguição de 4 km: praticamente nenhuma contenção — é uma questão de aguentar o máximo possível até o fim.

Aplicação ao feedback: ao analisar um arquivo de contrarrelógio, comparar a potência dos primeiros minutos contra a potência média/FTP do restante da prova — um início desproporcionalmente alto (especialmente nos primeiros 15-30s) é um sinal clássico de pacing ruim ("started too hard"), mesmo que a prova termine com um resultado aceitável.$m10912$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10913$nota-0120$m10913$, $m10914$Pacing em subidas de contrarrelógio: empurrar acima da FTP quando há descida de recuperação; manter na FTP quando a subida platô (sem descida)$m10914$, $m10915$tipos-de-treino$m10915$,
  $m10916$direta$m10916$, $m10917$regra-interpretacao$m10917$,
  ARRAY[$m10918$diario$m10918$]::text[], ARRAY[$m10919$potência-por-lap$m10919$, $m10920$FTP$m10920$]::text[],
  0.7, $m10921$ativo$m10921$, $m10922$Duas regras de pacing para subidas dentro de um contrarrelógio, conforme o tipo de subida:

1. **Subida com descida correspondente (recuperação disponível):** pode-se empurrar acima da FTP, escalonado pela duração da subida — usar como teto de referência a potência máxima sustentável para aquela duração (ex.: 115% da FTP por 3 minutos, segundo os Níveis de Coggan) e então reduzir 5-10 pontos percentuais desse teto (ex.: mirar ~105% da FTP numa subida de 3 minutos), para deixar margem de segurança.
2. **Subida que "platô" (sem descida imediata para recuperar):** manter a potência na FTP ou apenas ligeiramente acima — não fazer um surto grande, pois não haverá descida para se recuperar. É crítico retomar a velocidade rapidamente assim que cruzar o topo; qualquer tempo abaixo da FTP no platô/reta após o topo é tempo perdido para os concorrentes.

Aplicação ao feedback: ao segmentar uma prova/treino por perfil de elevação, aplicar regras diferentes conforme o tipo de subida identificado (com descida vs. platô) ao avaliar se o pacing do atleta na subida foi apropriado — não tratar todo excesso de potência em subida da mesma forma.$m10922$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m10923$nota-0121$m10923$, $m10924$Regra da FTP para decidir 'sit on' vs. puxar numa fuga: se a rotação exige potência acima da FTP, sentar na roda em vez de puxar$m10924$, $m10925$tipos-de-treino$m10925$,
  $m10926$direta$m10926$, $m10927$regra-interpretacao$m10927$,
  ARRAY[$m10928$diario$m10928$]::text[], ARRAY[$m10929$potência-série-temporal$m10929$, $m10930$FTP$m10930$]::text[],
  0.65, $m10931$ativo$m10931$, $m10932$Estudo de caso (criterium): um ciclista numa fuga de 4 percebeu, em tempo real via medidor de potência, que mesmo na "fila de recuperação" (draft) da rotação ele precisava sustentar ~400W, acima da sua FTP — sinal de que o ritmo do grupo era insustentável para ele a médio prazo. Decisão tática correta segundo os autores: parar de puxar e "sentar na roda" (sit on) em vez de continuar contribuindo com a rotação, evitando ser cuspido do grupo por exaustão prematura.

Regra geral extraída: **se o esforço necessário mesmo na posição de menor exigência da rotação (draft) está acima da FTP do atleta, a fuga/grupo está a um ritmo insustentável para ele** — a decisão tática racional é reduzir contribuição (sit on) em vez de insistir em puxar, preservando energia para uma oportunidade posterior (ex.: sprint final).

Aplicação ao feedback: ao analisar um trecho de corrida em grupo/fuga onde a potência do atleta em "vales" de rotação (baixa exigência) já está próxima ou acima da FTP, isso é um sinal de ritmo insustentável — útil para explicar retrospectivamente por que um atleta foi "cuspido" de um grupo ou precisou mudar de estratégia no meio da prova.$m10932$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;