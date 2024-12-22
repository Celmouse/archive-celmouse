import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class MouseViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;
  final ConnectionRepository _connectionRepository;

  MouseViewmodel(
    this._connectionRepository, {
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

  bool keyboardOpenClose() {
    _isKeyboardOpen = !_isKeyboardOpen;
    notifyListeners();
    return _isKeyboardOpen;
  }


  void disableMouse() {
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
  }

  void reconnect() {
    _connectionRepository.reconnect();
  }

  void disconnect() {
    _connectionRepository.disconnect();
  }

  void reset() {
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
    notifyListeners();
  }
}
