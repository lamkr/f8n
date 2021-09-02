import 'dart:async';

typedef WorkFunction = void Function(Job job);

class Job
{
  static const oneMinute = Duration(minutes: 1);
  static const neverStop = Duration(seconds: 0);

  final Stopwatch _stopWatch = Stopwatch();
  final Duration delay, stopAfter;

  int _workCount = 0;
  Timer? _timer;
  bool _isWorking = false;

  WorkFunction? workFunction;

  Job({this.delay=oneMinute, this.stopAfter=neverStop, this.workFunction});

  void start() {
    if( isWorking ) {
      return;
    }
    _isWorking = true;
    _stopWatch.start();
    _firstRun();
  }

  void _firstRun() {
    Future.delayed(Duration(seconds: 0), () =>
      workFunction != null ? workFunction!(this) : work());
    Timer.periodic(delay, (Timer timer) {
      _timer = timer;
      if( _isNotTimeLimitReached() ) {
        _workCount++;
        if(workFunction != null) {
          workFunction!(this);
        }
        else {
          work();
        }
      }
      else {
        stop();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _stopWatch.stop();
    _isWorking = false;
  }

  void dispose() {
    stop();
  }

  bool get isWorking => _isWorking;

  bool get isNotWorking => !isWorking;

  bool _isNotTimeLimitReached() {
    if( stopAfter.inSeconds > 0 ) {
      return _stopWatch.elapsed.inSeconds < stopAfter.inSeconds;
    }
    return true;
  }

  /// Número de vezes que o work foi executado.
  int get workCount => _workCount;

  /// Método que o job irá executar no tempo para o qual foi configurado
  /// caso o atributo [workFunction] não tenha sido especificado no construtor.
  void work() {}
}
