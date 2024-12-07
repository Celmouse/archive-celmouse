import 'dart:async';
import 'package:controller/src/domain/models/devices.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  final List<int> defaultPorts = [7771];

  final StreamController<Device> _scanController = StreamController.broadcast();

  Future<WebSocketChannel> connect(String ip, int port) async {
    try {
      final socket = WebSocketChannel.connect(Uri.parse('ws://$ip:$port'));
      //TODO: Study the duration timeout. (2 seconds can be too short)
      await socket.ready.timeout(const Duration(seconds: 2));
      return socket;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> disconnect(WebSocketChannel socket) => socket.sink.close();

  Stream<Device> scan() => _scanController.stream;

  Future<void> stopScan() async {
    //TODO: Implement stop scan
    // _scanController.close();
  }

  Future<void> startScan() async {
    _scan();
  }

  _scan() async {
    final info = NetworkInfo();
    final String? ip = await info.getWifiIP();

    final subnet = ip?.substring(0, ip.lastIndexOf('.'));
    for (int i = 2; i < 255; i++) {
      final host = '$subnet.$i';
      connect(host, 7771).then((r) {
        _scanController.add(Device(
          name: 'Device $i',
          ip: host,
          port: 7771,
        ));
        disconnect(r);
      }, onError: (e) {
        // print("Not found: $e");
        // ignore not found devices
      });
    }
  }
}
