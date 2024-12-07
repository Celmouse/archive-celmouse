import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/utils/result.dart';
import 'package:flutter/material.dart';

class ConnectHUBViewmodel extends ChangeNotifier {
  final ConnectionRepository _connectRepository;

  ConnectHUBViewmodel({
    required ConnectionRepository connectRepository,
  }) : _connectRepository = connectRepository;

  bool _isConnected = false;

  bool _isLoading = false;

  String? _errorMessage;

  bool get isConnected => _isConnected;
  bool get isConnecting => _isLoading;
  String? get errorMessage =>  _errorMessage;

  Future<void> connect(String ip) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _connectRepository.connect(ip);
      switch (result) {
        case Ok():
          {
            _isConnected = true;
            break;
          }
        case Error():
          {
            _isConnected = false;
            _errorMessage = result.error.toString();
            break;
          }
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
