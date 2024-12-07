import 'package:controller/getit.dart';
import 'package:controller/src/features/mouse/move/bloc/mouse_movement.dart';
import 'package:controller/src/features/mouse/move/ui/components/move_button.dart';
import 'package:controller/src/features/mouse/move/ui/components/right_button.dart';
import 'package:controller/src/features/mouse/move/ui/components/scroll_button.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_settings_page.dart';
import 'package:controller/src/UI/keyboard/keyboard_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../data/mouse_settings_model.dart';
import '../../socket_mouse.dart';
import '../data/mouse_settings_persistence.dart';
import 'components/left_button.dart';

class MoveMousePage extends StatefulWidget {
  const MoveMousePage({
    super.key,
  });

  @override
  State<MoveMousePage> createState() => _MoveMousePageState();
}

enum CursorKeysPressed {
  none,
  leftClick,
  rightClick,
}

class _MoveMousePageState extends State<MoveMousePage>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isScrollingEnabled = false;
  bool isCursorMovingEnabled = false;
  bool isKeyboardVisible = false;

  CursorKeysPressed cursorKeysPressed = CursorKeysPressed.none;

  late final MouseControl mouse;
  late final MouseMovement movement;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    MouseSettingsPersistence.loadSettings().then((settings) {
      getIt.registerSingleton<MouseSettings>(settings);
    });

    mouse = MouseControl();
    movement = MouseMovement(mouse: mouse);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleKeyboardVisibility() {
    setState(() {
      isKeyboardVisible = !isKeyboardVisible;
      if (isKeyboardVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void hideKeyboard() {
    setState(() {
      isKeyboardVisible = false;
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CursorSettingsPage(),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          MouseSettingsPersistence.saveSettings(getIt<MouseSettings>());
        } else {
          movement.stopMouseMovement();
          movement.stopScrollMovement();
        }
      },
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: toggleKeyboardVisibility,
            icon: const Icon(Icons.keyboard),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
        child: Stack(
          children: [
            GestureDetector(
              onTap: hideKeyboard,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: kDebugMode,
                    child: Hero(
                      tag: 'mouse-mode-switch',
                      child: ToggleSwitch(
                        initialLabelIndex: 0,
                        totalSwitches: 3,
                        inactiveBgColor: Colors.deepPurpleAccent,
                        activeBgColor: const [Colors.teal],
                        states: const [true, false, false],
                        minWidth: MediaQuery.of(context).size.width,
                        icons: const [
                          Icons.phonelink_ring_outlined,
                          Icons.touch_app,
                          Icons.mouse,
                        ],
                        labels: const [
                          'Move',
                          'Touch',
                          'Drag',
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CursorFeatLabel("L Click", Colors.red),
                          CursorFeatLabel("Toggle Move", Colors.green),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CursorFeatLabel("R Click", Colors.blue),
                          CursorFeatLabel("Hold Scroll", Colors.purple),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.rocket),
                    label: const Text('Game Mode'),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LeftMouseButton(mouse: mouse),
                          RightMouseButton(mouse: mouse)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 8,
                          child: MoveMouseButton(movement: movement),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          flex: 3,
                          child: ScrollMouseButton(movement: movement),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  bottom: _animationController.value *
                          MediaQuery.of(context).size.height *
                          0.4 -
                      MediaQuery.of(context).size.height * 0.4,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: AnimatedOpacity(
                    opacity: _animationController.value,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity! > 0) {
                          hideKeyboard();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.8, end: 1.0),
                              duration: const Duration(milliseconds: 200),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Container(
                                    height: 4,
                                    width: 40,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Expanded(
                              child: KeyboardTyppingPage(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CursorFeatLabel extends StatelessWidget {
  const CursorFeatLabel(
    this.text,
    this.color, {
    super.key,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
