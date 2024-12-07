import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/connect/view/connect_hub_page.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_page.dart';
import 'package:controller/src/ui/mouse_move/viewmodel/mouse_move_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router(
  ConnectionRepository connectRepository,
) =>
    GoRouter(
      initialLocation: Routes.connect,
      routes: [
        GoRoute(
          path: Routes.connect,
          builder: (context, state) {
            return ConnectHUBPage(
              viewmodel: ConnectHUBViewmodel(
                connectRepository: context.read(),
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.mouse,
          builder: (context, state) {
            return MoveMousePage(
              viewmodel: MouseMoveViewmodel(
                // mouseRepository: context.read(),
              ),
            );
          },
        ),
      ],
    );
