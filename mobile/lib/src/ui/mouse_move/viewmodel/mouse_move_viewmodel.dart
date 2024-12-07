import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';

class MouseMoveViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  MouseMoveViewmodel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  void stopMouse(){
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
  }
}
