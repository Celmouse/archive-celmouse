import 'package:protocol_interface/protocol_interface.dart';

class MouseProtocolEvents extends ProtocolEvent {
  static const mouseMove = MouseProtocolEvents('MouseMove');
  static const mouseCenter = MouseProtocolEvents('MouseCenter');
  static const mouseScroll = MouseProtocolEvents('MouseScroll');
  static const mouseClick = MouseProtocolEvents('MouseClick');
  static const mouseDoubleClick = MouseProtocolEvents('MouseDoubleClick');
  static const mouseButtonHold = MouseProtocolEvents('MouseButtonHold');
  static const mouseButtonReleased = MouseProtocolEvents('MouseButtonReleased');

  const MouseProtocolEvents(super.name);

 
}
