import 'dart:io';
import 'package:controller/src/core/socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> connectWS(String ip, int port, Function(String) onError,
    [int timeout = 10]) async {
  const exp =
      r'(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}';
  final rgx = RegExp(exp);
  if (!rgx.hasMatch(ip)) {
    onError("IP not formatted properly");
    return;
  }

  final socketConnection = SocketConnection();
  socketConnection.createSocketConnection(ip, port);

  try {
    await socketConnection.isConnected();
    return;
  } on SocketException catch (e) {
    onError("Socket error: $e");
  } on WebSocketChannelException catch (e) {
    onError("WebSocket error: $e");
  }
  return;
}
