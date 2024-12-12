import 'dart:async';

import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/utils/result.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:controller/src/domain/models/devices.dart';

class ConnectionRepository {
  final ConnectionService _connectionService;

  ConnectionRepository({
    required ConnectionService connectionService,
  }) : _connectionService = connectionService;

  WebSocketChannel? _socket;
  String? _lastIp;
  int? _lastPort;

  WebSocketChannel get socket => _socket!;

  Future<Result<void>> connect(String ip, {int port = 7771}) async {
    try {
      _socket = await _connectionService.connect(ip, port);
      _lastIp = ip;
      _lastPort = port;
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> disconnect() async {
    if (!await isConnected) return Result.error(Exception('Not connected'));
    try {
      await _connectionService.disconnect(_socket!);
      _socket = null;
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<bool> get isConnected async {
    await _socket?.ready;
    return _socket != null;
  }

  Future<Result<void>> reconnect() async {
    if (_lastIp == null || _lastPort == null) {
      return Result.error(Exception('No previous connection details'));
    }
    await disconnect();
    return await connect(_lastIp!, port: _lastPort!);
  }

  Stream<List<Device>> scanDevices() => _connectionService.scan();

  void startScan() => _connectionService.startScan();

  void stopScan() => _connectionService.stopScan();
}
