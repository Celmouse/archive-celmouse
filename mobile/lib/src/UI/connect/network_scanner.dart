import 'dart:async';
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:dart_ping/dart_ping.dart';

class NetworkScanner {
  static Stream<Map<String, String>> scanNetwork() async* {
    final info = NetworkInfo();
    final String? ip = await info.getWifiIP();

    if (ip == null) {
      throw Exception('Unable to get device IP');
    }

    final subnet = ip.substring(0, ip.lastIndexOf('.'));

    for (int i = 1; i < 255; i++) {
      final host = '$subnet.$i';
      final ping = Ping(host, count: 1);

      await for (final event in ping.stream) {
        if (event.response != null) {
          final internetAddress = InternetAddress(host);
          final hostName = await internetAddress
              .reverse()
              .then((value) => value.host)
              .catchError((_) => 'Unknown');
          yield {
            'ip': host,
            'host': hostName,
            'mac':
                'Unknown', // MAC address retrieval is limited on mobile platforms
          };
        }
      }
    }
  }
}
