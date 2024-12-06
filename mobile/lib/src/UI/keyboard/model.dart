import 'package:flutter/material.dart';

enum KeyType {
  normal(Colors.grey),
  special(Colors.red),
  aderence(Colors.yellow);

  const KeyType(this.color);
  final Color color;
}

class MKey {
  final int spacing;
  final KeyType type;

  MKey({
    this.type = KeyType.normal,
    this.spacing = 1,
  });


}
