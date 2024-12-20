import 'dart:convert';
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'package:server/src/data/socket_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/services/keyboard_service.dart';
import 'package:protocol/protocol.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> availableIPS = [];
  WebSocket? socket;
  ConnectionInfoProtocolData? deviceInfo;

  @override
  void initState() {
    super.initState();
    initWebSocket();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    final info = await ConnectionService.getDeviceInfo();
    setState(() {
      deviceInfo = info;
    });
    print('Device Info: $deviceInfo'); // Debug print to verify info
  }

  initWebSocket() async {
    final server = await HttpServer.bind('0.0.0.0', 7771);
    NetworkInterface.list().then((ips) {
      for (var i in ips) {
        for (var a in i.addresses) {
          setState(() {
            availableIPS.add(a.address);
          });
        }
      }
    });

    final SocketRepository interpreter = SocketRepository(
      mouse: MouseService(),
      keyboard: KeyboardService(),
      connection: ConnectionService(),
    );

    await for (HttpRequest request in server) {
      final s = await WebSocketTransformer.upgrade(request);
      setState(() {
        socket = s;
      });
      await DesktopWindow.setWindowSize(const Size(250, 150), animate: true);

      debugPrint('Server: ws://${server.address.address}:7771');

      // Send device info on connection
      final deviceInfo = await ConnectionService.getDeviceInfo();
      socket?.add(jsonEncode(deviceInfo));

      socket?.listen(interpreter.interpretEvents, onDone: () async {
        setState(() {
          socket = null;
        });
        await DesktopWindow.setWindowSize(const Size(250, 400), animate: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Celmouse",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          /// display version here in little and
          /// gray
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "v${deviceInfo?.versionNumber}",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.grey),
            ),
          ),
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse("https://api.whatsapp.com/send?phone=5533997312898"),
              );
            },
            icon: const Icon(
              Icons.support_agent,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse("https://celmouse.com"),
              );
            },
            icon: const Icon(
              Icons.code_sharp,
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: socket != null
              ? SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Connected",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (deviceInfo != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deviceInfo!.deviceName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                deviceInfo!.deviceOS.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      Text(
                        "IPs: ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ListView.separated(
                        itemCount: availableIPS.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "- ${availableIPS[index]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              QrImageView(
                                data: availableIPS[index],
                                version: QrVersions.auto,
                                size: 160.0,
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 28,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
