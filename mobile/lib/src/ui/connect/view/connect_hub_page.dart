import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/components/support_button.dart';
import 'package:controller/src/ui/connect/view/enter_hub_ip_tile.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/core/ui/app_info_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/launch_site.dart';
import 'connect_qr_code.dart';
import '../../../core/connect.dart';
import 'devices_scanner.dart';

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
  @override
  void initState() {
    widget.viewmodel.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.viewmodel.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (widget.viewmodel.isConnected) {
      context.go(Routes.mouse);
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
                        DevicesScanner(connectionViewmodel: widget.viewmodel),
                        const Divider(),
                        EnterHubIPTile(viewmodel: widget.viewmodel),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.qr_code_scanner),
                          title: const Text('Connect via QR Code'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
