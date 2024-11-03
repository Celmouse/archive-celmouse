import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:server/src/core/mouse.dart';
// import 'package:server/src/core/socket.dart';
import 'package:mouse/mouse.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    print(Mouse().move());
    super.initState();
    
  }
  bool binded = false;

  initWebSocket() async {
    if (binded) return;
    final server = await HttpServer.bind('0.0.0.0', 7771);
    binded = true;

    // final SocketInterpreter interpreter = SocketInterpreter(mouse: Mouse());

    await for (HttpRequest request in server) {
      var socket = await WebSocketTransformer.upgrade(request);
      print('Servidor em ws://${server.address.address}:7771');
      // socket.listen(interpreter.interpretEvents);
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
