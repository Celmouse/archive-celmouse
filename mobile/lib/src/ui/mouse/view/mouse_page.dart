import 'package:controller/getit.dart';
import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/keyboard/view/keyboard.dart';
import 'package:controller/src/ui/keyboard/viewmodel/keyboard_view_model.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_body.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_settings_page.dart';
import 'package:controller/src/ui/mouse/viewmodel/mouse_viewmodel.dart';
import 'package:controller/src/ui/trackpad/view/trackpad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/mouse_settings_model.dart';
import '../../../data/services/mouse_settings_persistence_service.dart';

class MousePage extends StatefulWidget {
  const MousePage({
    super.key,
    required this.viewmodel,
  });

  final MouseViewmodel viewmodel;

  @override
  State<MousePage> createState() => _MousePageState();
}

class _MousePageState extends State<MousePage> with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    MouseSettingsPersistenceService.loadSettings().then((settings) {
      getIt.registerSingleton<MouseSettings>(settings);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.viewmodel.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.viewmodel.reconnect();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        widget.viewmodel.disableMouse();
    }
  }

  void _onToggle(int index) {
    widget.viewmodel.disableMouse();
    widget.viewmodel.closeKeyboard();

    setState(() {
      _currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
    if (index == 0) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else if (index == 1) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  Widget? get _drawer {
    if (_currentPageIndex == 0) {
      return const CursorSettingsPage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: _drawer,
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          MouseSettingsPersistenceService.saveSettings(getIt<MouseSettings>());
        } else {
          widget.viewmodel.disableMouse();
          widget.viewmodel.closeKeyboard();
        }
      },
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            widget.viewmodel.disconnect();
            context.go(Routes.connect);
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
        ),
        actions: [
          Visibility(
            visible: true,
            child: ListenableBuilder(
              listenable: widget.viewmodel.isKeyboardOpen,
              builder: (context, _) {
                return IconButton(
                  onPressed: () {
                    widget.viewmodel.disableMouse();
                    if (!widget.viewmodel.isKeyboardOpen.value) {
                      widget.viewmodel.openKeyboard();
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Keyboard is experimental'),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: KeyboardTyppingPage(
                                  viewmodel: KeyboardViewModel(
                                    keyboardRepository: context.read(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      widget.viewmodel.closeKeyboard();
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(
                    widget.viewmodel.isKeyboardOpen.value
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard,
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: _currentPageIndex == 0,
            child: IconButton(
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          children: [
            MoveMouseBody(
              currentIndex: _currentPageIndex,
              onToggle: _onToggle,
            ),
            TrackPad(
              currentIndex: _currentPageIndex,
              onToggle: _onToggle,
            ),
            _buildDragPage(size),
          ],
        ),
      ),
    );
  }

  Widget _buildDragPage(Size size) {
    return Center(
        child: Hero(
      tag: 'mouse-mode-switch-$size',
      child: IconButton(
        onPressed: () {
          context.go(Routes.remote);
        },
        icon: const Icon(Icons.settings_remote),
      ),
    ));
  }
}
