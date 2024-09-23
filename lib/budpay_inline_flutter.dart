
import 'budpay_inline_flutter_platform_interface.dart';

class BudpayInlineFlutter {
  Future<String?> getPlatformVersion() {
    return BudpayInlineFlutterPlatform.instance.getPlatformVersion();
  }
}
