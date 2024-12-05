import 'dart:async';
import 'package:controller/src/UI/components/support_button.dart';
import 'package:controller/src/features/connect/input_ip/ui/pages/enter_hub_ip_tile.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_page.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../utils/launch_site.dart';
import '../../UI/connect/connect_qr_code.dart';
import '../../core/connect.dart';
import '../../core/network_scanner.dart';

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
  bool isWebSocketTry = false;
  bool connectionEstablished = false;
  bool isGrantedAccess = false;
  bool deviceFound = false; // Add this state variable
  StreamSubscription<Map<String, String>>? _subscription;
  List<Map<String, String>> availableDevices = [];

  @override
  void initState() {
    super.initState();
    _gatherIPs();
  }

  void _gatherIPs() async {
    setState(() {
      isLoading = true;
    });


    final stream = NetworkScanner.scanNetwork();

    _subscription = stream.listen((device) {
      final ip = device['ip']!;
      final port = int.parse(device['port']!);
      final host = device['host']!;
      print("Found device: $ip:$port ($host)");

      // Skip common router IP addresses
      if (ip == '192.168.1.1' || ip == '192.168.0.0' || ip == '192.168.0.1') {
        print("$ip is a common router IP, skipping...");
        return;
      }

      setState(() {
        availableDevices.add({'ip': ip, 'port': port.toString(), 'host': host});
        deviceFound = true; // Set deviceFound to true when a device is found
        isLoading = false; // Stop the progress bar when a device is found
      });
    });

    _subscription?.onDone(() {
      print("IP gathering done");
      setState(() {
        isLoading = false;
      });
    });
  }

  void disconnect() {
    disconnectWS();
    setState(() {
      connectionEstablished = false;
    });
  }

  void _scanAndConnect() async {
    setState(() {
      isLoading = true;
    });

    for (var device in availableDevices) {
      if (connectionEstablished) {
        // disconnect from the previous connection
        disconnect();
      }

      final ip = device['ip']!;
      final port = int.parse(device['port']!);
      // print("Connecting to $ip:$port");

      try {
        isWebSocketTry = true;
        await connectWS(ip, port, (err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(err),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        }).timeout(const Duration(seconds: 10));
        if (mounted) {
          setState(() {
            connectionEstablished =
                true; // Set the flag to stop further attempts
            isLoading = false;
          });
          print("Successfully connected to $ip:$port");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MoveMousePage(),
            ),
          );
          break;
        }
      } catch (e) {
        // Connection failed, continue scanning
        print("Failed to connect to $ip:$port");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  connect(String ip, int port) async {
    setState(() {
      isConnecting = true;
      connectionEstablished = true; // Set the flag to stop further attempts
    });
    try {
      await connectWS(ip, port, (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }).timeout(const Duration(seconds: 10));
      if (mounted) {
        print("Successfully connected to $ip:$port");
        setState(() {
          isGrantedAccess = true;
        });
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
  void dispose() {
    _subscription?.cancel();
    super.dispose();
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
              disconnect();
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            title: const Text('Connect to My Device'),
                            subtitle: isLoading
                                ? const Text('Loading...')
                                : const Text('Auto connect to the HUB'),
                            trailing: deviceFound
                                ? const Icon(Icons.circle,
                                    color: Colors.green, size: 12)
                                : null,
                            onTap: () {
                              _scanAndConnect();
                            },
                          ),
                          const Divider(),
                          EnterHubIPTile(
                            onConnectionSuccess: () {
                              setState(() {
                                isGrantedAccess = true;
                              });
                            },
                          ), // Use the EnterHubIPTile component here
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.qr_code_scanner),
                            title: const Text('Scan QR Code'),
                            subtitle: const Text(
                                'Scan a QR code to connect to the HUB'),
                            onTap: () {
                              disconnect();
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
