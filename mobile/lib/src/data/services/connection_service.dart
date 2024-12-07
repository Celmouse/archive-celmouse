import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  Future<WebSocketChannel> connect(String ip, int port) async {
    try {
      final socket = WebSocketChannel.connect(
        Uri.parse('ws://$ip:$port'),
      );
      await socket.ready;
      return socket;
    } catch (e) {
      rethrow;
    }
  }

  dynamic scan() {
    // TODO: [Marcelo] Implementation for scanning all available devices with HUB
  }
}
