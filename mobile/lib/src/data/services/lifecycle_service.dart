import 'package:flutter/widgets.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/ui/mouse/viewmodel/mouse_viewmodel.dart';

class LifecycleService with WidgetsBindingObserver {
  final ConnectionRepository _connectionRepository;
  final MouseViewmodel _mouseViewmodel;

  LifecycleService({
    required ConnectionRepository connectionRepository,
    required MouseViewmodel mouseViewmodel,
  })  : _connectionRepository = connectionRepository,
        _mouseViewmodel = mouseViewmodel {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has resumed
      _connectionRepository.reconnect();
      _mouseViewmodel.enableMouse();
    } else if (state == AppLifecycleState.paused) {
      // App has paused (gone to background)
      _connectionRepository.disconnect();
      _mouseViewmodel.disableMouse();
    } else if (state == AppLifecycleState.inactive) {
      // App is inactive (e.g., when the phone is locked)
    } else if (state == AppLifecycleState.detached) {
      // App is detached (e.g., when the app is terminated)
      _mouseViewmodel.disableMouse();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
