import 'package:protocol/protocol.dart';
import 'package:server/src/core/mouse.dart';
import 'dart:convert';

import 'package:server/src/core/mouse_protocol_translation.dart';

class SocketInterpreter {
  final Mouse mouse;

  SocketInterpreter({
    required this.mouse,
  });

  start() {
    //TODO: trazer os requisitos para conectar o socket para cá;
  }

  DateTime? lastRequestTimestemp;

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    switch (protocol.event) {
      case ProtocolEvents.mouseMove:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        double x = data.x;
        double y = data.y;
        double sense = data.intensity;

        return mouse.move(x, y, sense);
    
      case ProtocolEvents.mouseScroll:
        final data = MouseMovementProtocolData.fromJson(protocol.data);

        mouse.scroll(
          data.x.sign.ceil(),
          data.y.sign.ceil(),
          data.intensity.round(),
        );

        break;
      case ProtocolEvents.mouseClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.click(data.type.toMousePluginButton());
        break;
      case ProtocolEvents.mouseDoubleClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.doubleClick(data.type.toMousePluginButton());
        break;
      case ProtocolEvents.mouseButtonHold:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.holdLeftButton();
        break;
      case ProtocolEvents.mouseButtonReleased:
        // final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.releaseLeftButton();
        break;
      default:
    }
  }
}
