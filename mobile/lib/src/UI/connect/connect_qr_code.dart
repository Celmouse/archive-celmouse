import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/connect.dart';
import '../../features/mouse/move/ui/mouse_move_page.dart';

class ConnectFromQrCodePage extends StatefulWidget {
  const ConnectFromQrCodePage({super.key});

  @override
  State<ConnectFromQrCodePage> createState() => _ConnectFromQrCodePageState();
}

class _ConnectFromQrCodePageState extends State<ConnectFromQrCodePage>
    with WidgetsBindingObserver {
  late final MobileScannerController controller;

  StreamSubscription<Object?>? _subscription;

  _handleBarcode(BarcodeCapture e) async {
    final value = e.barcodes.first.rawValue ?? '';
    setState(() {
      _subscription?.pause();
    });
    try {
      final WebSocketChannel? channel = await connectWS(value, (err) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }, 2);
      if (channel != null && mounted) {
        _subscription?.cancel();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MoveMousePage(
              channel: channel,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Invalid IP, try another!"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
      setState(() {
        _subscription?.resume();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      // required options for the scanner
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 800,
    );

    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect from Qr Code'),
      ),
      body: SafeArea(
        child: MobileScanner(
          controller: controller,
          overlayBuilder: (context, constraints) =>
              _subscription?.isPaused == true
                  ? Container(
                      color: Colors.black.withOpacity(0.7),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox(),
          // overlayBuilder: (context, constraints) => ScannerOverlay(scanWindow: ),
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
