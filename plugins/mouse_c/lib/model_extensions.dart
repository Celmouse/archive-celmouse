import 'package:mouse_c/mouse_bindings_generated.dart';

extension MousePositionExtra on MousePosition {

  String toDetailedString(){
    return "(x: $x, y: $y)";
  }
}