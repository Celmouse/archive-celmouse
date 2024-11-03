
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/src/core/mouse.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool binded = false;

  initWebSocket() async {
    if (binded) return;
    final server = await HttpServer.bind('0.0.0.0', 7771);
    binded = true;

    await for (HttpRequest request in server) {
      var socket = await WebSocketTransformer.upgrade(request);
      print(
        'Servidor WebSocket escutando em ws://${server.address.address}:7771',
      );
      socket.listen((data) {
        data = jsonDecode(data);
        print(data.runtimeType);
        if (data['event'] == "MouseMove") {
          double x = data["data"]["x"];
          double y = data["data"]["y"];
          Mouse().moveMouse(x.round(), y.round());
        }
      });
      if (request.uri.path == '/ws') {
      } else {
        request.response
          ..statusCode = HttpStatus.forbidden
          ..close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initWebSocket();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Celmouse"),
      ),
      body: const Center(
        child: Text('Olá'),
      ),
    );
  }
}
