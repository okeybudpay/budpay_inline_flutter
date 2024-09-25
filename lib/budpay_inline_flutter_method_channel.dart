import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'budpay_inline_flutter_platform_interface.dart';

/// An implementation of [BudpayInlineFlutterPlatform] that uses method channels.
class MethodChannelBudpayInlineFlutter extends BudpayInlineFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('budpay_inline_flutter');

  /// Retrieves the platform version from the native platform.
  ///
  /// Returns a [String] containing the platform version.
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
