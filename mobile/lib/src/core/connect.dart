import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<WebSocketChannel?> connectWS(String ip, Function(String) onError,
    [int timeout = 10]) async {
  const exp =
      r'(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}';
  final rgx = RegExp(exp);
  if (!rgx.hasMatch(ip)) {
    onError("IP not formated properly");
    return null;
  }

  late final WebSocketChannel channel;
  channel = WebSocketChannel.connect(
    Uri.parse('ws://$ip:7771'),
  );

  try {
    await channel.ready.timeout(Duration(seconds: timeout));
    return channel;
  } on SocketException catch (e) {
    onError("Ocorreu um erro: $e");
  } on WebSocketChannelException catch (e) {
    onError("Ocorreu um erro: $e");
  }
  return null;
}
