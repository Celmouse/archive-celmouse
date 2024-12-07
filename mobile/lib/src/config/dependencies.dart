import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/services/connection_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get defaultProvider => [
      Provider(create: (context) => ConnectionService()),
      Provider(
        create: (context) => ConnectionRepository(
          connectionService: context.read(),
        ),
      ),
    ];
