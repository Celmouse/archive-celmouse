import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/repositories/keyboard_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get defaultProvider => [
      Provider(create: (context) => ConnectionService()),
      Provider(
        create: (context) => ConnectionRepository(
          connectionService: context.read(),
        ),
      ),
      Provider(
        create: (context) => SensorsApiService(),
      ),
      Provider(
        lazy: true,
        create: (context) => ClientApiService(
          socket: context.read<ConnectionRepository>().socket,
        ),
      ),
      Provider(
        create: (context) => KeyboardRepository(
          clientApiService: context.read(),
        ),
      ),
      Provider(
        lazy: true,
        create: (context) => MouseRepository(
          clientApiService: context.read(),
          sensorsService: context.read(),
        ),
      ),
    ];
