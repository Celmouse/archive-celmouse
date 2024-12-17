import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class MoveMouseButtonViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  MoveMouseButtonViewmodel({
    required MouseRepository mouseReposiry,
  }) : _mouseRepository = mouseReposiry;

  bool _isActive = false;
  bool get isActive => _isActive;

  void toggle() {
    _isActive = !_isActive;
    notifyListeners();

    if (_isActive) {
      _mouseRepository.enableMovement();
    } else {
      _mouseRepository.disableMovement();
    }
  }
}
