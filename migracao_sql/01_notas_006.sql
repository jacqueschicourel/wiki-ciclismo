BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m920$nota-0144$m920$, $m921$Aliasing: distorção nos dados do medidor de potência quando a frequência de amostragem é baixa demais$m921$, $m922$avaliacao-e-testes$m922$,
  $m923$contexto$m923$, $m924$conceito$m924$,
  ARRAY[$m925$diario$m925$]::text[], ARRAY[$m926$potência-série-temporal$m926$]::text[],
  0.5, $m927$ativo$m927$, $m928$"Aliasing" é a distorção/artefato que aparece nos dados de um medidor de potência quando o sinal analógico é amostrado numa frequência baixa demais, produzindo valores registrados que não refletem fielmente o esforço real (picos podem ser suavizados/perdidos ou distorcidos entre amostras).

Aplicação ao feedback: nota de contexto sobre qualidade de dado — relevante para explicar por que dados de potência de dispositivos com taxa de amostragem baixa (ex.: 1 amostra/segundo vs. medidores de alta frequência) podem subestimar picos reais de potência de curtíssima duração (sprints, microbursts), o que pode afetar a precisão de métricas derivadas de pico (Pmax, picos de 1-5s). Não há fórmula de correção fornecida no livro; é apenas uma ressalva de limitação de dado.$m928$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m929$nota-0163$m929$, $m930$Tabela de referência de VO2máx por nível: sedentário 25-40, amador 50-65, elite nacional 65-75, elite internacional 75-85, excepcional >85 mL·kg⁻¹·min⁻¹$m930$, $m931$avaliacao-e-testes$m931$,
  $m932$contexto$m932$, $m933$referencia$m933$,
  ARRAY[$m934$mensal$m934$]::text[], '{}'::text[],
  0.5, $m935$ativo$m935$, $m936$Tabela de valores de referência de VO2máx (mL·kg⁻¹·min⁻¹) por nível de ciclista: Sedentários 25-40; Ativos 40-55; Ciclistas amadores 50-65; Elite nacional 65-75; Elite internacional 75-85; Valores excepcionais >85. O próprio Manual adverte que são apenas referências gerais e que o desempenho competitivo nunca deve ser previsto exclusivamente a partir do VO2máx (ver nota-0164).

Aplicação ao feedback: só é utilizável se o produto receber um valor de VO2máx do usuário (medido em laboratório ou estimado por wearable) — não é um dado nativo do Strava. Política de ativação: por depender de dado não derivável diretamente do Strava (teste laboratorial ou estimativa proprietária de dispositivo), mantém-se aplicacao: contexto — não deve gerar regra de interpretação automática (aplicacao: direta) a menos que o produto explicitamente colete esse dado como input do atleta.$m936$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m937$nota-0183$m937$, $m938$Métodos propostos para medir durabilidade: comparar testes antes/depois de exercício prolongado, queda da Potência Crítica, alteração de limiares, curva potência-duração pré/pós fadiga — sem método universal consolidado$m938$, $m939$avaliacao-e-testes$m939$,
  $m940$contexto$m940$, $m941$conceito$m941$,
  ARRAY[$m942$semanal$m942$, $m943$mensal$m943$]::text[], '{}'::text[],
  0.5, $m944$ativo$m944$, $m945$O Manual reconhece explicitamente que não existe ainda um método universal consolidado para medir durabilidade, mas cita abordagens em uso: (1) comparar testes fisiológicos (ex.: teste de FTP/CP) antes e depois de um exercício prolongado; (2) medir a queda percentual da Potência Crítica pós-fadiga; (3) observar alteração dos limiares fisiológicos; (4) medir redução do VO2 correspondente a uma intensidade fixa; (5) comparar a curva potência-duração (MMP) antes e depois de esforços prolongados. Menciona que medidores de potência tornaram possível acompanhar essas alterações diretamente em treinos/competições — abrindo uma área de pesquisa nova.

Aplicação ao feedback: confirma que a abordagem já usada no cânone (comparar a curva de potência-duração/MMP em diferentes momentos de uma sessão longa, e a métrica de Stamina/TTE do Livro 1, nota-0080/nota-0081) está alinhada com o estado da arte descrito no Manual — não há um método mais avançado ou uma fórmula fechada de "índice de durabilidade" a adotar no lugar do que já está implementado.$m945$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m946$nota-0206$m946$, $m947$VO2máx estimado por wearable (Garmin/WHOOP) é pouco confiável — algoritmo proprietário, opinião do autor; útil apenas como tendência (subindo/descendo), não como valor absoluto$m947$, $m948$avaliacao-e-testes$m948$,
  $m949$contexto$m949$, $m950$conceito$m950$,
  ARRAY[$m951$mensal$m951$]::text[], '{}'::text[],
  0.4, $m952$revisar$m952$, $m953$**Política de ativação aplicada:** afirmação é a opinião pessoal do autor ("I've voiced my opinions... I don't think you should put much stock"), sobre algoritmos proprietários de terceiros (Garmin/WHOOP) cujos detalhes não são descritos — downgrade para `aplicacao: contexto`, confiança rebaixada (0.4) e `status: revisar` por ser opinião não fundamentada em dado quantitativo dentro do próprio livro. O autor reconhece utilidade limitada: a tendência (subindo/descendo) pode ser informativa, mesmo que o valor absoluto não seja confiável.

Aplicação ao feedback: relevante apenas se o produto algum dia incorporar VO2máx estimado por wearable como sinal de entrada — reforça que esse dado, se usado, deveria ser tratado como tendência direcional (comparação relativa ao longo do tempo), nunca como valor absoluto preciso. Não é um sinal do Strava/medidor de potência, então não gera regra operacional hoje.$m953$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m954$nota-0209$m954$, $m955$Platô de VO2 não aparece em ~50% das pessoas mesmo em esforço máximo real — critérios alternativos: RER >1,15, lactato sanguíneo elevado, PSE máxima$m955$, $m956$avaliacao-e-testes$m956$,
  $m957$contexto$m957$, $m958$conceito$m958$,
  ARRAY[$m959$mensal$m959$]::text[], '{}'::text[],
  0.6, $m960$ativo$m960$, $m961$Confirma e quantifica um ponto já mencionado de forma mais genérica na Fonte 2 (Manual, Cap.9): o platô de VO2 (critério clássico de confirmação de esforço máximo em teste incremental) não aparece em aproximadamente metade das pessoas testadas, mesmo quando o esforço máximo real foi atingido. Critérios alternativos recomendados para confirmar que o esforço foi de fato máximo: razão de troca respiratória (RER) acima de 1,15 (quase 100% da energia vindo de carboidrato/vias anaeróbias), lactato sanguíneo elevado, e percepção subjetiva de esforço máxima ao final do teste.

Aplicação ao feedback: nota de referência sobre protocolo laboratorial — não gera regra de interpretação de dado do Strava (RER e lactato não são dados do Strava), mas é relevante caso o usuário relate resultados de um teste de VO2máx externo; reforça que a ausência de um "platô" no relatório do teste não invalida o resultado.$m961$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;