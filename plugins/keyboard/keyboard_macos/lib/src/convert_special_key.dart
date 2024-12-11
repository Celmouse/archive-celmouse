import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

class ConvertSpecialKeyMacOS {
  static int toCode(SpecialKeyType key) {
    switch (key) {
      case SpecialKeyType.space:
        return 0x31;
      case SpecialKeyType.backspace:
        return 0x33;
      case SpecialKeyType.shift:
        return 0x56;
      case SpecialKeyType.enter:
        return 0x24;
      default:
        throw UnimplementedError('Not implemented for $key');
    }
  }
}
