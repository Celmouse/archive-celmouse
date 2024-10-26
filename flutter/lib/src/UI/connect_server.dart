import 'package:controller/src/UI/components/support_button.dart';
import 'package:controller/src/UI/cursor/cursor_move.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'connect_qr_code.dart';
import '../core/connect.dart';

class ConnectToServerPage extends StatefulWidget {
  const ConnectToServerPage({super.key});

  @override
  State<ConnectToServerPage> createState() => _ConnectToServerPageState();
}

class _ConnectToServerPageState extends State<ConnectToServerPage> {
  WebSocketChannel? channel;

  final TextEditingController ipController = TextEditingController();

  String connError = "";

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  connect() async {
    setState(() {
      isLoading = true;
    });
    try {
      channel = await connectWS(ipController.text, (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }).timeout(const Duration(seconds: 10));
      if (channel != null && mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoveMousePage(
              channel: channel!,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Erro de conexão, IP incorreto, tente outro"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } else {
        setState(() {
          connError = "Erro de conexão, IP incorreto...";
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar'),
        centerTitle: true,
        actions: [
          const SupportButtonComponent(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectFromQrCodePage(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
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
                    "How to find my computer's local IP?",
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.only(bottom: 16),
                  children: [
                    'Donwload the Desktop App.',
                    'On Windows: Launch the Power Shell',
                    'Type the command: ipconfig getifaddr en0',
                    'On Linux: Launch the terminal',
                    'Type the command: ifconfig en0',
                    'On MacOS: Launch the terminal',
                    'Type the command: ipconfig getifaddr en0',
                    "The IP usually is 4x 1 to 3 digits separated by dots.",
                    "Looks like: 192.168.0.100"
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
                  onSubmitted: (_) => connect(),
                  decoration: const InputDecoration(
                    labelText: 'Type the Desktop App IP',
                  ),
                ),
                Visibility(
                  visible: connError.isNotEmpty,
                  child: Text(connError,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          )),
                ),
                ElevatedButton(
                  onPressed: connect,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              strokeCap: StrokeCap.square,
                            )
                          : const Text('Connect'),
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
