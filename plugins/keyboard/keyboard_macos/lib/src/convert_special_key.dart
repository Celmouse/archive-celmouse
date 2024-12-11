import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

class ConvertSpecialKeyMacOS implements ConvertSpecialKey {
  @override
  int toCode(SpecialKey key) {
    switch (key) {
      case SpecialKey.space:
        return 0x31;
      default:
        return 0x00;
    }
  }

  @override
  SpecialKey toEnum(int code) {
    switch (code) {
      case 0x31:
        return SpecialKey.space;
      default:
        return SpecialKey.none;
    }
  }
}
