import 'dart:convert';
import 'package:f8n/services.dart';
import 'package:test/test.dart';
import 'src/user.dart';

void main() {
  test('Load pubspec.yaml from package root dir', () async {
    expect(rootBundle, isNotNull);
  });

  test('Load string from json asset file', () async {
    final assetBundle = PlatformAssetBundle(metadata: 'test/assets');
    final text = await assetBundle.loadString('test/json/user.json');
    expect(text, isNotEmpty);
  });

  test('Load string from not declared asset causes error', () async {
    expect(
        () async =>
            await rootBundle.loadString('test/features/not-exists.feature'),
        throwsException);
  });

  test('Load structured data from json asset file', () async {
    final assets = PlatformAssetBundle(metadata: 'test/assets');
    final user = await assets.loadStructuredData<User>('test/json/user.json',
        (value) => Future.value(User.fromJson(jsonDecode(value))));
    expect(user.name, equals('John Doe'));
    expect(user.age, equals(45));
  });
}
