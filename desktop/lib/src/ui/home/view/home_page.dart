import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/src/ui/home/viewmodel/home_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.viewmodel,
  });

  final HomeViewmodel viewmodel;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await widget.viewmodel.init();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    widget.viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
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
            icon: Icon(Icons.support_agent, color: Colors.red.shade400),
            tooltip: "Contact Support",
            onPressed: () {
              launchUrl(Uri.parse(
                  "https://api.whatsapp.com/send?phone=5533997312898"));
            },
          ),
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
            Colors.white.withOpacity(0.6),
            Colors.white.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStep(
          icon: Icons.download,
          text:
              "1. Open or download Celmouse client app on mobile (Android or iOS).",
        ),
        const SizedBox(height: 8),
        _buildStep(
          icon: Icons.qr_code_scanner,
          text:
              "2. Scan the QR code from the desktop app or enter IP manually or wait for auto-connect to known device on mobile.",
        ),
        const SizedBox(height: 8),
        _buildStep(
          icon: Icons.check_circle,
          text: "3. You are all set!",
        ),
      ],
    );
  }

  Widget _buildStep({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue, size: 16),
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
        ValueListenableBuilder<String?>(
          valueListenable: widget.viewmodel.selectedIP,
          builder: (context, selectedIP, child) {
            return Text(
              selectedIP ?? "Unknown",
              style: const TextStyle(
                fontSize: 12,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    final isConnected = widget.viewmodel.connected.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Connection Status
        _buildStatusSection(isConnected),
        const SizedBox(height: 8),

        // Section 2: IP Address (if connected)
        if (isConnected) _buildIPSection(),

        // Section 3: Tutorial Steps (if not connected)
        if (!isConnected) _buildTutorialSection(),
      ],
    );
  }

  Widget _buildStatusSection(bool isConnected) {
    return Row(
      children: [
        Text(
          isConnected ? "Connected" : "Not Connected",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isConnected ? Icons.check_circle : Icons.cancel,
          color: isConnected ? Colors.green : Colors.red,
          size: 24,
        ),
        const Spacer(),
        if (isConnected)
          ElevatedButton(
            onPressed: () {
              widget.viewmodel.disconnect();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 16),
              ],
            ),
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
        ValueListenableBuilder<String?>(
          valueListenable: widget.viewmodel.selectedIP,
          builder: (context, selectedIP, child) {
            return QrImageView(
              data: selectedIP ?? '',
              version: QrVersions.auto,
              size: 200,
            );
          },
        ),
      ],
    );
  }

  Widget _buildActiveConnectionsList() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: widget.viewmodel.availableIPS,
      builder: (context, availableIPS, child) {
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
                        "No Available Connections",
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
                          leading:
                              const Icon(Icons.language, color: Colors.blue),
                          title: Text(availableIPS[index]),
                          trailing:
                              const Icon(Icons.qr_code, color: Colors.grey),
                          onTap: () {
                            widget.viewmodel.selectedIP.value =
                                availableIPS[index];
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
