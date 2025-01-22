import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/device_info_service.dart';
import 'package:server/src/data/services/keyboard_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'package:server/src/data/socket_repository.dart';
import 'package:server/src/ui/home/viewmodel/home_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeViewmodel viewmodel;

  @override
  void initState() {
    viewmodel = HomeViewmodel(
      socketRepository: SocketRepository(
        mouseService: MouseService(),
        keyboardService: KeyboardService(),
        deviceInfoService: DeviceInfoService(),
        connectionService: ConnectionService(),
      ),
    );

    super.initState();
    viewmodel.init();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.support_agent, color: Colors.red.shade400),
          tooltip: "Contact Support",
          onPressed: () {
            launchUrl(Uri.parse(
              "https://api.whatsapp.com/send?phone=5533997312898",
            ));
          },
        ),
        centerTitle: true,
        title: const Text(
          "Celmouse",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.code, color: Colors.blue.shade400),
            tooltip: "Visit Website",
            onPressed: () {
              launchUrl(Uri.parse("https://celmouse.com"));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListenableBuilder(
            listenable: viewmodel,
            builder: (context, child) {
              if (viewmodel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viewmodel.connected) {
                return Column(
                  spacing: 8,
                  children: [
                    _buildGlassmorphicCard(
                      child: Row(
                        children: [
                          Text(
                            "Connected",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewmodel.disconnect();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        height: 48,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Icon(Icons.logout, size: 16),
                            Text("Disconnect"),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  // Top Section
                  _buildGlassmorphicCard(
                    child: _buildConnectionStatus(),
                  ),
                  const SizedBox(height: 20),
                  // Middle Section
                  Expanded(
                    child: isSmallScreen
                        ? const SizedBox()
                        : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: _buildGlassmorphicCard(
                                  child: _buildQRCodeCard(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: _buildGlassmorphicCard(
                                  child: _buildActiveConnectionsList(),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicCard({
    required Widget child,
    double? height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: .6),
            Colors.white.withValues(alpha: .3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: .4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildExplanatoryText() {
    return Column(
      spacing: 4,
      children: [
        _buildInstructions(
          Icons.download,
          "1. Open or download Celmouse client app on mobile (Android or iOS).",
        ),
        _buildInstructions(
          Icons.qr_code_scanner,
          "2. Scan the QR code from the desktop app or enter IP manually or wait for auto-connect to known device on mobile.",
        ),
        _buildInstructions(
          Icons.check_circle,
          "3. You are all set!",
        ),
      ],
    );
  }

  _buildInstructions(IconData iData, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(iData, color: Colors.blue, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTutorialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildExplanatoryText(),
      ],
    );
  }

  Widget _buildIPSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewmodel.selectedIP!,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Connection Status
        _buildStatusSection(),
        const SizedBox(height: 8),

        // Section 2: IP Address (if connected)
        if (viewmodel.connected) _buildIPSection(),

        // Section 3: Tutorial Steps (if not connected)
        if (!viewmodel.connected) _buildTutorialSection(),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Row(
      children: [
        Text(
          "Not Connected",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.cancel,
          color: Colors.red,
          size: 24,
        ),
      ],
    );
  }

  Widget _buildQRCodeCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Scan to Connect",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        if (viewmodel.selectedIP != null)
          QrImageView(
            data: viewmodel.selectedIP!,
            version: QrVersions.auto,
            size: 200,
          ),
      ],
    );
  }

  Widget _buildActiveConnectionsList() {
    final availableIPS = viewmodel.availableIPS;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Available Connections",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: availableIPS.isEmpty
              ? Center(
                  child: Text(
                    "No active connections",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: availableIPS.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.language, color: Colors.blue),
                      title: Text(availableIPS[index]),
                      trailing: const Icon(Icons.qr_code, color: Colors.grey),
                      onTap: () {
                        viewmodel.selectIP(availableIPS[index]);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
