import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:server/src/data/socket_repository.dart';
import 'package:desktop_window/desktop_window.dart';

Size _expandedScreenSize = const Size(490, 500);
Size _colapsedScreenSize = const Size(315, 275);

class HomeViewmodel extends ChangeNotifier {
  final SocketRepository _socketRepository;

  HomeViewmodel({
    required SocketRepository socketRepository,
  }) : _socketRepository = socketRepository;

  bool _connected = false;
  bool get connected => _connected;
  bool isLoading = true;
  String? errorMessage;
  List<String> availableIPS = [];
  String? selectedIP;

  init() async {
    isLoading = true;
    _socketRepository.createSocket(
      onError: (error) {
        errorMessage = error.toString();
        notifyListeners();
      },
      onConnected: () {
        _connected = true;
        DesktopWindow.setWindowSize(_colapsedScreenSize, animate: true);
        notifyListeners();
      },
      onDisconnected: () {
        _connected = false;
        DesktopWindow.setWindowSize(_expandedScreenSize, animate: true);
        notifyListeners();
      },
    );

    _socketRepository.fetchIPList().then((result) {
      result.fold((list) {
        availableIPS = list;
        if (list.isNotEmpty) {
          selectedIP = list.first;
          notifyListeners();
        }
      }, (err) {
        errorMessage = err.toString();
        notifyListeners();
      });
    });

    DesktopWindow.setWindowSize(_expandedScreenSize, animate: true);
    isLoading = false;
    notifyListeners();
  }

  // Add this method to disconnect the WebSocket
  void disconnect() {
    _socketRepository.close();
    _connected = false;
    DesktopWindow.setWindowSize(_expandedScreenSize, animate: true);
    notifyListeners();
  }

  void selectIP(String selectedIP) {
    this.selectedIP = selectedIP;
    notifyListeners();
  }
}
