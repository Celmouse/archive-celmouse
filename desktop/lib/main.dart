import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'src/mouse.dart';

/// Documentos para ajudar com os plugins
///
/// https://pub.dev/packages/ffigen#configurations
/// https://docs.flutter.dev/packages-and-plugins/developing-packages#plugin-ffi
/// https://pub.dev/packages/melos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // initWebSocket();
  }

  // initWebSocket() async {
  //   final server = await ServerSocket.bind(InternetAddress('0.0.0.0'), 7771);
  //   print(server.address);
  //   server.listen((Socket socket) {
  //     // socket.setOption(SocketOption.tcpNoDelay, true);
  //     socket.listen((data) {

  //       String readableContent = utf8.decode(Uint8List.fromList(data));
  //       print(readableContent);

  //     }, onDone: () {
  //       print("Conexão encerrada");
  //     });
  //     socket.
  //   });
  // }

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
