BEGIN;
INSERT INTO skills (id, numero, titulo, dominio_slug, tipo_skill_slug, notas_usadas, confianca_herdada, condicao_nao_calculavel, dados_necessarios, skills_relacionadas, log_de_teste, status, corpo) VALUES (
  $m34422$skill-gerais-ftp-e-zonas$m34422$, $m34423$skill-0004$m34423$, $m34424$FTP (múltiplos métodos) e zonas de potência de Coggan — cálculo, reteste e integridade$m34424$,
  $m34425$metricas-de-potencia$m34425$, $m34426$calculadora+detector$m34426$,
  ARRAY[$m34427$nota-0019$m34427$, $m34428$nota-0020$m34428$, $m34429$nota-0101$m34429$, $m34430$nota-0026$m34430$, $m34431$nota-0079$m34431$, $m34432$nota-0027$m34432$, $m34433$nota-0051$m34433$, $m34434$nota-0022$m34434$, $m34435$nota-0050$m34435$, $m34436$nota-0021$m34436$, $m34437$nota-0143$m34437$, $m34438$nota-0107$m34438$, $m34439$nota-0108$m34439$, $m34440$nota-0076$m34440$, $m34441$nota-0147$m34441$, $m34442$nota-0176$m34442$]::text[],
  $m34443$0.65$m34443$, $m34444$sem nenhum teste de FTP reconhecível no histórico (nem 20min isolado, nem 5+20min) e sem FTP já cadastrado no perfil do atleta → FTP e zonas ficam Ausentes. mFTP calculado por software externo sem confirmação de ≥90 dias de dado consistente → reportar como Estimado, nunca Medido (nota-0027). Potência Crítica calculada com esforços fora da faixa 3-30min → não usar como triangulação confiável (nota-0026), reportar como Ausente para esse método específico. Campo 'Pmax' vindo de dado bruto Strava/Garmin sem confirmação de que corresponde ao Pmax do modelo PDC (e não ao Ppeak do dispositivo) → não reportar como Pmax, reportar como Ppeak com a ressalva da nota-0147.$m34444$,
  $m34445$[]$m34445$::jsonb, $m34446$[{"id": "skill-gerais-tss-sessao", "tipo": "consumida-por"}, {"id": "skill-gerais-forca-e-pedalada", "tipo": "consumida-por"}, {"id": "skill-classificacao-tipo-de-sessao", "tipo": "consumida-por"}]$m34446$::jsonb,
  $m34447$[]$m34447$::jsonb, $m34448$proposto$m34448$, $m34449$## O que faz

Calcula o FTP do atleta a partir de qualquer protocolo de teste reconhecível no histórico (20min isolado, ou 5min+20min combinado), com Potência Crítica e mFTP de software como triangulação secundária — nunca substitutos do teste direto. A partir do FTP vigente, calcula as zonas de potência dos 7 níveis clássicos de Coggan. Também aplica os detectores de integridade que evitam interpretações erradas: reteste desatualizado, efeito gangorra do mFTP, TTE como aviso antecedente, interpolação linear indevida, e confusão entre "Pmax" de dispositivo e o Pmax do modelo PDC.

## Quando usar

- Sempre que uma skill downstream precisar do FTP vigente do atleta e das zonas correspondentes (ex.: `skill-gerais-tss-sessao` para IF/TSS, `skill-gerais-forca-e-pedalada` para as linhas divisórias do Quadrant Analysis, `skill-classificacao-tipo-de-sessao` para tempo-em-zona).
- Ao identificar no histórico uma atividade compatível com um protocolo de teste de FTP (aquecimento padronizado + esforço de 20min, com ou sem o 5min anterior).
- Ao decidir se o FTP cadastrado do atleta está desatualizado e merece sinalização de reteste.

## Passo a passo

1. **Identificar teste reconhecível.** Procurar no histórico recente um padrão compatível com aquecimento padronizado + TT de 20min (nota-0020), com ou sem um esforço máximo de 5min antes (nota-0101).
2. **Calcular FTP do teste:** `FTP = potência média dos 20min × 0,95`. Se houver o esforço de 5min, usá-lo também como medida de potência de VO2máx e comparar contra a faixa clássica 106-120% do FTP resultante — se muito acima (ex. 150%), sinalizar candidato a zonas individualizadas (iLevels), fora do escopo de cálculo desta skill.
3. **Triangulação opcional via Potência Crítica:** se houver ≥3 esforços máximos de 3-30min recentes, ajustar reta de trabalho(J) vs. duração(s) — a inclinação é a CP, comparável ao FTP só se as durações usadas estiverem dentro de 3-30min (nota-0026).
4. **Se houver mFTP de software:** tratar como triangulação adicional. Antes de sinalizar queda, checar se não é efeito da janela móvel de 90 dias "perdendo" um esforço de referência (nota-0027) ou efeito gangorra por reteste parcial só de esforços curtos sem reteste dos longos (nota-0107).
5. **Monitorar tendência do TTE** (tempo até exaustão sustentando o FTP): se estiver subindo em direção a 60min, sinalizar que o FTP provavelmente está subestimado e sugerir reteste; queda do TTE logo após um aumento de FTP é esperada, não é perda de forma (nota-0108).
6. **Checar data do último teste/reestimativa.** Se passaram mais de 6-8 semanas, sinalizar recomendação de reteste (nota-0021, nota-0143).
7. **Calcular as zonas de potência** (7 níveis, Tabela 3.1 — nota-0022) a partir do FTP vigente do passo mais confiável disponível (teste direto > CP > mFTP). Sempre recalcular os limites em watts quando o FTP mudar — nunca usar limites antigos (nota-0050).
8. **(Opcional, se houver histórico de FC)** Estimar FTHR pelo degrau no gráfico de distribuição de tempo por faixa de FC (nota-0051).
9. **Nunca interpolar linearmente** entre dois esforços máximos de durações diferentes para estimar potência-alvo de uma duração intermediária (nota-0076) — se necessário, usar o modelo de curva ajustada ou o dado real mais próximo.
10. **Se algum dado bruto trouxer campo rotulado "Pmax"**, não reportar como Pmax do modelo PDC sem confirmar a origem — por padrão, tratar como Ppeak (pico instantâneo de um ciclo) e sinalizar a ambiguidade (nota-0147, cautela extra por status "revisar").
11. **Ao reportar o FTP ao atleta**, sempre como estimativa funcional de desempenho — nunca como medida fisiológica direta de lactato/metabolismo (nota-0176).
12. **Checar a condição de não-calculável** (ver frontmatter) antes de reportar qualquer número como Medido/Estimado.

## Output

```
{
  "ftp_w": <float>,
  "metodo_ftp": "teste_20min" | "teste_5min_20min" | "potencia_critica" | "mftp_software" | "perfil_cadastrado",
  "data_do_teste": "AAAA-MM-DD",
  "potencia_vo2max_5min_w": <float, null se não aplicável>,
  "sugerir_ilevels": <bool>,
  "fthr_bpm": <float, null se não estimável>,
  "zonas_watts": {
    "nivel_1_recuperacao_ativa": "<até X W>",
    "nivel_2_endurance": "<X-Y W>",
    "nivel_3_tempo": "<X-Y W>",
    "nivel_4_limiar": "<X-Y W>",
    "nivel_5_vo2max": "<X-Y W>",
    "nivel_6_capacidade_anaerobia": "<X-Y W>",
    "nivel_7_potencia_neuromuscular": "sem teto definido"
  },
  "alertas": [
    "reteste_recomendado_6_8_semanas" | "possivel_efeito_gangorra_mftp" | "tte_subindo_ftp_subestimado" | "pmax_ambiguo_verificar_origem" | null
  ],
  "provenance": "Medido" | "Estimado" | "Ausente",
  "motivo_provenance": "<texto, obrigatório se Estimado ou Ausente>",
  "notas_citadas": ["nota-0020", "nota-0022", "nota-0050", "nota-0021", ...]
}
```$m34449$
)
ON CONFLICT (id) DO UPDATE SET numero=excluded.numero, titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, tipo_skill_slug=excluded.tipo_skill_slug, notas_usadas=excluded.notas_usadas, confianca_herdada=excluded.confianca_herdada, condicao_nao_calculavel=excluded.condicao_nao_calculavel, dados_necessarios=excluded.dados_necessarios, skills_relacionadas=excluded.skills_relacionadas, log_de_teste=excluded.log_de_teste, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;