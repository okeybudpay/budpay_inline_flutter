import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'budpay_inline_flutter_method_channel.dart';

/// The interface that implementations of budpay_inline_flutter must implement.
///
/// Platform-specific implementations should extend this class
/// rather than implement it directly.
abstract class BudpayInlineFlutterPlatform extends PlatformInterface {
  /// Constructs a [BudpayInlineFlutterPlatform].
  BudpayInlineFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BudpayInlineFlutterPlatform _instance =
      MethodChannelBudpayInlineFlutter();

  /// The default instance of [BudpayInlineFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBudpayInlineFlutter].
  static BudpayInlineFlutterPlatform get instance => _instance;

  /// Sets the default instance of [BudpayInlineFlutterPlatform].
  ///
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BudpayInlineFlutterPlatform] when
  /// they register themselves.
  static set instance(BudpayInlineFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the platform version as a string.
  ///
  /// This method should be overridden by platform-specific implementations
  /// to provide the platform version.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }
}
