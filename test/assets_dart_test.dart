import 'package:f8n/assets_dart.dart';
import 'package:test/test.dart';

void main() {

  IAssets _assets = AssetsDart();

  test('Load text', () async {
    final text = await _assets.loadText('lorem.txt');
    expect(text, isNotEmpty);
  });

  test('Load text from URI', () async {
    final uri = Uri.parse('assets/lorem.txt');
    final text = await _assets.loadTextFromUri(uri);
    expect(text, isNotEmpty);
  });

  test('Load text from relative path', () async {
    final path = 'assets/lorem.txt';
    final text = await _assets.loadTextFromRelativePath(path);
    expect(text, isNotEmpty);
  });

}
