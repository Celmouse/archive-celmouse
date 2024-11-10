import 'package:controller/src/UI/components/support_button.dart';
import 'package:controller/src/UI/connect/connection_menu.dart';
import 'package:controller/src/UI/cursor/cursor_move.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../utils/launch_site.dart';
import 'connect_qr_code.dart';
import '../../core/connect.dart';

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
          content: const Text("Failed to connect, try again"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } else {
        setState(() {
          connError = "Failed to connect, try another IP";
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
        leading: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String version = packageInfo.version;

            if (!context.mounted) return;
            showDialog(
                builder: (context) => AlertDialog(
                      icon: Image.asset(
                        "assets/icon_32x32@2x.png",
                        height: 52,
                        width: 52,
                      ),
                      title: const Text("Celmouse"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("© 2024 Celmouse Ltda."),
                          const SizedBox(height: 4),
                          Text("Version: $version"),
                          TextButton(
                            onPressed: () => launchSite(),
                            child: const Text(
                              "Visit Website",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                context: context);
          },
        ),
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
                    "How to use this app?",
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.only(bottom: 16),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    const Text("1. Check if your phone supports gyroscope."),
                    GestureDetector(
                      onTap: () => launchSite(),
                      child: const Text(
                        '2. Download the HUB.',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Text("3. Connect to the HUB."),
                    const Text("4. Start moving you pointer."),
                  ],
                ),
                TextField(
                  controller: ipController,
                  onSubmitted: (_) => connect(),
                  decoration: const InputDecoration(
                    labelText: 'Type the HUB IP',
                    hintText: "168.192.0.1",
                    hintStyle: TextStyle(
                      color: Colors.white12,
                    ),
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
                Visibility(
                  visible: false,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConnectionMenuPage(),
                        ),
                      );
                    },
                    child: const Text("Try another way"),
                  ),
                )
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
