import 'dart:async';

import 'package:controller/getit.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:controller/src/features/mouse/move/data/mouse_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class LeftButtonViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;

  LeftButtonViewmodel({
    required MouseRepository mouseRepository,
  }) : _mouseRepository = mouseRepository;

  bool _isPressed = false;

  bool get isPressed => _isPressed;

  Timer? doubleClickTimer;

  void click() {
    _isPressed = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 100), () {
      _isPressed = false;
      notifyListeners();
    });

    if (doubleClickTimer?.isActive == false) {
      _mouseRepository.click(ClickType.left);
    } else {
      _mouseRepository.doubleClick();
    }

    doubleClickTimer ??= Timer(
        Duration(
          milliseconds: getIt.get<MouseSettings>().doubleClickDelayMS.duration,
        ), () {
      doubleClickTimer = null;
    });
  }
}
