BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m33816$skill-classificacao-contexto-atividade$m33816$, $m33817$skill-0016$m33817$, $m33818$Contexto de atividade/modalidade — exceções que mudam a leitura padrão de potência (prova de pelotão, subida/descida, ciclocross, MTB ultra)$m33818$,
  $m33819$tipos-de-treino$m33819$, $m33820$classificador+detector$m33820$,
  ARRAY[$m33821$nota-0046$m33821$, $m33822$nota-0113$m33822$, $m33823$nota-0130$m33823$, $m33824$nota-0137$m33824$, $m33825$nota-0049$m33825$, $m33826$nota-0006$m33826$, $m33827$nota-0039$m33827$]::text[],
  $m33828$0.7$m33828$, $m33829$sem classificação do tipo/modalidade da atividade (prova de pelotão, contrarrelógio, ciclocross, MTB ultraresistência, treino solo) → a maioria dos detectores aqui depende de saber o contexto correto antes de decidir se uma exceção se aplica; sem essa classificação, reportar Ausente e usar a leitura padrão (sem aplicar nenhuma das exceções desta skill). Sem perfil de elevação disponível, a assimetria subida/descida (nota-0113) não pode ser confirmada como efeito natural do terreno — não presumir a exceção sem o dado.$m33829$,
  $m33830$[{"campo": "classificacao_modalidade", "tipo": "manual", "obrigatorio": "false", "fonte": "declaração do atleta ou inferência do tipo de prova/atividade (pelotão, CRI, ciclocross, MTB ultra)", "observacao": "sem isso, usar leitura padrão sem aplicar exceções"}, {"campo": "perfil_elevacao", "tipo": "bruto", "obrigatorio": "false", "fonte": "Strava: altimetria da atividade", "observacao": "sem isso, assimetria subida/descida não pode ser confirmada como efeito do terreno"}, {"campo": "potencia_serie_temporal", "tipo": "bruto", "obrigatorio": "true", "fonte": "stream de potência da atividade"}]$m33830$::jsonb, $m33831$[{"id": "skill-classificacao-tipo-de-sessao", "tipo": "complementar"}, {"id": "skill-subida-pacing", "tipo": "complementar"}]$m33831$::jsonb,
  $m33832$[]$m33832$::jsonb, $m33833$proposto$m33833$, $m33834$## O que faz

Reconhece contextos e modalidades específicas de atividade que alteram a leitura padrão de um arquivo de potência: o padrão de 3 fases da "jogada vencedora" em prova de pelotão, a assimetria natural subida/descida (não é erro de pacing), a potência mais baixa esperada em ciclocross, a inversão da lógica de pacing conservador em MTB de ultraresistência (Efeito Allen), e o sinal de posicionamento subótimo pelo percentual de tempo pedalando numa prova de pelotão.

## Quando usar

- Ao analisar o arquivo de potência de uma prova (não um treino estruturado solo), antes de aplicar heurísticas de pacing genéricas.
- Ao identificar que a atividade tem perfil de elevação significativo, ou está classificada como ciclocross, ou como MTB de ultraresistência.
- Antes de sinalizar automaticamente "erro de pacing" a partir de picos de potência isolados.

## Passo a passo

1. **Prova de pelotão com destaque/fuga**: procurar o padrão de 3 fases da jogada vencedora — ataque inicial (~200% do FTP em média por ~30s, pico ~300% do FTP) → esforço elevado contínuo estabilizando perto de 100-110% do FTP → arremate final (pico curto de potência/velocidade no sprint). Usar para nomear e explicar taticamente o momento decisivo de uma prova (nota-0046).
2. **Percurso com desnível significativo**: não sinalizar automaticamente picos de potência acima do FTP em trechos de subida como erro de pacing — isso é esperado (mais resistência para empurrar contra) e naturalmente compensado pela queda de potência na descida seguinte (cai a ~55% do FTP mesmo com esforço máximo, por limitação de marcha). Focar a análise de pacing no IF/NP/VI da prova inteira, não em picos isolados correlacionados ao perfil de elevação (nota-0113).
3. **Atividade classificada como ciclocross**: não aplicar o limiar padrão "potência média baixa = esforço fraco" — médias 20-40W abaixo do FTP são normais (tempo sem pedalar em descidas técnicas/carregando a bike, perda de tração em barro/areia). Ao contar "matches" (picos acima do FTP), lembrar que a base de esforço já está perto do FTP na maior parte da prova — mesmo picos de amplitude menor podem ser esforços significativos (nota-0130).
4. **Atividade classificada como MTB de ultraresistência** (ou prova offroad longa sem pelotão/draft real após os primeiros ~15min): inverter a lógica de pacing conservador desenvolvida para contrarrelógio de estrada — não sinalizar início forte como erro. O Efeito Allen mostra que acelerar antes de um trecho rápido do percurso cria um gap de distância que os concorrentes atrás dificilmente conseguem fechar, mesmo que o gap de tempo permaneça constante (nota-0137).
5. **Prova de pelotão (mass-start)**: calcular o percentual de tempo pedalando (`tempo-movimento / tempo-decorrido`). Se ultrapassar 85%, sinalizar como hipótese de posicionamento subótimo no pelotão (gastando energia à toa em vez de aproveitar a roda de outros) a investigar no feedback pós-prova — este sinal é irrelevante para treino solo/estruturado, onde o objetivo já é outro (nota-0049).
6. **Classificar ambiente indoor vs. outdoor** antes de interpretar VI ou aderência a intervalo: treino indoor (rolo/smart trainer) produz potência muito mais estável (VI mais baixo) por ausência de vento/terreno/trânsito — um VI mais baixo indoor não indica melhor pacing, é efeito do ambiente controlado (nota-0006). Outdoor, a potência instantânea é estocástica por natureza (pode saltar de 500W para 0W em segundos) — avaliar aderência a um intervalo prescrito contra uma faixa-alvo (ex.: 300-320W), nunca contra um valor exato; indoor, um alvo mais preciso é esperável dado o ambiente controlado (nota-0039).
7. **Checar a condição de não-calculável** (ver frontmatter) antes de aplicar qualquer uma das exceções acima.

## Output

```
{
  "modalidade_contexto": "prova_peloton" | "contrarrelogio" | "ciclocross" | "mtb_ultraresistencia" | "treino_solo" | "indeterminado",
  "ambiente": "indoor" | "outdoor" | "indeterminado",
  "jogada_vencedora_detectada": {"fase_ataque": <bool, null>, "fase_sustentacao": <bool, null>, "fase_sprint_final": <bool, null>},
  "assimetria_subida_descida_explicada_por_terreno": <bool, null>,
  "pct_tempo_pedalando": <float, null>,
  "alertas": [
    "picos_subida_nao_sao_erro_pacing" | "potencia_media_baixa_normal_ciclocross" | "efeito_allen_inicio_forte_valido" | "posicionamento_subotimo_pct_pedalando_acima_85" | "vi_baixo_efeito_indoor_nao_pacing_superior" | "avaliar_aderencia_por_faixa_nao_valor_exato_outdoor" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0046", "nota-0113", "nota-0130", "nota-0137", "nota-0049", "nota-0006", "nota-0039"]
}
```$m33834$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;