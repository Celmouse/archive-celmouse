import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register WebSocketChannel
  getIt.registerLazySingleton<WebSocketChannel>(
    () => WebSocketChannel.connect(Uri.parse('ws://localhost:12345')),
  );
}
