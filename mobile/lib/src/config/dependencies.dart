import 'package:controller/src/UI/keyboard/keyboard_repository.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get defaultProvider => [
      Provider(create: (_) => KeyboardRepository()),
      Provider(create: (context) => ConnectionService()),
      Provider(
        create: (context) => ConnectionRepository(
          connectionService: context.read(),
        ),
      ),
      Provider(
        create: (context) => SensorsApiService(),
      ),
    ];
