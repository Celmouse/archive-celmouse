import 'dart:async';

import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/domain/models/devices.dart';
import 'package:controller/src/utils/result.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionRepository {
  final ConnectionService _connectionService;

  ConnectionRepository({
    required ConnectionService connectionService,
  }) : _connectionService = connectionService;

  WebSocketChannel? _socket;

  WebSocketChannel get socket => _socket!;

  Future<Result<void>> connect(String ip) async {
    // We are using port 7771 por now, so no need to pass it as a parameter
    try {
      _socket = await _connectionService.connect(ip, 7771);

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

  Stream<List<Device>> scanDevices() => _connectionService.scan();

  void startScan() => _connectionService.startScan();

  void stopScan() => _connectionService.stopScan();
}
