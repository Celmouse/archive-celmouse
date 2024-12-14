import 'package:controller/src/data/repositories/ads_repository.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/repositories/keyboard_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/data/services/google_ads_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get defaultProvider => [
      Provider(create: (context) => ConnectionService()),
      Provider(create: (context) => ClientApiService()),
      ProxyProvider<ConnectionService, ConnectionRepository>(
        update: (_, connectionService, __) => ConnectionRepository(
          connectionService: connectionService,
          clientApiService: _.read<ClientApiService>(),
        ),
      ),
      Provider(
        create: (context) => GoogleAdsService(),
      ),
      Provider(
        create: (context) => AdsRepository(
          googleAdsService: context.read(),
        ),
      ),
      Provider(
        lazy: true,
        create: (context) => ClientApiService(),
      ),
      Provider(create: (context) => SensorsApiService()),
      Provider(
        create: (context) => KeyboardRepository(
          clientApiService: context.read<ClientApiService>(),
        ),
      ),
      Provider(
        lazy: true,
        create: (context) => MouseRepository(
          clientApiService: context.read<ClientApiService>(),
          sensorsService: context.read<SensorsApiService>(),
        ),
      ),
    ];
