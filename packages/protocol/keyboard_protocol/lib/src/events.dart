import 'package:protocol_interface/protocol_interface.dart';

class KeyboardProtocolEvents extends ProtocolEvent {
  static const keyPressed = KeyboardProtocolEvents('keyPressed');
  static const specialKeyPressed = KeyboardProtocolEvents('specialKeyPressed');
  static const specialKeyReleased = KeyboardProtocolEvents('specialKeyReleased');

  const KeyboardProtocolEvents(super._event);
}
