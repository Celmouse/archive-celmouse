import 'dart:convert';
import 'package:protocol/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ClientApiService {
  final WebSocketChannel socket;

  ClientApiService({
    required this.socket,
  });

  void send({required ProtocolEvent event, dynamic data}) {
    final protocol = Protocol(
      event: event,
      data: data,
      timestamp: DateTime.timestamp(),
    );
    final map = protocol.toJson();
    final json = jsonEncode(map);
    socket.sink.add(json);
  }
}
