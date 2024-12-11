import 'dart:async';
import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/connect_from_qr/viewmodel/connect_qr_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ConnectFromQrCodePage extends StatefulWidget {
  const ConnectFromQrCodePage({
    super.key,
    required this.viewmodel,
  });

  final ConnectQrViewmodel viewmodel;

  @override
  State<ConnectFromQrCodePage> createState() => _ConnectFromQrCodePageState();
}

class _ConnectFromQrCodePageState extends State<ConnectFromQrCodePage>
    with WidgetsBindingObserver {
  late final MobileScannerController controller;

  StreamSubscription<Object?>? _subscription;

  _handleBarcode(BarcodeCapture e) async {
    if (e.barcodes.first.rawValue == null) return;
    widget.viewmodel.connect(e.barcodes.first.rawValue!);
  }

  void _listener() {
    if (widget.viewmodel.isConnected) {
      context.go(Routes.mouse);
    }
    if (widget.viewmodel.isLoading) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
    if (widget.viewmodel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(widget.viewmodel.errorMessage!),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController(
      // required options for the scanner
      detectionSpeed: DetectionSpeed.noDuplicates,
      detectionTimeoutMs: 1000,
    );

    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);
    widget.viewmodel.addListener(_listener);

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
    widget.viewmodel.removeListener(_listener);

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
        child: LoaderOverlay(
          overlayWidgetBuilder: (progress) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          },
          overlayColor: Colors.black54,

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
