// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mouse/mouse.dart' as plugin;

/// Multiplicadores para tornar a movimentação viável
/// [yMultiplier] representa o tamanho da tela no eixo vertical.
/// [xMultiplier] representa o tamanho da tela no eixo horizontal.
const yMultiplier = 21;
const xMultiplier = 27;

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

  Mouse();

  void move(double x, double y, double sense) => mouse.move(
        x * xMultiplier * sense,
        y * yMultiplier * sense,
      );

  void scroll(int x, int y, int sense) => mouse.scroll(x, y, sense);

  get screenSize => mouse.getScreenSize();

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
