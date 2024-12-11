import 'package:protocol/protocol.dart';
import 'dart:convert';

import 'package:server/src/core/mouse_protocol_translation.dart';
import 'package:server/src/data/services/mouse_service.dart';

import 'services/keyboard_service.dart';

class SocketRepository {
  final MouseService mouse;
  final KeyboardService keyboard;

  SocketRepository({
    required this.mouse,
    required this.keyboard,
  });

  start() {
    //TODO: trazer os requisitos para conectar o socket para cá;
  }

  DateTime? lastRequestTimestemp;

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    switch (protocol.event) {
      case ProtocolEvent.mouseMove:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        double x = data.x;
        double y = data.y;
        double sense = data.intensity;

        return mouse.move(x, y, sense);

      case ProtocolEvent.mouseScroll:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        mouse.scroll(
          data.x.sign.ceil(),
          data.y.sign.ceil(),
          data.intensity.round(),
        );

        break;
      case ProtocolEvent.mouseClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.click(data.type.toMousePluginButton());
        break;
      case ProtocolEvent.mouseDoubleClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.doubleClick(data.type.toMousePluginButton());
        break;
      case ProtocolEvent.mouseButtonHold:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.holdLeftButton();
        break;
      case ProtocolEvent.mouseButtonReleased:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.releaseLeftButton();
        break;
      case ProtocolEvent.keyPressed:
        final data = protocol.data as String;
        keyboard.type(data);
        break;
      default:
    }
  }
}
