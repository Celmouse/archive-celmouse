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

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //TODO: Implement viewmodel
  List<String> availableIPS = [];
  WebSocket? socket;

  @override
  void initState() {
    super.initState();
    initWebSocket();
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
                      Expanded(
                        child: Text(
                          "Connected",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        itemCount: availableIPS.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'IP Address: ${availableIPS[index]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Center(
                                    child: QrImageView(
                                      data: availableIPS[index],
                                      version: QrVersions.auto,
                                      size: 160.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
