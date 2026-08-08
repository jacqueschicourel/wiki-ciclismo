BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m129$nota-0004$m129$, $m130$Filosofia \"treino é teste, teste é treino\": testes periódicos para rastrear sistemas fisiológicos$m130$, $m131$avaliacao-e-testes$m131$,
  $m132$contexto$m132$, $m133$conceito$m133$,
  ARRAY[$m134$mensal$m134$]::text[], '{}'::text[],
  0.75, $m135$ativo$m135$, $m136$Os autores propõem tratar praticamente qualquer sessão de treino monitorada por potência como uma oportunidade de teste, e todo teste como uma forma de treino ("training is testing; testing is training"). A ideia central é usar avaliações periódicas (o texto sugere uma cadência mensal como exemplo) para verificar quantitativamente quais sistemas fisiológicos estão melhorando e quais ainda precisam de foco, permitindo tanto ajustar o plano de treino quanto evitar overtraining ao acompanhar a evolução real da forma física ao longo do tempo.

Nota: esta é uma orientação filosófica/metodológica geral do livro, não um protocolo de teste específico (protocolos concretos de teste de campo/laboratório são tratados em capítulos posteriores) — por isso `aplicacao: contexto`.$m136$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m137$nota-0017$m137$, $m138$Marcar início/fim de cada intervalo (lap/interval button) para obter a média de potência precisa por trecho$m138$, $m139$avaliacao-e-testes$m139$,
  $m140$direta$m140$, $m141$protocolo$m141$,
  ARRAY[$m142$diario$m142$]::text[], ARRAY[$m143$potência-por-lap$m143$, $m144$tempo-decorrido$m144$]::text[],
  0.8, $m145$ativo$m145$, $m146$Protocolo de registro: marcar o botão de volta/intervalo (lap) exatamente no início e no fim de cada intervalo de treino permite calcular a potência média (e outras métricas) daquele trecho específico com precisão, isolando-o do restante da atividade (aquecimento, recuperação entre séries, etc.). Para intervalos com sub-estrutura interna (ex.: microbursts, esforços crisscross), marcar apenas o início e o fim do intervalo maior, não cada sub-mudança de intensidade dentro dele — isso preserva a média do esforço completo para fins de comparação entre sessões.

Aplicação ao feedback: quando os dados de uma atividade têm marcações de lap, usar essas marcações para calcular e comparar a potência média de cada intervalo prescrito, em vez de médias sobre a atividade inteira ou sobre janelas de tempo arbitrárias.$m146$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m147$nota-0020$m147$, $m148$Protocolo de teste de campo de FTP (20 minutos) com fator de correção de 5%$m148$, $m149$avaliacao-e-testes$m149$,
  $m150$direta$m150$, $m151$protocolo$m151$,
  ARRAY[$m152$mensal$m152$]::text[], ARRAY[$m153$potência-média$m153$, $m154$FTP$m154$]::text[],
  0.9, $m155$ativo$m155$, $m156$Protocolo (desenvolvido por Hunter Allen) para estimar FTP sem precisar de um teste de 60 minutos:

1. Aquecimento padronizado — sempre o mesmo, terminando com intervalos de pedalada rápida.
2. Aquecimento/recuperação a ~65% do FTP (ritmo Endurance).
3. Esforço máximo de 5 minutos ("all-out", mas guardando um pouco de reserva) — abre as pernas, recruta a potência de VO2máx (Nível 5) e reduz a influência da capacidade aeróbia no teste seguinte.
4. Contrarrelógio (time trial) de 20 minutos em ritmo forte e constante, evitando começar rápido demais; idealmente em subida constante ou contra vento leve para forçar esforço máximo sustentado.
5. **Fórmula: FTP estimado = potência média dos 20 minutos × 0,95** (ou seja, subtrai-se 5% da potência média). Exemplo do livro: 305 W médios no TT de 20 min → 305 × 0,05 = 15,25 → 305 − 15,25 = 290 W de FTP estimado.

O fator de correção de 5% existe porque 20 minutos é mais curto que a "janela" real de ~60 min do FTP, incorporando mais capacidade anaeróbia e superestimando a potência de limiar em ~5% em média. Esse fator não é fixo: atletas com maior capacidade anaeróbia podem precisar subtrair 7% ou mais; atletas predominantemente aeróbios podem precisar subtrair só 2–3%. Deve ser feito sempre no mesmo trecho de estrada (ou rolo), horário do dia e condições climáticas semelhantes, minimizando influências externas (estresse, sono) para permitir comparação válida entre testes.

Aplicação ao feedback: ao identificar no Strava uma atividade compatível com este protocolo (aquecimento padronizado + esforço de 5min + contrarrelógio de 20min), calcular o FTP estimado automaticamente a partir da potência média dos 20 minutos menos 5%, e usar esse valor para atualizar as zonas de treino do atleta.$m156$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m157$nota-0021$m157$, $m158$Frequência recomendada de reteste de FTP: a cada 6–8 semanas (6–8 vezes por ano)$m158$, $m159$avaliacao-e-testes$m159$,
  $m160$direta$m160$, $m161$regra-interpretacao$m161$,
  ARRAY[$m162$mensal$m162$]::text[], ARRAY[$m163$FTP$m163$]::text[],
  0.85, $m164$ativo$m164$, $m165$Recomendação dos autores: reavaliar o FTP a cada 6–8 semanas, o que equivale a cerca de 6–8 vezes ao ano. Momentos sugeridos: no meio do treino de inverno, no início do treino sério ao ar livre (linha de base), no meio do período pré-competitivo, algumas vezes durante a temporada de competição (para determinar o pico de forma) e depois do pico, para medir o quanto a forma "caiu".

Nuance de aplicação: iniciantes ou atletas retornando de pausa longa tendem a mostrar mudanças de FTP grandes e rápidas; atletas experientes ou que mantêm condicionamento alto o ano todo tendem a mostrar variação bem menor entre testes — a expectativa de quanto o FTP deve mudar entre reavaliações deve ser calibrada pelo histórico de treino do atleta.

Aplicação ao feedback: verificar a data do último teste de FTP do atleta (ou da última reestimativa via IF/NP de prova) e, se já passaram mais de 6-8 semanas, sinalizar a recomendação de um novo teste antes de basear zonas/TSS em um FTP potencialmente desatualizado.$m165$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;