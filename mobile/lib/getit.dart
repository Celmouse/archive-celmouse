import 'package:controller/src/UI/keyboard/keyboard_repository.dart';
import 'package:controller/src/UI/keyboard/keyboard_service.dart';
import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:controller/src/features/connect/input_ip/ui/bloc/ip_connect_bloc.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register WebSocketChannel
  getIt.registerLazySingleton<WebSocketChannel>(
    () => WebSocketChannel.connect(Uri.parse('ws://localhost:12345')),
  );

  // Register KeyboardService
  getIt.registerLazySingleton<KeyboardService>(() => KeyboardService());

  // Register KeyboardRepository
  getIt.registerLazySingleton<KeyboardRepository>(
    () => KeyboardRepository(getIt<KeyboardService>()),
  );

  // Register IPConnectBloc
  getIt.registerFactory(() => IPConnectBloc());
}
