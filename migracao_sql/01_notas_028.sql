BEGIN;
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3375$nota-0254$m3375$, $m3376$Protocolo de aclimatização ao calor: maior parte do ganho na 1ª semana, exige apenas 2-4h/dia de exposição, e capacidade de sudorese quase dobra em 10 dias$m3376$, $m3377$fisiologia$m3377$,
  $m3378$direta$m3378$, $m3379$protocolo$m3379$,
  ARRAY[$m3380$semanal$m3380$, $m3381$mensal$m3381$]::text[], ARRAY[$m3382$temperatura$m3382$, $m3383$tempo-movimento$m3383$]::text[],
  0.75, $m3384$ativo$m3384$, $m3385$**Protocolo de aclimatização ao calor** (McArdle): a maior parte da adaptação ocorre já na **primeira semana** de exposição ao calor combinada com exercício, exigindo apenas **2 a 4 horas de exposição por dia** (não precisa ser contínua nem em alta intensidade). As primeiras sessões devem ser leves — **15 a 20 minutos de atividade de baixa intensidade** — com duração e intensidade aumentando progressivamente nas sessões seguintes. Aclimatização plena tipicamente demora cerca de **10 dias**.

Principais ganhos fisiológicos mensuráveis com a aclimatização (Tabela 25.5 do livro):
- **Capacidade de sudorese quase dobra após 10 dias** de exposição ao calor — este é o fator mais significativo da aclimatização.
- Suor fica mais diluído (menor perda de sódio) e se distribui mais uniformemente pela pele.
- Limiar para início da sudorese cai (sudorese começa mais cedo no exercício).
- FC e temperaturas de pele/core mais baixas para o mesmo exercício submáximo.
- Menor dependência de carboidrato como substrato durante o exercício (poupança de glicogênio).
- Débito cardíaco melhor distribuído, com maior estabilidade de pressão arterial durante o esforço.

**Os benefícios da aclimatização se dissipam em 2 a 3 semanas** após o retorno a um ambiente mais ameno — ou seja, é um estado transitório que precisa ser mantido por exposição repetida.

Aplicação ao feedback: se o histórico do atleta no Strava mostrar exposição repetida a `temperatura` elevada (múltiplas atividades em dias quentes) ao longo de ~10-14 dias, o sistema pode inferir que o atleta está total ou parcialmente aclimatizado ao calor e ajustar as expectativas de FC/decoupling para dias quentes subsequentes (menos penalização). Inversamente, se o atleta não treinou em calor nas últimas 2-3 semanas (gap de `tempo-movimento` em `temperatura` alta), o sistema deve tratá-lo como não aclimatizado e reforçar avisos de hidratação/ritmo mais conservador na primeira sessão quente após esse intervalo.$m3385$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
INSERT INTO notas (id, titulo, dominio_slug, aplicacao_slug, tipo_nota_slug, camadas, sinais, confianca, status, corpo) VALUES (
  $m3386$nota-0256$m3386$, $m3387$Cada litro de desidratação por suor eleva a FC de exercício em ~8 bpm e reduz o débito cardíaco em ~1 L/min; 1% de perda de massa corporal já eleva a temperatura retal$m3387$, $m3388$fisiologia$m3388$,
  $m3389$direta$m3389$, $m3390$regra-interpretacao$m3390$,
  ARRAY[$m3391$diario$m3391$]::text[], ARRAY[$m3392$temperatura$m3392$, $m3393$FC (média/máx)$m3393$, $m3394$decoupling (Pw:Hr)$m3394$]::text[],
  0.55, $m3395$ativo$m3395$, $m3396$Dado quantificado (McArdle) sobre o efeito da desidratação induzida por suor na resposta cardiovascular durante exercício: **para cada litro de perda de suor (desidratação), a FC de exercício sobe cerca de 8 batimentos/minuto**, acompanhada de uma **queda de aproximadamente 1,0 L/min no débito cardíaco**. Isso ocorre porque grande parte da água perdida por suor vem do volume plasmático, reduzindo progressivamente a capacidade circulatória.

Além disso, mesmo uma perda de fluido muito pequena — equivalente a apenas **1% da massa corporal** — já é suficiente para elevar a temperatura retal em comparação com o mesmo exercício em estado de hidratação normal.

Esse mecanismo é uma segunda via (além do calor per se, nota-0239) pela qual a deriva cardíaca/decoupling (Pw:Hr) se manifesta em sessões longas: a combinação de perda de suor acumulada + calor ambiente eleva a FC para a mesma potência ao longo do tempo, mesmo sem fadiga muscular real.

Aplicação ao feedback: ao detectar decoupling elevado (FC subindo para a mesma potência) numa atividade longa, cruzar com `temperatura` e duração/`tempo-movimento` para estimar se desidratação é uma causa provável — sessões longas (>1,5-2h) em `temperatura` alta com decoupling acentuado sugerem hidratação insuficiente, não necessariamente perda de fitness ou fadiga muscular. Como regra grosseira de ordem de grandeza: se o decoupling observado for compatível com uma subida de FC de ~8 bpm ou mais ao longo da sessão em condições quentes, isso é consistente com desidratação de ~1L, reforçando a recomendação de hidratação mais agressiva em treinos futuros semelhantes.

**Nota sobre o limiar de duração (2026-08-02):** o ">1,5-2h" é estimativa editorial desta nota, não citação literal de McArdle (o trecho-fonte só quantifica 8bpm/L e 1% de massa corporal, sem número de duração). A literatura geral de deriva cardíaca (cardiac drift) mostra que o fenômeno começa bem mais cedo, por volta de 10-15min de exercício em carga constante — mas esse início precoce é predominantemente termorregulatório/redistribuição de fluxo sanguíneo, não atribuível especificamente à desidratação. O limiar mais longo aqui (>1,5-2h) é a estimativa de quanto tempo leva para acumular perda de suor suficiente (segundo a regra de 8bpm/L desta mesma nota) para que a desidratação — e não o drift térmico geral — vire a explicação mais provável do decoupling observado. Confiança rebaixada (0,65→0,55) por essa indireção (o limiar de duração é inferido, não medido/citado diretamente).$m3396$
)
ON CONFLICT (id) DO UPDATE SET titulo=excluded.titulo, dominio_slug=excluded.dominio_slug, aplicacao_slug=excluded.aplicacao_slug, tipo_nota_slug=excluded.tipo_nota_slug, camadas=excluded.camadas, sinais=excluded.sinais, confianca=excluded.confianca, status=excluded.status, corpo=excluded.corpo, atualizado_em=now();
COMMIT;