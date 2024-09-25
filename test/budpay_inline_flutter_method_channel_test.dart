import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:budpay_inline_flutter/budpay_inline_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBudpayInlineFlutter platform =
      MethodChannelBudpayInlineFlutter();
  const MethodChannel channel = MethodChannel('budpay_inline_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
