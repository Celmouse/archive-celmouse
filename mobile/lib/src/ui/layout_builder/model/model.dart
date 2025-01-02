import 'dart:io';
import 'package:flutter/material.dart';

class LayoutButtonProperties {
  String id;
  double x;
  double y;
  double size;
  Color color;
  BoxShape shape;
  String label;
  File? customImage;

  LayoutButtonProperties({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    this.label = "",
    this.color = Colors.blue,
    this.shape = BoxShape.rectangle,
    this.customImage,
  });

  @override
  String toString() {
    return "$id: ($x, $y)";
  }
}

enum LayoutBuilderButtomActionType {
  mouse,
  keyboard,
}

class LayoutBuilderButtomAction {
  final LayoutBuilderButtomActionType type;

  LayoutBuilderButtomAction({
    required this.type,
  });

  void onTap() {}
  void onHold() {}
  void onRelease() {}
}

class LayoutBuilderButtomActionButtonTap {
  void onTap(String key) {}
}