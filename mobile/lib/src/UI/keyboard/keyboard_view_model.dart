import 'package:controller/src/UI/keyboard/keyboard_repository.dart';
import 'package:controller/src/UI/keyboard/keyboard_service.dart';
import 'package:flutter/material.dart';
import 'package:controller/src/UI/keyboard/model.dart';

class KeyboardViewModel extends ChangeNotifier {
  final KeyboardRepository _keyboardRepository;
  bool _isShiftActive = false;

  KeyboardViewModel(this._keyboardRepository);

  bool get isShiftActive => _isShiftActive;

  void onCharPressed(String char) {
    if (_isShiftActive) {
      char = char.toUpperCase();
      _isShiftActive = false;
      notifyListeners();
    }
    _keyboardRepository.type(char);
  }

  void onSpecialKeyPressed(SpecialKeyType type) {
    switch (type) {
      case SpecialKeyType.shift:
        _isShiftActive = !_isShiftActive;
        notifyListeners();
        break;
      case SpecialKeyType.backspace:
      case SpecialKeyType.hide:
      case SpecialKeyType.enter:
        _keyboardRepository.specialKey(type);
        break;
      case SpecialKeyType.space:
        _keyboardRepository.type(' ');
        break;
      default:
        _keyboardRepository.specialKey(type);
        break;
    }
  }

  List<List<MKey>> get keys => [
        "1234567890".split("").map((e) => MKey(label: e)).toList(),
        "qwertyuiop".split("").map((e) => MKey(label: e)).toList(),
        "asdfghjkl".split("").map((e) => MKey(label: e)).toList(),
        [
          MKey(label: "Shift", type: KeyType.special, flex: 2),
          ...("zxcvbnm".split("").map((e) => MKey(label: e)).toList()),
          MKey(icon: Icons.backspace, type: KeyType.special, flex: 2),
        ],
        [
          MKey(icon: Icons.keyboard_hide, type: KeyType.special, flex: 2),
          MKey(label: "Space", type: KeyType.aderence, flex: 5),
          MKey(icon: Icons.keyboard_return, type: KeyType.special, flex: 2),
        ],
      ];
}
