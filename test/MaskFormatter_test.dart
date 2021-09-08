import 'package:f8n/extensions.dart';
import 'package:test/test.dart';

Future<void> main() async
{
  test('MaskFormatter with empty text', () async {
    final text = '';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '');
  });

  test('MaskFormatter with partial invalid text', () async {
    final text = 'ABC';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '');
  });

  test('MaskFormatter with partial text', () async {
    final text = '731';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '731');
  });

  test('MaskFormatter with partial text 2', () async {
    final text = '7311';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '731.1');
  });

  test('MaskFormatter with valid text', () async {
    final text = '73119202991';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '731.192.029-91');
  });

  test('MaskFormatter with valid text', () async {
    final text = 'A7B3C1D1E9F2G0H2I9J9K1';
    final mask = '###.###.###-##';
    final format = MaskFormatter(mask);
    final formatted = format.format(text);
    expect(formatted, '7.31.1-9');
  });
}
