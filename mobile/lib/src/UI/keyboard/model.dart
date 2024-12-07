import 'package:flutter/material.dart';

enum KeyType {
  normal(Colors.grey),
  special(Colors.red),
  aderence(Colors.yellow);

  const KeyType(this.color);
  final Color color;
}

class MKey {
  final String? label;
  final IconData? icon;
  final KeyType type;
  final int flex;

  MKey({
    this.label,
    this.icon,
    this.type = KeyType.normal,
    this.flex = 1,
  });
}
