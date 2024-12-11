import 'package:controller/src/data/repositories/keyboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:controller/src/UI/keyboard/model.dart';
import 'package:protocol/protocol.dart';

enum KeyboardLayout { main, special }

class KeyboardViewModel extends ChangeNotifier {
  final KeyboardRepository _keyboardRepository;
  KeyboardViewModel({
    required KeyboardRepository keyboardRepository,
  }) : _keyboardRepository = keyboardRepository;

  bool _isShiftActive = false;
  KeyboardLayout _currentLayout = KeyboardLayout.main;

  bool get isShiftActive => _isShiftActive;
  KeyboardLayout get currentLayout => _currentLayout;

  void toggleLayout() {
    _currentLayout = _currentLayout == KeyboardLayout.main
        ? KeyboardLayout.special
        : KeyboardLayout.main;
    notifyListeners();
  }

  void onCharPressed(String char) {
    if (_isShiftActive) {
      char = char.toUpperCase();
      _isShiftActive = false;
      notifyListeners();
    }
    _keyboardRepository.type(char);
  }

  void onSpecialKeyReleased(SpecialKeyType type) {
    if (type == SpecialKeyType.shift) {
      _isShiftActive = false;
      notifyListeners();
    }
    _keyboardRepository.releaseSpecialKey(type);
  }

  void onSpecialKeyPressed(SpecialKeyType type) {
    switch (type) {
      case SpecialKeyType.shift:
        _isShiftActive = true;
        notifyListeners();
        _keyboardRepository.pressSpecialKey(type);
        break;
      case SpecialKeyType.specialChars:
        break;
      case SpecialKeyType.backspace:
      case SpecialKeyType.enter:
      case SpecialKeyType.space:
        _keyboardRepository.pressSpecialKey(type);
      default:
        break;
    }
  }

  List<List<MKey>> get mainKeys => [
        "1234567890".split("").map((e) => MKey(label: e)).toList(),
        "qwertyuiop".split("").map((e) => MKey(label: e)).toList(),
        "asdfghjkl".split("").map((e) => MKey(label: e)).toList(),
        [
          MKey(label: "Shift", type: KeyType.special, flex: 2, specialKeyType: SpecialKeyType.shift),
          ...("zxcvbnm".split("").map((e) => MKey(label: e)).toList()),
          MKey(icon: Icons.backspace, type: KeyType.special, flex: 2, specialKeyType: SpecialKeyType.backspace),
        ],
        [
          MKey(icon: Icons.emoji_symbols, type: KeyType.special, flex: 2),
          MKey(label: "Space", type: KeyType.aderence, flex: 5, specialKeyType: SpecialKeyType.space),
          MKey(icon: Icons.keyboard_return, type: KeyType.special, flex: 2, specialKeyType: SpecialKeyType.enter),
        ],
      ];

  List<List<MKey>> get specialKeys => [
        "!@#\$%^&*()".split("").map((e) => MKey(label: e)).toList(),
        "_+-=[]{}|;:'\",.<>?/".split("").map((e) => MKey(label: e)).toList(),
        [
          MKey(label: "123", type: KeyType.special, flex: 2),
          MKey(icon: Icons.backspace, type: KeyType.special, flex: 2, specialKeyType: SpecialKeyType.backspace),
        ],
        [
          MKey(icon: Icons.format_size, type: KeyType.special, flex: 2),
          MKey(label: "Space", type: KeyType.aderence, flex: 5, specialKeyType: SpecialKeyType.space),
          MKey(icon: Icons.keyboard_return, type: KeyType.special, flex: 2, specialKeyType: SpecialKeyType.enter),
        ],
      ];

  List<List<MKey>> get keys =>
      _currentLayout == KeyboardLayout.main ? mainKeys : specialKeys;
}
