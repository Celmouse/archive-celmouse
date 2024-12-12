import 'package:controller/src/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/data/repositories/connection_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late ConnectionRepository _connectionRepository;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has resumed
      print('App has resumed');
      // Reconnect to WebSocket or perform other necessary actions
      _connectionRepository.reconnect();
    } else if (state == AppLifecycleState.paused) {
      // App has paused (gone to background)
      print('App has paused');
      // Disconnect from WebSocket or perform other necessary actions
      _connectionRepository.disconnect();
    } else if (state == AppLifecycleState.inactive) {
      // App is inactive (e.g., when the phone is locked)
      print('App is inactive');
    } else if (state == AppLifecycleState.detached) {
      // App is detached (e.g., when the app is terminated)
      print('App is detached');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _connectionRepository =
        Provider.of<ConnectionRepository>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectionRepository.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Celmouse',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
