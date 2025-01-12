import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:server/src/data/socket_repository.dart';
import 'package:desktop_window/desktop_window.dart';

class HomeViewmodel {
  final SocketRepository _socketRepository;

  HomeViewmodel({
    required SocketRepository socketRepository,
  }) : _socketRepository = socketRepository;

  Size expandedScreenSize = const Size(800, 600);
  Size colapsedScreenSize = const Size(400, 250);

  ValueNotifier<bool> connected = ValueNotifier(false);
  ValueNotifier<String?> errorMessage = ValueNotifier(null);
  ValueNotifier<List<String>> availableIPS = ValueNotifier([]);
  ValueNotifier<String?> selectedIP = ValueNotifier(null);

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
        if (list.isNotEmpty) {
          selectedIP.value = list.first;
        }
      }, (err) {
        errorMessage.value = err.toString();
      });
    });

    DesktopWindow.setWindowSize(expandedScreenSize, animate: true);
  }

  // Add this method to disconnect the WebSocket
  void disconnect() {
    _socketRepository.close();
    connected.value = false;
    DesktopWindow.setWindowSize(expandedScreenSize, animate: true);
  }

  dispose() {
    availableIPS.dispose();
    connected.dispose();
    errorMessage.dispose();
    selectedIP.dispose();
  }
}
