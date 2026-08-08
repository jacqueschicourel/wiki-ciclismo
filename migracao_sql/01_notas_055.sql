BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7468$nota-0104$m7468$, $m7469$Como interpretar mudanças de inclinação e 'vales' na MMP Curve sem confundir com limite fisiológico$m7469$, $m7470$metricas-de-potencia$m7470$,
  $m7471$direta$m7471$, $m7472$regra-interpretacao$m7472$,
  ARRAY[$m7473$mensal$m7473$]::text[], ARRAY[$m7474$potência-máx$m7474$]::text[],
  0.75, $m7475$ativo$m7475$, $m7476$Duas regras de leitura da MMP Curve (curva de melhores potências por duração, dados reais):

1. **Pontos de mudança de inclinação (breakpoints)** ao longo da curva costumam corresponder a transições entre sistemas energéticos predominantes (ex.: de capacidade anaeróbia para VO2max, e deste para limiar de lactato). A posição exata desses breakpoints é individual.

2. **"Vales" ou inversões locais na curva (potência maior numa duração mais longa que numa mais curta)** não representam impossibilidade fisiológica — são artefato da coleta de dados reais: o atleta pode simplesmente não ter feito um esforço máximo justamente naquela duração mais curta, enquanto fez um esforço quase-máximo por acaso numa duração mais longa (ex.: um hill repeat de 1:45). A MMP Curve reflete os melhores dados *disponíveis*, não o teto fisiológico teórico em cada ponto.

Aplicação ao feedback: ao gerar interpretações automáticas a partir da curva de potência do atleta, (a) usar mudanças de inclinação como candidatos a limites entre sistemas energéticos para direcionar recomendações de treino específicas; (b) não sinalizar como "anomalia" ou erro de dado uma inversão local da curva — isso é esperado e normal em dados reais esparsos, não indica problema de medição.$m7476$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7477$nota-0105$m7477$, $m7478$Além de ~1 hora, a Potência Normalizada (NP) é medida mais fiel da capacidade real do que a potência média bruta (MMP)$m7478$, $m7479$metricas-de-potencia$m7479$,
  $m7480$direta$m7480$, $m7481$regra-interpretacao$m7481$,
  ARRAY[$m7482$diario$m7482$, $m7483$mensal$m7483$]::text[], ARRAY[$m7484$potência-máx$m7484$, $m7485$NP$m7485$]::text[],
  0.7, $m7486$ativo$m7486$, $m7487$Ao comparar a curva de Potência Média Máxima (MMP, dados brutos) com a curva de NP Média Máxima ao longo de diferentes durações, as duas linhas se cruzam por volta de **7:25 (minutos:segundos)**: abaixo dessa duração, a potência média bruta é maior que a NP; acima dela, a NP passa a ser maior que a potência média bruta.

Explicação: em esforços mais longos, a potência média bruta tende a subestimar a capacidade real do atleta, em parte por causa do tempo sem pedalar (freewheeling, curvas, semáforos etc.), que puxa a média para baixo. Por isso, **além de ~1 hora** (ou além do contrarrelógio mais longo e "plano" já realizado pelo atleta), a **NP é a métrica mais confiável** da capacidade real.

Aplicação ao feedback: ao comparar recordes pessoais/picos de potência do atleta por duração, usar potência média bruta para esforços curtos (até a faixa de ~7-8 minutos) mas priorizar a NP para avaliar esforços longos (>1h), especialmente em provas ou treinos com muitas paradas/variações de terreno.$m7487$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7488$nota-0107$m7488$, $m7489$Efeito 'gangorra' entre FRC/Pmax e FTP modelada (mFTP): retestar só os esforços curtos após semana de descanso pode fazer a FTP modelada parecer cair sem ter caído de verdade$m7489$, $m7490$metricas-de-potencia$m7490$,
  $m7491$direta$m7491$, $m7492$regra-interpretacao$m7492$,
  ARRAY[$m7493$mensal$m7493$]::text[], ARRAY[$m7494$potência-máx$m7494$, $m7495$FTP$m7495$]::text[],
  0.8, $m7496$ativo$m7496$, $m7497$Artefato importante de modelagem da PDC (Curva de Duração de Potência): FRC, Pmax e FTP modelada (mFTP) são todos derivados do mesmo ajuste de curva sobre a área sob a MMP Curve. Se o atleta faz um novo recorde de potência de curta duração (1-5 minutos, elevando o FRC/Pmax) mas **não** retesta simultaneamente as durações longas (20-60 minutos), o ajuste da curva pode fazer a **FTP modelada parecer cair** — não porque a FTP real caiu, mas porque elevar o lado esquerdo da curva (curta duração) sem atualizar o lado direito (longa duração) distorce o formato ajustado da PDC.

Aplicação ao feedback: antes de sinalizar uma "queda de FTP" com base em recálculo automático da PDC, verificar se houve reteste recente e completo dos dois lados da curva (esforços curtos E longos). Se apenas esforços curtos foram atualizados recentemente, tratar uma aparente queda de mFTP como possível artefato de modelagem, não como perda real de fitness — sinalizar como baixa confiança até haver um teste direto de 20-60 minutos mais recente.$m7497$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m7498$nota-0108$m7498$, $m7499$TTE (Time to Exhaustion) como indicador antecedente de melhora iminente da FTP; reseta após o aumento$m7499$, $m7500$metricas-de-potencia$m7500$,
  $m7501$direta$m7501$, $m7502$regra-interpretacao$m7502$,
  ARRAY[$m7503$mensal$m7503$]::text[], ARRAY[$m7504$potência-média$m7504$, $m7505$FTP$m7505$]::text[],
  0.7, $m7506$ativo$m7506$, $m7507$O TTE (tempo que o atleta consegue sustentar a potência da FTP até a exaustão) não é só uma métrica descritiva — pode funcionar como **indicador antecedente** de uma melhora iminente de FTP: quando o TTE do atleta vai se aproximando de 1 hora (ou até ultrapassando), é sinal de que a FTP provavelmente vai subir em breve. Uma vez que a FTP é de fato elevada (por reteste ou remodelagem), o TTE **reseta** para um valor mais baixo, até que o atleta comprove de novo que consegue sustentar a nova potência por uma hora inteira.

Aplicação ao feedback: monitorar a tendência do TTE modelado do atleta ao longo do tempo — um TTE em trajetória de alta aproximando-se de 60 minutos é um sinal para o sistema sugerir um novo teste de FTP em breve (a FTP atual provavelmente está subestimada). Um TTE que caiu bruscamente após um aumento recente de FTP é esperado e não deve ser lido como perda de fitness.$m7507$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;