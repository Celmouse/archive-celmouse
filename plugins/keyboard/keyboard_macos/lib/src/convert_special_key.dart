import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

class ConvertSpecialKeyMacOS {
  static int toCode(SpecialKeyType key) {
    switch (key) {
      case SpecialKeyType.space:
        return 0x31;
      default:
        throw UnimplementedError('Not implemented for $key');
    }
  }
}
