import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

class ConvertSpecialKeyMacOS {
  static int toCode(SpecialKeyType key) {
    switch (key) {
      case SpecialKeyType.space:
        return 49;
      case SpecialKeyType.backspace:
        return 51;
      case SpecialKeyType.shift:
        return 56;
      case SpecialKeyType.enter:
        return 36;
      default:
        throw UnimplementedError('Not implemented for $key');
    }
  }
}
