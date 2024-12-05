import 'dart:async';
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkScanner {
  static Stream<Map<String, String>> scanNetwork(
      {List<int> ports = const [6589, 8443, 7771],
      int maxConcurrentConnections = 10}) async* {
    final info = NetworkInfo();
    final String? ip = await info.getWifiIP();

    if (ip == null) {
      throw Exception('Unable to get device IP');
    }

    final subnet = ip.substring(0, ip.lastIndexOf('.'));
    final connectionFutures = <Future<Map<String, String>?>>[];

    for (int i = 1; i < 255; i++) {
      final host = '$subnet.$i';
      for (int port in ports) {
        connectionFutures.add(_attemptConnection(host, port));
        if (connectionFutures.length >= maxConcurrentConnections) {
          final results = await Future.wait(connectionFutures);
          for (var result in results) {
            if (result != null) {
              yield result;
            }
          }
          connectionFutures.clear();
        }
      }
    }

    // Wait for any remaining connection attempts to complete
    final results = await Future.wait(connectionFutures);
    for (var result in results) {
      if (result != null) {
        yield result;
      }
    }
  }

  static Future<Map<String, String>?> _attemptConnection(
      String host, int port) async {
    try {
      final socket =
          await Socket.connect(host, port).timeout(const Duration(seconds: 5));
      socket.destroy();
      final internetAddress = InternetAddress(host);
      final hostName = await internetAddress
          .reverse()
          .then((value) => value.host)
          .catchError((_) => 'Unknown');
      return {'ip': host, 'host': hostName, 'port': port.toString()};
    } catch (e) {
      // Connection failed, return null
      return null;
    }
  }
}
