import 'package:controller/src/UI/keyboard/keyboard_service.dart';

class KeyboardRepository {
  final KeyboardService _keyboardService;

  KeyboardRepository(this._keyboardService);

  void type(String text) {
    _keyboardService.type(text);
  }

  void specialKey(SpecialKeyType type) {
    _keyboardService.specialKey(type);
  }
}
