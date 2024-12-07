import 'dart:async';
import 'package:controller/src/domain/models/devices.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  final List<int> defaultPorts = [7771];

  final List<Device> _devices = <Device>[];

  Future<WebSocketChannel> connect(String ip, int port) async {
    try {
      final socket = WebSocketChannel.connect(Uri.parse('ws://$ip:$port'));
      // 2 seconds can be too short
      await socket.ready.timeout(const Duration(seconds: 2));
      return socket;
    } catch (e) {
      rethrow;
    }
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

  Future<void> disconnect(WebSocketChannel socket) => socket.sink.close();


  //TODO: Improve the scanning feature
  bool _stopScan = false;

  final StreamController<List<Device>> _scanController =
      StreamController.broadcast();
  Stream<List<Device>> scan() => _scanController.stream;

  Future<void> stopScan() async {
    _stopScan = true;
  }

  Future<void> startScan([int retryInterval = 5, int retryCount = 100]) async {
    for (int count = 0; count < retryCount; count++) {
      print("Retry Attemp: $count");
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
