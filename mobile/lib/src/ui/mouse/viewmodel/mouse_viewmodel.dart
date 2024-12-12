import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class MouseViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  MouseViewmodel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

  bool keyboardOpenClose() {
    _isKeyboardOpen = !_isKeyboardOpen;
    notifyListeners();
    return _isKeyboardOpen;
  }

  void stopMouse() {
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
  }
}
