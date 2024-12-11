import 'dart:convert';
import 'package:protocol/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ClientApiService {
  final WebSocketChannel socket;

  ClientApiService({
    required this.socket,
  });

  void send({required ProtocolEvents event, dynamic data}) {
    socket.sink.add(jsonEncode(
      Protocol(
        event: event,
        data: data,
        timestamp: DateTime.timestamp(),
      ).toJson(),
    ));
  }
}
