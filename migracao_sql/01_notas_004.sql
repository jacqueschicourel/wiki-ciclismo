BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m539$nota-0058$m539$, $m540$Checklist de análise pós-treino e pós-prova (kJ vs. reabastecimento, Quadrant Analysis, ponto de queda, matches, ponto de quebra)$m540$, $m541$avaliacao-e-testes$m541$,
  $m542$direta$m542$, $m543$protocolo$m543$,
  ARRAY[$m544$diario$m544$]::text[], ARRAY[$m545$trabalho-kJ$m545$, $m546$potência-série-temporal$m546$, $m547$potência-por-lap$m547$, $m548$cadência$m548$]::text[],
  0.75, $m549$ativo$m549$, $m550$Lista de verificações práticas sugeridas pelos autores para revisar um arquivo de potência:

**Em arquivos de treino:**
- kJ totais gastos vs. reabastecimento (o atleta comeu/bebeu o suficiente para repor a energia gasta? ver nota-0002)
- Quadrant Analysis da sessão, comparada com a Quadrant Analysis de provas (para checar se o treino é específico o bastante — ver Capítulo 7)
- Ponto em que a potência começou a cair na sessão, e quantos kJ já haviam sido gastos até ali (indício de fadiga/depleção energética)
- Comparação de intervalos entre si (overlay): quantas repetições até uma queda relevante de potência? O número de intervalos feito foi adequado (nem de menos, nem de mais)?

**Em arquivos de prova:**
- Matches queimados (nota-0055) — entender a real demanda de esforços decisivos daquele tipo de prova, para depois desenhar treinos específicos que repliquem essa demanda
- Localização dos picos de potência no arquivo — em que momento da prova ocorreram os esforços mais decisivos
- Se o atleta foi "descolado" do pelotão: que tipo de esforço precisou fazer antes disso, com quantos watts, e onde exatamente ocorreu o "ponto de quebra" — usar essa informação para direcionar o treino seguinte

Aplicação ao feedback: esta lista funciona como um roteiro de perguntas-padrão a percorrer ao gerar o feedback diário/pós-prova de uma atividade, cobrindo energia, estrutura do esforço e pontos de falha/sucesso.$m550$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m551$nota-0072$m551$, $m552$Protocolo de teste de assimetria de pedalada em subida (4 dias, GPR/GPA)$m552$, $m553$avaliacao-e-testes$m553$,
  $m554$direta$m554$, $m555$protocolo$m555$,
  ARRAY[$m556$mensal$m556$]::text[], ARRAY[$m557$potência-por-lap$m557$, $m558$cadência$m558$]::text[],
  0.75, $m559$ativo$m559$, $m560$Protocolo para diagnosticar se uma assimetria de potência entre pernas é real (força muscular) ou é um problema de técnica/posição na bike: em uma mesma rota repetível (subida), realizar em 4 dias diferentes 3 intervalos de 5 minutos cada, à potência de Nível 5/VO2máx (~113–115% do FTP) — um intervalo em pé o tempo todo, um sentado o tempo todo, e um alternando entre as duas posições livremente.

- **Dia 1**: executar naturalmente, sem enfatizar nenhuma perna — serve de linha de base para identificar qual perna libera menos potência (GPR mais baixo).
- **Dia 2**: enfatizar conscientemente (empurrar bem mais forte) a perna identificada como mais fraca no Dia 1, tanto em pé quanto sentado, para ver se o balanço de GPR melhora.
- **Dia 3**: enfatizar apenas a perna esquerda em todos os esforços.
- **Dia 4**: enfatizar apenas a perna direita em todos os esforços.

Interpretação: se o desequilíbrio se corrige ao enfatizar conscientemente a perna mais fraca em pé, mas mudança de posição/movimento corporal pode ser a explicação (não necessariamente força muscular); se o desequilíbrio se corrige da mesma forma estando sentado (onde mudanças posturais têm menos influência), é mais provável que haja de fato uma discrepância de força muscular real entre os lados (ex.: glúteos, bíceps femoral). Também é possível descobrir, como no exemplo do livro, que um pequeno ajuste de padrão de movimento (ex.: deslocar o peso do corpo de forma diferente ao empurrar com cada perna) resolve boa parte da assimetria, gerando ganho direto de potência (10–20 W no caso do atleta-exemplo).

Aplicação ao feedback: ao revisar um teste de assimetria de pedalada marcado em 4 sessões, comparar o GPR de cada perna entre os intervalos em pé/sentado/alternado e entre os 4 dias para diferenciar se a assimetria é de força muscular real (persiste sentado) ou de padrão de movimento/ajuste de bike (melhora ao enfatizar conscientemente ou muda com a posição).$m560$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m561$nota-0075$m561$, $m562$Limitação do Power Profile: janelas de duração fixas podem subestimar capacidades reais do atleta$m562$, $m563$avaliacao-e-testes$m563$,
  $m564$contexto$m564$, $m565$conceito$m565$,
  ARRAY[$m566$mensal$m566$]::text[], ARRAY[$m567$potência-máx$m567$]::text[],
  0.8, $m568$ativo$m568$, $m569$O Power Profile (Tabela 4.1, nota-0031) usa 4 durações fixas (5s, 1min, 5min, FTP), mas dados de campo "ecologicamente válidos" (corridas, treinos não estruturados) raramente batem exatamente com essas janelas — um esforço máximo de 50s numa disputa de prêmio (prime) de criterium é quase tão informativo sobre capacidade anaeróbia quanto um de 60s, mas não conta corretamente para o critério de "1 minuto" do Power Profile, subestimando artificialmente essa capacidade.

O mesmo problema afeta o próprio FTP: fisiologicamente, o FTP é uma intensidade sustentável por algo entre ~30 e ~70 minutos (atletas mais treinados tendendo à parte superior dessa faixa), não exatamente 60 minutos. Exemplo do livro: um contrarrelojista que produz 300 W em teste de 60 min numa configuração, ao correr um CRI de 40 km numa configuração mais aerodinâmica termina em 55 min a 310 W, mas "desliga" nos últimos minutos — sua potência média cai para 284 W se forçada a uma janela de 60 min, mas isso não significa que o FTP real caiu; é um artefato de usar uma janela de duração fixa que não coincidiu com o esforço real feito.

Esse problema motivou o desenvolvimento do modelo Potência-Duração (Power Duration Model, ver notas seguintes), que ajusta uma curva contínua aos dados em vez de depender de janelas de duração discretas e fixas.$m569$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;