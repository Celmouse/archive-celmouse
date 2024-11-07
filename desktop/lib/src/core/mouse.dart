// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mouse/mouse.dart' as plugin;
import 'dart:math';

/// Multiplicadores para tornar a movimentação viável
const yMultiplier = 42;
const xMultiplier = 54;

const defaultSensValue = 1.15;
const defaultSensAdjustmentValue = 0.5;

/// Valor de x e y que podem fazer um salto para fora da tela
const preventJump = 50;

class Mouse {
  final mouse = plugin.Mouse();

  double _sensitivity = 1;
  int _scrollSensitivity = 3;

  Mouse() {
    const mobileSensitivityStartValue = 5.0;
    sensitivity = mobileSensitivityStartValue;
  }

  void move(double x, double y) {
    if (x.abs() > preventJump || y.abs() > preventJump) return;
    mouse.move(
      x * xMultiplier * _sensitivity,
      y * yMultiplier * _sensitivity,
    );
  }

  void scroll(int x, int y) {
    if (x.abs() > preventJump || y.abs() > preventJump) return;
    mouse.scroll(x, y, _scrollSensitivity);
  }

  get screenSize => mouse.getScreenSize();

  set sensitivity(double value) => _sensitivity =
      pow(defaultSensValue, value).toDouble() - defaultSensAdjustmentValue;

  set scrollSensitivity(int value) => _scrollSensitivity = value;

  Future<void> click(plugin.MouseButton button) async {
    debugPrint("Click");
    mouse.pressButton(button);
    mouse.releaseButton(button);
  }

  Future<void> doubleClick(plugin.MouseButton button) async {
    debugPrint("Double Click");
    mouse.doubleClick();
  }

  void pressButton(plugin.MouseButton button) {
    debugPrint("Press");
    mouse.pressButton(button);
  }

  void releaseButton(plugin.MouseButton button) {
    debugPrint("Release");
    mouse.releaseButton(button);
  }
}
