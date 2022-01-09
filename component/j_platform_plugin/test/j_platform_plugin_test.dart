import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_platform_plugin/j_platform_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('j_platform_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 42;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('refreshRate', () async {
    expect(await JPlatformPlugin.refreshRate, 60);
  });
}
