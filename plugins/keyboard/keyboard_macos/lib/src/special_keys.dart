import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

extension SpecialKeyTypeWithCode on SpecialKeyType {
  get code {
    switch (this) {
      /// FN
      case SpecialKeyType.fn:
        return 63;

      /// VOLUMES
      case SpecialKeyType.volumeUp:
        return 72;

      case SpecialKeyType.volumeDown:
        return 73;

      case SpecialKeyType.volumeMute:
        return 74;

      /// ARROWS
      case SpecialKeyType.arrowLeft:
        return 123;

      case SpecialKeyType.arrowRight:
        return 124;

      case SpecialKeyType.arrowDown:
        return 125;

      case SpecialKeyType.arrowUp:
        return 126;

      /// SPECIAL KEYS
      case SpecialKeyType.space:
        return 49;
      case SpecialKeyType.backspace:
        return 51;
      case SpecialKeyType.shift:
        return 56;
      case SpecialKeyType.enter:
        return 36;
      default:
        throw UnimplementedError('Not implemented for $this');
    }
  }
}
