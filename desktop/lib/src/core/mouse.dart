// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mouse/mouse.dart';

const yMultiplier = 42;
const xMultiplier = 54;

class Mouse {
  MousePosition _position = MousePosition(0, 0);

  final moviment = BaseMouseMoviment();

  void move(double x, double y) {
    position = MousePosition(
      coordinates.x + (x * xMultiplier),
      coordinates.y + (y * yMultiplier),
    );

    moviment.move(_position.x, _position.y);
  }

  MousePosition get coordinates {
    // final pos = mouse.getPosition();
    final pos = _position;
    return MousePosition(pos.x, pos.y);
  }

  set position(MousePosition newPosition) => _position = newPosition;
}

class MousePosition {
  double x;
  double y;

  MousePosition(this.x, this.y);

  @override
  String toString() => "($x, $y)";
}
