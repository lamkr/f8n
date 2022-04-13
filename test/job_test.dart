import 'dart:async';

import 'package:f8n/src/job/Job.dart';
import 'package:test/test.dart';

Future main() async
{
  test('Dado um job que roda a cada 1 segundo \n'
  'E configurado para parar em 5 segundos \n'
  'Quando ele for iniciado \n'
  'Então ele tem que parar após 5 segundos.', () async
  {
    final delay = Duration(seconds: 1);
    final stopAfter = Duration(seconds: 5);
    var sucesso = false;
    var job = Job(delay: delay, stopAfter: stopAfter, workFunction: (job) {
      if( job.workCount == 3 ) {
        sucesso = true;
      }
    });
    job.start();

    await isWorking(job);

    expect(sucesso, isTrue);
  } );

  test('Dado um job que roda a cada 1 segundo \n'
  'Quando seu work programado para cancelar o job no terceira contagem\n '
  'Então ele deve parar.', () async
  {
    final delay = Duration(seconds: 1);
    var job = Job(delay: delay, workFunction: (job) {
      if( job.workCount == 3 ) {
        job.stop();
      }
    });
    job.start();

    await isWorking(job);

    expect(job.workCount == 3, isTrue);
  } );

  test('Dado um job que roda a cada 1 segundo \n'
  'Quando ele for parado\n '
  'E iniciado\n '
  'Então deve continuar trabalhando normalmente.', () async
  {
    final delay = Duration(milliseconds: 100);
    var job = Job(delay: delay);

    job.start();
    await Future.delayed(Duration(seconds: 2));
    job.stop();
    await Future.delayed(Duration(seconds: 2));
    job.start();
    await Future.delayed(Duration(seconds: 2));
    job.stop();

    expect(job.workCount > 5, isTrue);
  } );
}

Future isWorking(Job job) {
  if(job.isNotWorking) {
    return Future.value(false);
  }
  return Future.delayed(Duration(seconds: 1), () => isWorking(job));
}
