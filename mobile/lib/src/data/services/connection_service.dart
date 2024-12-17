import 'dart:async';
import 'package:controller/src/domain/models/devices.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  final List<Device> _devices = [];
  final StreamController<List<Device>> _scanController =
      StreamController.broadcast();
  Stream<List<Device>> get scanStream => _scanController.stream;

  bool _stopScan = false;
  String? _lastIp;
  int? _lastPort;

  Future<void> stopScan() async {
    _stopScan = true;
  }

  Future<void> startScan([int retryInterval = 5, int retryCount = 100]) async {
    for (int count = 0; count < retryCount; count++) {
      print("Retry Attempt: $count");
      await _scan();
      await Future.delayed(Duration(seconds: retryInterval));
      if (_stopScan) break;
    }
  }

  Future<void> _scan() async {
    Completer completer = Completer();
    if (_stopScan) return;

    final info = NetworkInfo();
    final String? ip = await info.getWifiIP();
    const port = 7771;

    int sum = sumPort(254, 2);

    final subnet = ip?.substring(0, ip.lastIndexOf('.'));
    for (int i = 2; i < 255; i++) {
      final host = '$subnet.$i';
      pingServer(host, port).then((isAvailable) {
        if (isAvailable) {
          _addDevice(Device(
            name: 'Device $i',
            ip: host,
            port: port,
          ));
        }
        sum -= i;
        if (sum <= 0) {
          completer.complete();
        }
      }, onError: (e) {
        sum -= i;
        if (sum <= 0) {
          completer.complete();
        }
      });
    }

    await completer.future;
  }

  Future<WebSocketChannel> connect(String ip, int port) async {
    final uri = Uri.parse('ws://$ip:$port');
    final channel = WebSocketChannel.connect(uri);
    _lastIp = ip;
    _lastPort = port;
    return channel;
  }

  Future<void> disconnect(WebSocketChannel channel) async {
    await channel.sink.close();
  }

  Future<WebSocketChannel> reconnect() async {
    if (_lastIp == null || _lastPort == null) {
      throw Exception('No previous connection information available');
    }
    return connect(_lastIp!, _lastPort!);
  }

  Future<bool> pingServer(String ip, int port) async {
    try {
      final con = WebSocketChannel.connect(Uri.parse('ws://$ip:$port'));
      await con.ready.timeout(const Duration(seconds: 4));
      con.sink.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  void _addDevice(Device device) {
    if (_devices.map<String>((e) => e.ip).contains(device.ip)) return;
    _devices.add(device);
    _scanController.add(_devices);
  }

  int sumPort(int port, int min) {
    if (port == min) {
      return min;
    }
    return port + sumPort(port - 1, min);
  }
}
