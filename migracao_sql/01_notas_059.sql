BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8129$nota-0132$m8129$, $m8130$Limitações de NP e TSS em provas de pista curtas/não-pedaladas: NP pouco interpretável em esforços muito curtos; recortar trechos sem pedalada antes de calcular TSS$m8130$, $m8131$metricas-de-potencia$m8131$,
  $m8132$direta$m8132$, $m8133$regra-interpretacao$m8133$,
  ARRAY[$m8134$diario$m8134$]::text[], ARRAY[$m8135$NP$m8135$, $m8136$TSS$m8136$]::text[],
  0.65, $m8137$ativo$m8137$, $m8138$Duas ressalvas importantes ao aplicar métricas padrão a dados de ciclismo de pista:

1. **Normalized Power (NP) pouco interpretável em provas muito curtas:** a maioria das provas de pista tem duração curta demais (segundos a poucos minutos) para que o algoritmo de suavização de 30s da NP (ver notas do Cap.7) produza um valor significativo — a NP foi desenhada para esforços mais longos e variáveis.
2. **TSS pode ser artificialmente inflado por trechos sem pedalada:** ao analisar um arquivo de treino/prova de pista, é necessário **remover (recortar) os trechos em que o atleta não estava pedalando ativamente** antes de calcular o TSS — caso contrário, o TSS calculado sobre a duração total (incluindo tempo parado/rolando) pode superestimar a carga real de treino.

Aplicação ao feedback: para atividades classificadas como pista (ou qualquer atividade curta e intermitente com muitos trechos parados), o sistema deveria (a) evitar apresentar NP como métrica principal para esforços muito curtos, preferindo potência média/pico; (b) usar apenas o tempo efetivamente pedalado (não o tempo decorrido total) no denominador do cálculo de TSS, para evitar subestimar a intensidade real do esforço.$m8138$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8139$nota-0135$m8139$, $m8140$Economia de potência ao pedalar no rastro (draft) em perseguição por equipes: 64-71% da potência do líder$m8140$, $m8141$metricas-de-potencia$m8141$,
  $m8142$contexto$m8142$, $m8143$referencia$m8143$,
  ARRAY[$m8144$diario$m8144$]::text[], ARRAY[$m8145$potência-média$m8145$]::text[],
  0.55, $m8146$ativo$m8146$, $m8147$Dados de pesquisa (Projeto 96, USA Cycling, preparação para as Olimpíadas de Atlanta 1996): em perseguição por equipes de pista, ciclistas nas posições 2ª, 3ª ou 4ª da fila (no rastro/draft) precisam de apenas **64-71% da potência** exigida do líder na ponta.

Aplicação ao feedback: referência de contexto para explicar a economia de energia proporcionada pelo draft em pelotão/echelon — pode ser usada como ordem de grandeza aproximada ao interpretar diferenças de potência entre "puxar" e "descansar na roda" em atividades de grupo, embora o valor exato varie com velocidade, vento e proximidade real do rastro (medido em condições controladas de pista, não necessariamente generalizável a estrada).$m8147$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8148$nota-0139$m8148$, $m8149$Benchmark de Quadrant Analysis em MTB de ultraresistência: ~21% em Quadrante II associado a sucesso; ~75% em Quadrantes III+IV indica boa conservação de energia$m8149$, $m8150$metricas-de-potencia$m8150$,
  $m8151$direta$m8151$, $m8152$referencia$m8152$,
  ARRAY[$m8153$diario$m8153$]::text[], ARRAY[$m8154$potência-série-temporal$m8154$, $m8155$cadência$m8155$]::text[],
  0.55, $m8156$ativo$m8156$, $m8157$Estudo de caso (vitória recorde de Jeremiah Bishop no Shenandoah 100, ~6h51min, TSS 356, NP 274W, FTP 390W): a distribuição por Quadrante de sua prova mostrou **21% do tempo em Quadrante II** (força alta, cadência baixa — típico de MTB em terreno técnico/subidas), o que os autores associam à resistência à fadiga de fibras Tipo II como fator determinante do sucesso; e **quase 75% do tempo em Quadrantes III+IV** (baixa força), confirmando uma boa estratégia geral de conservação de energia ao longo da prova. Nos últimos 36 minutos da prova (esforço final para descolar do 2º colocado), a proporção de tempo em Quadrante II se manteve elevada (~21%), refletindo o esforço de força necessário no ataque final.

Aplicação ao feedback: para atividades de MTB de ultraresistência (>4-5h), esses percentuais (~20% Q2, ~75% Q3+Q4) podem servir como referência aproximada de uma distribuição bem equilibrada entre desenvolvimento de força/resistência a fadiga (Q2) e conservação de energia (Q3/Q4). Nota de contexto: benchmark derivado de um único atleta de elite numa única prova — usar como ordem de grandeza, não como alvo numérico rígido para todos os atletas/perfis de percurso.$m8157$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m8158$nota-0146$m8158$, $m8159$Fórmulas de Pedaling Smoothness (Pavg/Ppeak) e Torque Efficiency (100×(P+−P−)/P+) — métricas bilaterais de pedalada$m8159$, $m8160$metricas-de-potencia$m8160$,
  $m8161$direta$m8161$, $m8162$conceito$m8162$,
  ARRAY[$m8163$diario$m8163$]::text[], ARRAY[$m8164$potência-série-temporal$m8164$, $m8165$cadência$m8165$]::text[],
  0.6, $m8166$ativo$m8166$, $m8167$Duas métricas de pedalada reportadas por medidores de potência bilaterais (comuns em unidades Garmin ANT+):

- **Pedaling Smoothness (PS):** `PS = Potência_média_no_ciclo ÷ Potência_de_pico_no_ciclo`. Um número mais baixo indica um pico de potência muito maior que a média (pedalada "batida"/pouco suave); um número mais alto indica potência mais constante ao longo do ciclo (pedalada mais suave). Exemplo: Pavg=200W, Ppeak=1500W → PS=13%; pedalada mais suave: Pavg=350W, Ppeak=700W → PS=50%.
- **Torque Efficiency (TE):** `TE = 100 × (P+ − P−) / P+`, onde P+ é a potência positiva (fase de propulsão) e P− é a potência negativa (resistência/frenagem, ex.: na fase de subida do pedal) num único ciclo de pedalada. Exemplo: P+=150W, P−=30W → TE = 100×(150−30)/150 = 80%.

Aplicação ao feedback: para atletas com medidor de potência bilateral que reporte essas métricas, o sistema pode usar PS e TE como indicadores complementares de qualidade/eficiência de pedalada, ao lado do GPR/GPA/Kurtotic Index já registrados — útil para recomendações de técnica de pedalada (ex.: baixa TE ou PS pode indicar oportunidade de trabalho técnico específico).$m8167$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;