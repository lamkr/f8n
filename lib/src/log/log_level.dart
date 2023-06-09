/// Define os níveis de gravidade dos logs.
/// [trace] (0) Logs que contêm as mensagens mais detalhadas. Essas mensagens podem conter dados confidenciais do aplicativo. Essas mensagens são desabilitadas por padrão e nunca devem ser habilitadas em um ambiente de produção.
/// [debug] (1) Logs que são usados para investigação interativa durante o desenvolvimento. Esses logs devem conter principalmente informações úteis para depuração e não têm valor de longo prazo.
/// [info] (2) Logs que rastreiam o fluxo geral do aplicativo. Esses logs devem ter valor de longo prazo.
/// [warn] (3) Logs que realçam um evento anormal ou inesperado no fluxo do aplicativo, mas não fazem com que a execução do aplicativo pare.
/// [error] (4) Logs que realçam quando o fluxo de execução atual é interrompido devido a uma falha. Eles devem indicar uma falha na atividade atual, não uma falha em todo o aplicativo.
/// [critical] (5) Logs que descrevem uma falha irrecuperável do aplicativo ou do sistema ou uma falha catastrófica que exige atenção imediata.
/// [none] (6) Não são usados para gravar mensagens de log. Especifica que uma categoria de log não deve gravar nenhuma mensagem.
enum LogLevel {
  trace,
  debug,
  info,
  warn,
  error,
  critical,
  none
}