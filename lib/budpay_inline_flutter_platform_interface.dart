import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'budpay_inline_flutter_method_channel.dart';

abstract class BudpayInlineFlutterPlatform extends PlatformInterface {
  /// Constructs a BudpayInlineFlutterPlatform.
  BudpayInlineFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BudpayInlineFlutterPlatform _instance = MethodChannelBudpayInlineFlutter();

  /// The default instance of [BudpayInlineFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBudpayInlineFlutter].
  static BudpayInlineFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BudpayInlineFlutterPlatform] when
  /// they register themselves.
  static set instance(BudpayInlineFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
