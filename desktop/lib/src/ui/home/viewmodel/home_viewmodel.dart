import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:server/src/data/socket_repository.dart';

class HomeViewmodel {
  final SocketRepository _socketRepository;

  HomeViewmodel({
    required SocketRepository socketRepository,
  }) : _socketRepository = socketRepository;

  Size expandedScreenSize = const Size(300, 470);
  Size colapsedScreenSize = const Size(250, 180);

  ValueNotifier<bool> connected = ValueNotifier(false);
  ValueNotifier<String?> errorMessage = ValueNotifier(null);
  ValueNotifier<List<String>> availableIPS = ValueNotifier([]);

  init() async {
    _socketRepository.createSocket(
      onError: (error) {
        errorMessage.value = error.toString();
      },
      onConnected: () {
        connected.value = true;
        DesktopWindow.setWindowSize(colapsedScreenSize, animate: true);
      },
      onDisconnected: () {
        connected.value = false;
        DesktopWindow.setWindowSize(expandedScreenSize, animate: true);
      },
    );

    _socketRepository.fetchIPList().then((result) {
      result.fold((list) {
        availableIPS.value = list;
      }, (err) {
        errorMessage.value = err.toString();
      });
    });

    DesktopWindow.setWindowSize(expandedScreenSize, animate: true);
  }

  dispose() {
    availableIPS.dispose();
    connected.dispose();
    errorMessage.dispose();
  }
}
