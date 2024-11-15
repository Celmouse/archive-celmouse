// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mouse/mouse.dart' as plugin;
import 'dart:math';

/// Multiplicadores para tornar a movimentação viável
/// [yMultiplier] representa o tamanho da tela no eixo vertical.
/// [xMultiplier] representa o tamanho da tela no eixo horizontal.
const yMultiplier = 42;
const xMultiplier = 54;

@Deprecated(
  '''Sensitivity should be passed as a parameter from app.
       Will be removed on version 3.0 so the mobile App can have all 
       control over Settings''',
)
const defaultSensValue = 1.15;
@Deprecated(
  '''Sensitivity should be passed as a parameter from app.
       Will be removed on version 3.0 so the mobile App can have all 
       control over Settings''',
)
@Deprecated(
  '''Sensitivity should be passed as a parameter from app.
       Will be removed on version 3.0 so the mobile App can have all 
       control over Settings''',
)
const defaultSensAdjustmentValue = 0.5;

/// Valor de x e y que podem fazer um salto para fora da tela
const preventJump = 50;

class Mouse {
  final mouse = plugin.Mouse();

  @Deprecated(
    '''Sensitivity should be passed as a parameter from app.
       Will be removed on version 3.0 so the mobile App can have all 
       control over Settings''',
  )
  double _sensitivity = 1;

  @Deprecated(
    '''Sensitivity should be passed as a parameter from app.
       Will be removed on version 3.0 so the mobile App can have all 
       control over Settings''',
  )
  int _scrollSensitivity = 3;

  Mouse() {
    const mobileSensitivityStartValue = 5.0;
    const mobileScrollSensitivityStartValue = 3;
    sensitivity = mobileSensitivityStartValue;
    scrollSensitivity = mobileScrollSensitivityStartValue;
  }

  void move(double x, double y) {
    if (x.abs() > preventJump || y.abs() > preventJump) return;
    mouse.move(
      x * xMultiplier * _sensitivity,
      y * yMultiplier * _sensitivity,
    );
  }

  void scroll(int x, int y, [int? sense]) {
    if (x.abs() > preventJump || y.abs() > preventJump) return;
    mouse.scroll(x, y, sense ?? _scrollSensitivity);
  }

  get screenSize => mouse.getScreenSize();

  set sensitivity(double value) => _sensitivity =
      pow(defaultSensValue, value).toDouble() - defaultSensAdjustmentValue;

  set scrollSensitivity(int value) => _scrollSensitivity = value * 4;

  Future<void> click(plugin.MouseButton button) async {
    debugPrint("Click");
    mouse.click(button);
  }

  Future<void> doubleClick(plugin.MouseButton button) async {
    debugPrint("Double Click");
    mouse.doubleClick();
  }

  void holdLeftButton() {
    debugPrint("Press");
    mouse.holdLeftButton();
  }

  void releaseLeftButton() {
    debugPrint("Release");
    mouse.releaseLeftButton();
  }
}
