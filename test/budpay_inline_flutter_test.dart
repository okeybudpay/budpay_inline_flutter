import 'package:flutter_test/flutter_test.dart';
// import 'package:budpay_inline_flutter/budpay_inline_flutter.dart';
import 'package:budpay_inline_flutter/budpay_inline_flutter_platform_interface.dart';
import 'package:budpay_inline_flutter/budpay_inline_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBudpayInlineFlutterPlatform
    with MockPlatformInterfaceMixin
    implements BudpayInlineFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BudpayInlineFlutterPlatform initialPlatform = BudpayInlineFlutterPlatform.instance;

  test('$MethodChannelBudpayInlineFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBudpayInlineFlutter>());
  });

  test('getPlatformVersion', () async {
    // BudpayInlineFlutter budpayInlineFlutterPlugin = BudpayInlineFlutter();
    MockBudpayInlineFlutterPlatform fakePlatform = MockBudpayInlineFlutterPlatform();
    BudpayInlineFlutterPlatform.instance = fakePlatform;

    // expect(await budpayInlineFlutterPlugin.getPlatformVersion(), '42');
  });
}
