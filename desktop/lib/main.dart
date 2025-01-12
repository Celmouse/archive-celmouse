import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:server/src/ui/home/view/home_page.dart';
import 'package:server/src/ui/home/viewmodel/home_viewmodel.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/device_info_service.dart';
import 'package:server/src/data/services/keyboard_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'package:server/src/data/socket_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(800, 600),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Celmouse',
          theme: ThemeData(
            primarySwatch: Colors.blue,
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
      },
    );
  }
}
