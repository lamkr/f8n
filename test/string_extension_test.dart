
import 'package:test/test.dart';
import 'package:f8n/extensions.dart';

Future<void> main() async
{
  test('left', () async {
    var text = 'Lorem ipsum dolor sit amet';
    expect(text.left(5), 'Lorem');
  });

  test('right', () async {
    var text = 'Lorem ipsum dolor sit amet';
    expect(text.right(4), 'amet');
  });

  test('mid', () async {
    var text = 'Lorem ipsum dolor sit amet';
    expect(text.mid(6, 5), 'ipsum');
  });
}
