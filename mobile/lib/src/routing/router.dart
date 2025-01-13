import 'package:controller/src/UI/remote_control/view/remote_view.dart';
import 'package:controller/src/UI/remote_control/viewmodel/remote_viewmodel.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/data/repositories/keyboard_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/connect/view/connect_hub_page.dart';
import 'package:controller/src/ui/connect_from_qr/view/connect_qr_code.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/connect_from_qr/viewmodel/connect_qr_viewmodel.dart';
import 'package:controller/src/ui/mouse/view/mouse_page.dart';
import 'package:controller/src/ui/mouse/viewmodel/mouse_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.connect,
  routes: [
    GoRoute(
      path: Routes.connect,
      builder: (context, state) => ConnectHUBPage(
        viewmodel: ConnectHUBViewmodel(
          connectRepository: context.read(),
        ),
      ),
    ),
    GoRoute(
      path: Routes.connectQRCode,
      builder: (context, state) => ConnectFromQrCodePage(
        viewmodel: ConnectQrViewmodel(
          connectRepository: context.read(),
        ),
      ),
    ),
    GoRoute(
      path: Routes.mouse,
      builder: (context, state) => MousePage(
        viewmodel: MouseViewmodel(
          context.read<ConnectionRepository>(),
          mouseRepository: context.read<MouseRepository>(),
        ),
      ),
    ),
    GoRoute(
      path: Routes.remote,
      builder: (context, state) => RemoteView(
        viewmodel: RemoteViewModel(
          context.read<ConnectionRepository>(),
          context.read<KeyboardRepository>(),
        ),
      ),
    ),
  ],
);
