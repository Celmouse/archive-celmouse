import 'package:controller/src/UI/components/support_button.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_page.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../utils/launch_site.dart';
import 'connect_qr_code.dart';
import '../../core/connect.dart';
import 'network_scanner.dart';

class ConnectToServerPage extends StatefulWidget {
  const ConnectToServerPage({super.key});

  @override
  State<ConnectToServerPage> createState() => _ConnectToServerPageState();
}

class _ConnectToServerPageState extends State<ConnectToServerPage> {
  final TextEditingController ipController = TextEditingController();
  String connError = "";
  bool isLoading = false;
  bool isConnecting = false;
  List<Map<String, String>> networkDevices = [];

  @override
  void initState() {
    super.initState();
    _scanNetwork();
  }

  void _scanNetwork() {
    setState(() {
      isLoading = true;
    });

    final stream = NetworkScanner.scanNetwork();
    stream.listen((device) {
      setState(() {
        networkDevices.add(device);
      });
    }).onDone(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  connect() async {
    setState(() {
      isConnecting = true;
    });
    try {
      await connectWS(ipController.text, (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }).timeout(const Duration(seconds: 10));
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MoveMousePage(),
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
        isConnecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String version = packageInfo.version;

            if (!context.mounted) return;
            showDialog(
                builder: (context) => AlertDialog(
                      icon: Image.asset(
                        "assets/logo.png",
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
                          const Text("HUB Min Version: 2.1.0"),
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
        title: const Text('Connect'),
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
        child: Stack(
          children: [
            Column(
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
                    const Text("4. Start moving your pointer."),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Connection Options',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.wifi),
                          title: const Text('Discover Network Devices'),
                          subtitle: const Text(
                              'Automatically discover devices on your network'),
                          onTap: () {
                            setState(() {
                              networkDevices.clear();
                            });
                            _scanNetwork();
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.input),
                          title: const Text('Enter HUB IP Manually'),
                          subtitle: const Text(
                              'Connect to the HUB using its IP address'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Enter HUB IP'),
                                content: TextField(
                                  controller: ipController,
                                  decoration: const InputDecoration(
                                    labelText: 'HUB IP',
                                    hintText: '192.168.0.1',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      connect();
                                    },
                                    child: const Text('Connect'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.qr_code_scanner),
                          title: const Text('Scan QR Code'),
                          subtitle: const Text(
                              'Scan a QR code to connect to the HUB'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ConnectFromQrCodePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Available devices on your network:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        networkDevices.clear();
                      });
                      _scanNetwork();
                    },
                    child: ListView.builder(
                      itemCount: networkDevices.length,
                      itemBuilder: (context, index) {
                        final device = networkDevices[index];
                        return ListTile(
                          title: Text(device['ip'] ?? ''),
                          subtitle: Text('Name: ${device['host']}'),
                          onTap: () {
                            setState(() {
                              ipController.text = device['ip'] ?? '';
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading)
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
