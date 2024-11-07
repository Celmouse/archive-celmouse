import 'dart:convert';

import 'package:protocol/protocol.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class KeyboardControl {
  final WebSocketChannel channel;

  KeyboardControl(this.channel);

  void type(String text) {
    _send(event: ProtocolEvents.keyPressed, data: text);
  }

  void _send({required ProtocolEvents event, required dynamic data}) =>
      channel.sink.add(jsonEncode(
        Protocol(
          event: event,
          data: data,
          timestamp: DateTime.timestamp(),
        ).toJson(),
      ));
}
