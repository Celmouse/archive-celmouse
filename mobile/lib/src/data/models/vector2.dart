import 'dart:math';

class Vector2D {
  final double x;
  final double y;

  Vector2D(this.x, this.y);

  double get length => sqrt(x * x + y * y);

  bool get canNormalize => length != 0;

  Vector2D get normalized => Vector2D(x / length, y / length);
}
