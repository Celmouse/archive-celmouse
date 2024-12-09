import 'dart:async';
import 'package:controller/src/ui/components/support_button.dart';
import 'package:controller/src/ui/connect/view/enter_hub_ip_tile.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_page.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/core/ui/app_info_button.dart';
import 'package:flutter/material.dart';
import '../../../utils/launch_site.dart';
import 'connect_qr_code.dart';
import '../../../core/connect.dart';
import '../../../core/network_scanner.dart';

class ConnectHUBPage extends StatefulWidget {
  const ConnectHUBPage({
    super.key,
    required this.viewmodel,
  });

  final ConnectHUBViewmodel viewmodel;

  @override
  State<ConnectHUBPage> createState() => _ConnectHUBPageState();
}

class _ConnectHUBPageState extends State<ConnectHUBPage> {
  final TextEditingController ipController = TextEditingController();
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
    widget.viewmodel.addListener(_listener);
  }

  @override
  void dispose() {
    //TODO: [Marcelo] Remove this
    _subscription?.cancel();

    widget.viewmodel.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (widget.viewmodel.isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MoveMousePage(),
        ),
      );
    }
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
        leading: const AppInfoButton(),
        title: const Text('Connect'),
        centerTitle: true,
        actions: const [
          SupportButtonComponent(),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
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
                              ? const Text('Scanning...')
                              : const Text('Auto connect to the HUB'),
                          trailing: deviceFound
                              ? const Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 12,
                                )
                              : null,
                          enabled: deviceFound,
                          onTap: () {
                            _scanAndConnect();
                          },
                        ),
                        const Divider(),
                        EnterHubIPTile(viewmodel: widget.viewmodel),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.qr_code_scanner),
                          title: const Text('Scan QR Code'),
                          subtitle: const Text(
                            'Scan a QR code to connect to the HUB',
                          ),
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
        ),
      ),
    );
  }
}
