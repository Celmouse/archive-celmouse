import 'package:flutter/material.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/device_info_service.dart';
import 'package:server/src/data/services/keyboard_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'package:server/src/data/socket_repository.dart';
import 'package:server/src/ui/home/viewmodel/home_viewmodel.dart';

import 'src/ui/home/view/home_page.dart';

Future<void> main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celmouse HUB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: Home(
        viewmodel: HomeViewmodel(
          socketRepository: SocketRepository(
            mouseService: MouseService(),
            keyboardService: KeyboardService(),
            deviceInfoService: DeviceInfoService(),
            connectionService: ConnectionService(),
          ),
        ),
      ),
    );
  }
}
