import 'dart:convert';
import 'package:controller/src/core/socket.dart';
import 'package:protocol/protocol.dart';

class KeyboardRepository {
  void type(String text) {
    _send(event: ProtocolEvents.keyPressed, data: text);
  }

  void specialKey(SpecialKeyType type) {
    _send(event: ProtocolEvents.specialKeyPressed, data: type.toString());
  }

  void _send({required ProtocolEvents event, required dynamic data}) {
    final socketConnection = SocketConnection().getSocketConnection();
    socketConnection.sink.add(jsonEncode(
      Protocol(
        event: event,
        data: data,
        timestamp: DateTime.now(),
      ).toJson(),
    ));
  }
}

enum SpecialKeyType {
  shift,
  backspace,
  specialChars,
  space,
  enter,
  defaultLayout,
  // Add other special key types here
}
