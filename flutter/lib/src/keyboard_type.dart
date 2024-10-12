import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class KeyboardTyppingPage extends StatefulWidget {
  const KeyboardTyppingPage({
    super.key,
    required this.channel,
  });
  
  final WebSocketChannel channel;

  @override
  State<KeyboardTyppingPage> createState() => _KeyboardTyppingPageState();
}

class _KeyboardTyppingPageState extends State<KeyboardTyppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teclado'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Center(
          child: TextField(
            onSubmitted: (text) {
              // Envia mensagem para o WebSocket quando o usuário submeter
              final data = {
                "keyboardTypeEvent": true,
                "message": text,
              };
              widget.channel.sink.add(jsonEncode(data));
            },
            decoration: const InputDecoration(labelText: 'Usar teclado'),
          ),
        ),
      ),
    );
  }
}
