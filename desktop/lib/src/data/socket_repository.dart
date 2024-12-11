import 'dart:convert';

import 'package:protocol/protocol.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'services/keyboard_service.dart';

class SocketRepository {
  final MouseService mouse;
  final KeyboardService keyboard;

  SocketRepository({
    required this.mouse,
    required this.keyboard,
  });

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    print(protocol);

    switch (protocol.event) {
      case MouseProtocolEvents.mouseMove:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        double x = data.x;
        double y = data.y;
        double sense = data.intensity;

        return mouse.move(x, y, sense);

      case MouseProtocolEvents.mouseScroll:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        mouse.scroll(
          data.x.sign.ceil(),
          data.y.sign.ceil(),
          data.intensity.round(),
        );

        break;
      case MouseProtocolEvents.mouseClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.click(data.type);
        break;
      case MouseProtocolEvents.mouseDoubleClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.doubleClick(data.type);
        break;
      case MouseProtocolEvents.mouseButtonHold:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.holdLeftButton();
        break;
      case MouseProtocolEvents.mouseButtonReleased:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.releaseLeftButton();
        break;
      case KeyboardProtocolEvents.keyPressed:
        final data = protocol.data as String;
        keyboard.type(data);
        break;
      default:
    }
  }
}
