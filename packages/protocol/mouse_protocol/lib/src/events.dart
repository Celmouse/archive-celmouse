import 'package:protocol_interface/protocol_interface.dart';

class MouseProtocolEvents extends ProtocolEvent {
  static const mouseMove = MouseProtocolEvents('mouseMove');
  static const mouseCenter = MouseProtocolEvents('mouseCenter');
  static const mouseScroll = MouseProtocolEvents('mouseScroll');
  static const mouseClick = MouseProtocolEvents('mouseClick');
  static const mouseDoubleClick = MouseProtocolEvents('mouseDoubleClick');
  static const mouseButtonHold = MouseProtocolEvents('mouseButtonHold');
  static const mouseButtonReleased = MouseProtocolEvents('mouseButtonReleased');

  const MouseProtocolEvents(super._event);
}
