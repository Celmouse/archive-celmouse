import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

extension SpecialKeyTypeWithCode on SpecialKeyType {
  get code {
    switch (this) {
      case SpecialKeyType.arrowLeft:
        return 123;

      case SpecialKeyType.arrowRight:
        return 124;

      case SpecialKeyType.arrowDown:
        return 125;

      case SpecialKeyType.arrowUp:
        return 126;

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
