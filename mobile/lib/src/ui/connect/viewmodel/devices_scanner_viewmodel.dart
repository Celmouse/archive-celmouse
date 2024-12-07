import 'package:controller/src/data/repositories/connection_repository.dart';
import 'package:controller/src/domain/models/devices.dart';
import 'package:flutter/foundation.dart';

class DevicesScannerViewmodel extends ChangeNotifier {
  final ConnectionRepository _connectionRepository;

  DevicesScannerViewmodel({
    required ConnectionRepository connectionRepository,
  }) : _connectionRepository = connectionRepository;

  bool _isScanning = false;

  final List<Device> _devices = [];

  List<Device> get devices => _devices;

  bool get isScanning => _isScanning;

  Future<void> startScan() async {
    _isScanning = true;
    notifyListeners();

    _connectionRepository.scanDevices().listen((device) {
      _devices.add(device);
      notifyListeners();
    });

    _connectionRepository.startScan();
  }

  void stopScan() {
    _isScanning = false;
    notifyListeners();
  }
}
