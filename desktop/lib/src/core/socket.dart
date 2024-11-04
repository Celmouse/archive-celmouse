import 'package:protocol/protocol.dart';
import 'package:server/src/core/mouse.dart';
import 'dart:convert';

class SocketInterpreter {
  final Mouse mouse;

  SocketInterpreter({
    required this.mouse,
  });

  start() {
    //TODO: trazer os requisitos para conectar o socket para cá;
  }

  //TODO: Implementar protocolo
  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    // print(mouse.coordinates);

    switch (protocol.event) {
      case ProtocolEvents.mouseMove:
        double x = protocol.data["x"];
        double y = protocol.data["y"];
        return mouse.move(x, y);
      default:
    }
  }
}
