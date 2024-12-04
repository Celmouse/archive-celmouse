import 'dart:convert';
import 'package:controller/src/core/socket.dart';
import 'package:protocol/protocol.dart';

class KeyboardControl {
  void press(String text) {
    _send(
      event: ProtocolEvents.keyPressed,
      data: text,
    );
  }

  void release(String text) {
    _send(
      event: ProtocolEvents.keyReleased,
      data: text,
    );
  }

  void _send({required ProtocolEvents event, required dynamic data}) =>
      SocketConnection().getSocketConnection().sink.add(
            jsonEncode(
              Protocol(
                event: event,
                data: data,
                timestamp: DateTime.timestamp(),
              ).toJson(),
            ),
          );
}
