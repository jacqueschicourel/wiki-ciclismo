BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34106$skill-entrega-redacao-atleta$m34106$, $m34107$skill-0026$m34107$, $m34108$Redação ao atleta — transformar a lista curada (diária/semanal/mensal) em mensagem final sem jargão, formatada pro canal (WhatsApp ou e-mail)$m34108$,
  $m34109$entrega-feedback$m34109$, $m34110$redator$m34110$,
  '{}'::text[],
  $m34111$herda diretamente a confianca_herdada/provenance da curadoria de origem (skill-0023, skill-0024 ou skill-0025) — a redação nunca pode ser mais confiável do que a lista que recebeu, e nunca inventa conteúdo que a curadoria não selecionou$m34111$, $m34112$sem uma lista de pontos_selecionados vinda de uma das 3 curadorias (skill-0023/0024/0025) → nada a escrever, reportar Ausente. Se a lista curada veio com provenance=Ausente (ex.: sessão sem dado suficiente), a mensagem final deve refletir isso de forma simples e curta ('não consegui puxar dados suficientes hoje'), nunca inventar conteúdo pra preencher o vazio.$m34112$,
  $m34113$[{"campo": "pontos_selecionados", "tipo": "calculado", "obrigatorio": "true", "fonte": "skill-entrega-curadoria-diaria, skill-entrega-curadoria-semanal ou skill-entrega-curadoria-mensal, conforme a cadência"}, {"campo": "canal", "tipo": "manual", "obrigatorio": "true", "fonte": "declarado pelo chamador: 'whatsapp' ou 'email'"}, {"campo": "cadencia", "tipo": "manual", "obrigatorio": "true", "fonte": "declarado pelo chamador: 'diario', 'semanal' ou 'mensal' — usado só pra saudação/tom, não muda o conteúdo (isso já veio pronto da curadoria)"}, {"campo": "nome_atleta", "tipo": "manual", "obrigatorio": "false", "fonte": "perfil do atleta", "observacao": "sem isso, usar saudação genérica"}]$m34113$::jsonb, $m34114$[{"id": "skill-entrega-curadoria-diaria", "tipo": "pre-requisito"}, {"id": "skill-entrega-curadoria-semanal", "tipo": "pre-requisito"}, {"id": "skill-entrega-curadoria-mensal", "tipo": "pre-requisito"}]$m34114$::jsonb,
  $m34115$[]$m34115$::jsonb, $m34116$proposto$m34116$, $m34117$## O que faz

É a única camada que **fala com o atleta**. Recebe a lista curada (3-4 pontos, já filtrados e priorizados por uma das 3 skills de curadoria) e escreve a mensagem final — curta, sem jargão técnico solto, formatada pro canal certo. Não decide o quê dizer (isso já veio pronto), só decide **como** dizer.

## Quando usar

- Sempre depois de uma das 3 curadorias (`skill-entrega-curadoria-diaria`, `-semanal` ou `-mensal`) já ter rodado.
- Uma vez por entrega — se o mesmo conteúdo precisa sair em WhatsApp e e-mail (caso do semanal/mensal), rodar esta skill 2 vezes, uma por canal, nunca reaproveitar o texto de um canal pro outro sem reformatar.

## Passo a passo

1. **Ler a lista curada** (`pontos_selecionados`) e a `provenance` dela — se `Ausente`, ir direto para a mensagem-fallback curta (ver `condicao_nao_calculavel`).
2. **Classificar cada número em 2 camadas antes de decidir como tratá-lo**:
   - **Camada A — o atleta já entende, citar direto, sem precisar "traduzir"**: FC (bpm), IF, zonas de potência/FC, FTP, cadência (rpm). São métricas que o atleta já usa no dia a dia (no relógio, no app) e tem intuição própria sobre o que é alto/baixo/normal — preferir estas sempre que o `resumo_tecnico` permitir.
   - **Camada B — jargão agregado/abstrato, sempre traduzir ou substituir por leitura qualitativa**: TSS, NP, VI, CTL/ATL/TSB, W/kg calculado, kJ. Todo número desta camada que sobreviver precisa vir com um equivalente em linguagem simples na primeira (e única) menção — ex.: "carga de 266 (pesada pro teu padrão)", nunca "TSS=266" sozinho. Se a tradução não for possível sem distorcer o número, preferir omitir e manter só a leitura qualitativa.
3. **Relacionar números da Camada A com a altimetria/perfil de elevação da sessão sempre que a curadoria tiver essa correlação disponível** (ganho de elevação, trecho de subida/descida) — essa é a ponte mais natural entre número e experiência vivida: o atleta lembra da subida, não lembra do "VI". Ex.: "16% do tempo em zona alta, reflexo direto da subida de 1.800m" é mais concreto que "16% em zona 5-7" sozinho.
4. **Ordenar as frases pela `ordem` da lista curada** — alerta de segurança sempre primeiro, se existir.
5. **Formatar pelo canal**:
   - **WhatsApp**: 3-5 frases corridas, tom direto de treinador mandando mensagem rápida, sem saudação formal nem assinatura, sem bullet points, sem seções. Até 4-5 números no total, priorizando a Camada A (FC/IF/zonas/FTP/cadência, especialmente quando relacionados à altimetria) sobre a Camada B — a Camada A pode aparecer mais de uma vez porque é mais leve de processar; a Camada B fica limitada a 1 número por mensagem, sempre traduzido.
   - **E-mail**: `assunto_email` de 1 linha resumindo o ponto mais importante, saudação curta, corpo em 1-2 parágrafos curtos (ou até 3-4 marcadores leves só se a cadência for semanal/mensal com vários pontos), fechamento breve. Mesma priorização Camada A > Camada B do WhatsApp — e-mail não é licença pra ficar técnico, só pra ter um pouco mais de estrutura.
6. **Ajustar a saudação/abertura pela cadência** (não o conteúdo, que já veio da curadoria): diário = direto ("Vi o treino de hoje..."); semanal = resumo ("Fechando a semana..."); mensal = mais reflexivo ("Olhando o mês...").
7. **Nunca escrever uma frase que não mapeie a um `ponto_selecionado` da lista recebida** — toda frase da mensagem final precisa aparecer em `rastreamento_frase_para_ponto` no output, exatamente como a auditoria de rastreabilidade do pipeline principal exige (passo 7 de `skill-analisar-treino-lrf`).
8. **Checar a condição de não-calculável** (ver frontmatter) antes de entregar.

## Output

```
{
  "canal": "whatsapp" | "email",
  "cadencia": "diario" | "semanal" | "mensal",
  "assunto_email": "<string, null se whatsapp>",
  "mensagem_final": "<texto>",
  "rastreamento_frase_para_ponto": [
    {"frase": "<trecho da mensagem_final>", "ponto_selecionado_ordem": <int>, "fonte_skill": "skill-00XX"}
  ],
  "provenance": "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Ausente>",
  "notas_citadas": []
}
```$m34117$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;