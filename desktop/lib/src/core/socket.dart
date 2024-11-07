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

        return mouse.move(x, y);
      case ProtocolEvents.changeSensitivity:
        print(protocol.data);
        // print(protocol.timestamp);
        // mouse.sensitivity = protocol.data;
        break;

      case ProtocolEvents.mouseClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.click(data.type.toMousePluginButton());
        break;
      case ProtocolEvents.mouseDoubleClick:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.doubleClick(data.type.toMousePluginButton());
        break;
      case ProtocolEvents.mouseButtonPressed:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        mouse.pressButton(data.type.toMousePluginButton());
        break;
      case ProtocolEvents.mouseButtonReleased:
        final data = MouseButtonProtocolData.fromJson(protocol.data);
        if (lastRequestTimestemp != null &&
            lastRequestTimestemp!
                    .difference(
                      protocol.timestamp,
                    )
                    .inMilliseconds >
                500) {
                  //TODO: Testar
          print("Tempo excedido");
          return;
        }
        lastRequestTimestemp = protocol.timestamp;

        mouse.releaseButton(data.type.toMousePluginButton());
        break;
      default:
    }
  }
}
