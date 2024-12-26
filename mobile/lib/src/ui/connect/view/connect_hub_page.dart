import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/ads/view/banner.dart';
import 'package:controller/src/ui/connect/view/devices_scanner.dart';
import 'package:controller/src/ui/core/ui/support_button.dart';
import 'package:controller/src/ui/connect/view/enter_hub_ip_tile.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/core/ui/app_info_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/launch_site.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    widget.viewmodel.addListener(_listener);
    if (kDebugMode) {
      widget.viewmodel.startScan();
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.viewmodel.removeListener(_listener);
    if (kDebugMode) {
      widget.viewmodel.stopScan();
    }
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ExpansionTile(
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
                        '2. Download the HUB (Version 2.2.0)',
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
                      if (kDebugMode)
                        DevicesScanner(viewmodel: widget.viewmodel),
                      const Divider(),
                      EnterHubIPTile(viewmodel: widget.viewmodel),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.qr_code_scanner),
                        title: const Text('Connect via QR Code'),
                        onTap: () {
                          context.go(Routes.connectQRCode);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              const BannerAdWidget(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
