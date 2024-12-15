import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';

extension SpecialKeyTypeWithCode on SpecialKeyType {
  get code {
    switch (this) {
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
