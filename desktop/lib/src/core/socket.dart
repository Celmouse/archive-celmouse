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
    data = jsonDecode(data);

    // print(mouse.coordinates);

    if (data['event'] == "MouseMove") {
      double x = data["data"]["x"];
      double y = data["data"]["y"];
      mouse.move(x, y);
      print(mouse.coordinates);
    }
  }
}
