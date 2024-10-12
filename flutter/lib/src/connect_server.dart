import 'package:controller/src/cursor_move.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectToServerPage extends StatefulWidget {
  const ConnectToServerPage({super.key});

  @override
  State<ConnectToServerPage> createState() => _ConnectToServerPageState();
}

class _ConnectToServerPageState extends State<ConnectToServerPage> {
  var macIP = "192.168.52.102";
  late TextEditingController ipController = TextEditingController(text: macIP);
  WebSocketChannel? channel;

  connect([String? ipAdd]) {
    macIP = ipAdd ?? (ipController.text.isEmpty ? macIP : ipController.text);
    setState(() {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://$macIP:8080'),
      );
    });
    if (channel == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoveMousePage(channel: channel!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Visibility(
            visible: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpansionTile(
                  dense: true,
                  tilePadding: EdgeInsets.zero,
                  title: const Text(
                    'Como descobrir o IP do meu computador?',
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.only(bottom: 16),
                  children: [
                    'No Windows: Acesse o power shell',
                    'Digite o comando: ipconfig getifaddr en0',
                    'No Linux: Acesse o terminal do Linux',
                    'Digite o comando: ifconfig en0',
                    'No MacOS: Acesse o terminal do MacOS',
                    'Digite o comando: ipconfig getifaddr en0',
                  ]
                      .asMap()
                      .map((i, v) {
                        return MapEntry(i, Text('${i + 1}: $v'));
                      })
                      .values
                      .toList(),
                ),
                TextField(
                  controller: ipController,
                  onSubmitted: connect,
                  decoration: const InputDecoration(
                    labelText: 'Digite o IP do dispositivo',
                  ),
                ),
                ElevatedButton(
                  onPressed: connect,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Conectar'),
                    ),
                  ),
                ),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
