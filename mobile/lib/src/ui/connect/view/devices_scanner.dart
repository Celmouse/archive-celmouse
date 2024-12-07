import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/connect/viewmodel/devices_scanner_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class DevicesScanner extends StatelessWidget {
  const DevicesScanner({
    super.key,
    required this.connectionViewmodel,
  });

  final ConnectHUBViewmodel connectionViewmodel;

  @override
  Widget build(BuildContext context) {
    final viewmodel = DevicesScannerViewmodel(
      connectionRepository: context.read(),
    );

    viewmodel.startScan();

    return ListenableBuilder(
      listenable: viewmodel,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.wifi),
              title: const Text('Scanning for nearby devices'),
              subtitle: viewmodel.isScanning ? const Text('Scanning...') : null,
              enabled: viewmodel.isScanning,
              trailing: viewmodel.isScanning
                  ? Animate(
                      effects: const [
                        FadeEffect(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ],
                      onPlay: (controller) => controller.repeat(),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.blue,
                        size: 12,
                      ),
                    )
                  : null,
            ),
            ...viewmodel.devices.map((device) {
              return ListTile(
                title: Text(device.name),
                trailing: const Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 12,
                ),
                onTap: () => connectionViewmodel.connect(device.ip),
              );
            }),
          ],
        );
      },
    );
  }
}
