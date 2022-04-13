import 'package:f8n/assets_dart.dart';
import 'package:test/test.dart';

void main()
{
  final IAssets _assets = AssetsDart();

  test('Validate configuration loading from assets', () async {
    final config = await ConfigurationFromAssets.load(_assets);
    expect(config['message'], 'Hello, world!');
  });
}
