import 'dart:convert';
import 'package:controller/src/core/socket.dart';
import 'package:protocol/protocol.dart';

class KeyboardControl {

  void type(String text) {
    _send(event: ProtocolEvents.keyPressed, data: text);
  }

  void _send({required ProtocolEvents event, required dynamic data}) =>
      SocketConnection().getSocketConnection().sink.add(jsonEncode(
        Protocol(
          event: event,
          data: data,
          timestamp: DateTime.timestamp(),
        ).toJson(),
      ));
}
