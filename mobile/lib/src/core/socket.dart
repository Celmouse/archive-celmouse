import 'package:controller/getit.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketConnection {
  // Por 7771 is the default for now
  createSocketConnection(String ip, int port) {
    getIt.unregister<WebSocketChannel>();
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip:$port'),
    );
    getIt.registerSingleton<WebSocketChannel>(channel);
  }

  Future<bool> isConnected() async {
    if (getIt.isRegistered<WebSocketChannel>()) {
      await getSocketConnection().ready;
      return true;
    }
    return false;
  }

  WebSocketChannel getSocketConnection() {
    return getIt.get<WebSocketChannel>();

    // Get the socket connection
  }

  void disconnectSocket() {
    if (getIt.isRegistered<WebSocketChannel>()) {
      getSocketConnection().sink.close();
      getIt.unregister<WebSocketChannel>();
    }
  }

  /* If you whant to keep an eye on the socket connection, you can use the following code:
 widget.channel.stream.listen((_) {}, onDone: () {
      if (mounted) {
        Navigator.pop(context);
      }
    }, onError: (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connection Error: $e"),
          ),
        );
      }
    });
  */
}
