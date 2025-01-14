import 'package:controller/src/data/repositories/keyboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:protocol/protocol.dart';

class RemoteViewModel extends ChangeNotifier {
  final ConnectionRepository _connectionRepository;
  final KeyboardRepository _keyboardRepository;
  bool _isDark = true;
  String _currentApp = '';
  double _volume = 50;
  final int _channel = 1;
  String _activeApp = '';

  RemoteViewModel(this._connectionRepository, this._keyboardRepository);

  bool get isDark => _isDark;
  String get currentApp => _currentApp;
  double get volume => _volume;
  int get channel => _channel;
  String get activeApp => _activeApp;
  Future<bool> get isConnected async => await _connectionRepository.isConnected;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  Future<void> launchApp(String appName) async {
    if (!await isConnected) return;
    _currentApp = appName;
    _activeApp = appName;
    // Implement app launch logic
    notifyListeners();
  }

  Future<void> sendDirectionalCommand(String direction) async {
    if (!await isConnected) return;

    SpecialKeyType keyType;
    switch (direction) {
      case 'up':
        keyType = SpecialKeyType.arrowUp;
        break;
      case 'down':
        keyType = SpecialKeyType.arrowDown;
        break;
      case 'left':
        keyType = SpecialKeyType.arrowLeft;
        break;
      case 'right':
        keyType = SpecialKeyType.arrowRight;
        break;
      default:
        throw ArgumentError('Invalid direction: $direction');
    }

    _keyboardRepository.pressSpecialKey(keyType);
    notifyListeners();
  }

  Future<void> sendCommand(String command) async {
    if (!await isConnected) return;
    // Implement general command sending logic
    notifyListeners();
  }

  void sendVolumeCommand(double amount) {
    if (amount > 0) {
      // Increase volume
      _keyboardRepository.pressSpecialKey(SpecialKeyType.volumeUp);
      _keyboardRepository.releaseSpecialKey(SpecialKeyType.volumeUp);
      _volume = (_volume + amount).clamp(0, 100);
    } else if (amount < 0) {
      // Decrease volume
      _keyboardRepository.pressSpecialKey(SpecialKeyType.volumeDown);
      _keyboardRepository.releaseSpecialKey(SpecialKeyType.volumeDown);

      _volume = (_volume + amount).clamp(0, 100);
    } else {
      // Mute/unmute

      _keyboardRepository.pressSpecialKey(SpecialKeyType.volumeMute);
      _keyboardRepository.releaseSpecialKey(SpecialKeyType.volumeMute);
    }
    notifyListeners();
  }
}
