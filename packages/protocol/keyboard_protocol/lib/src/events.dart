import 'package:protocol_interface/protocol_interface.dart';

class KeyboardProtocolEvents extends ProtocolEvent {
  static const keyPressed = KeyboardProtocolEvents('keyPressed');
  static const specialKeyPressed = KeyboardProtocolEvents('specialKeyPressed');

  const KeyboardProtocolEvents(super._event);
}
