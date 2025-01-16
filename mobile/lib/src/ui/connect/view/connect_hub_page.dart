import 'dart:io';
import 'package:controller/src/config/enviroment.dart';
import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/ads/view/banner.dart';
import 'package:controller/src/ui/connect/view/devices_scanner.dart';
import 'package:controller/src/ui/core/ui/support_button.dart';
import 'package:controller/src/ui/connect/view/enter_hub_ip_tile.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/core/ui/app_info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/launch_site.dart';
import 'package:controller/src/UI/ads/manager/ad_manager.dart';

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
  final String adUnitId = Platform.isAndroid
      ? EnviromentVariables.admobBannerIdAndroid
      : EnviromentVariables.admobBannerId;

  final adManager = AdManager();
  bool isFirstConnection = true;
  DateTime connectionStartTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    widget.viewmodel.addListener(_listener);
    widget.viewmodel.startScan();
    _loadConnectionTime();
    adManager.loadRewardedAd(); // Preload the ad when the page is initialized
  }

  @override
  void dispose() {
    widget.viewmodel.removeListener(_listener);
    widget.viewmodel.stopScan();
    super.dispose();
  }

  void _listener() {
    if (widget.viewmodel.isConnected) {
      final connectionDuration = DateTime.now().difference(connectionStartTime);
      if (isFirstConnection &&
          connectionDuration > const Duration(minutes: 1)) {
        _showAdOnReconnect();
      } else if (!isFirstConnection &&
          connectionDuration > const Duration(minutes: 1)) {
        _showAdOnReconnect();
      }
      isFirstConnection = false;
      connectionStartTime = DateTime.now();
      _saveConnectionTime();
      if (mounted) {
        context.go(Routes.mouse);
      }
    }
  }

  Future<void> _loadConnectionTime() async {
    final prefs = await SharedPreferences.getInstance();
    final connectionTimeString = prefs.getString('connectionStartTime');
    if (connectionTimeString != null) {
      connectionStartTime = DateTime.parse(connectionTimeString);
    }
    isFirstConnection = prefs.getBool('isFirstConnection') ?? true;
  }

  Future<void> _saveConnectionTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'connectionStartTime', connectionStartTime.toIso8601String());
    await prefs.setBool('isFirstConnection', isFirstConnection);
  }

  Future<void> _showAdOnReconnect() async {
    if (adManager.isRewardedAdReady) {
      await adManager.showRewardedAd();
    } else {
      await adManager.loadRewardedAd();
      if (adManager.isRewardedAdReady) {
        await adManager.showRewardedAd();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ad not ready yet.'),
            ),
          );
        }
        print('Ad not ready yet.');
      }
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      DevicesScanner(viewmodel: widget.viewmodel),
                      const Divider(),
                      EnterHubIPTile(viewmodel: widget.viewmodel),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.qr_code_scanner),
                        title: const Text('Connect via QR Code'),
                        onTap: () {
                          if (mounted) {
                            context.go(Routes.connectQRCode);
                          }
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
