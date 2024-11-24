import 'dart:async';
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/keyboard.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/src/core/mouse.dart';
import 'package:server/src/core/socket.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initWebSocket();
  }

  List<String> availableIPS = [];
  WebSocket? socket;

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

    final SocketInterpreter interpreter = SocketInterpreter(mouse: Mouse());

    await for (HttpRequest request in server) {
      final s = await WebSocketTransformer.upgrade(request);
      setState(() {
        socket = s;
      });
      await DesktopWindow.setWindowSize(const Size(250, 150), animate: true);

      print('Servidor em ws://${server.address.address}:7771');

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
              launchUrl(Uri.parse(
                  "https://api.whatsapp.com/send?phone=5533997312898"));
            },
            icon: const Icon(
              Icons.support_agent,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              launchUrl(Uri.parse("https://celmouse.com"));
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
                    // mainAxisSize: MainAxisSize.min,
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
                      Text(
                        "IPs: ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ListView.separated(
                        // scrollDirection: Axis.horizontal,
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
