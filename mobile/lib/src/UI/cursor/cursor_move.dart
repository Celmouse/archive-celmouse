import 'dart:async';
import 'package:controller/getit.dart';
import 'package:controller/src/core/mouse_movement.dart';
import 'package:controller/src/UI/cursor/cursor_settings.dart';
import 'package:controller/src/UI/keyboard/keyboard_type.dart';
import 'package:controller/src/socket/keyboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../socket/mouse.dart';
import 'package:protocol/protocol.dart';

class MoveMousePage extends StatefulWidget {
  const MoveMousePage({
    super.key,
    required this.channel,
  });

  final WebSocketChannel channel;

  @override
  State<MoveMousePage> createState() => _MoveMousePageState();
}

enum CursorKeysPressed {
  none,
  leftClick,
  rightClick,
}

class _MoveMousePageState extends State<MoveMousePage> {
  // bool isMicOn = false;
  bool isScrollingEnabled = false;
  bool isCursorMovingEnabled = false;

  CursorKeysPressed cursorKeysPressed = CursorKeysPressed.none;

  late final MouseControl mouse;
  late final MouseMovement movement;
  late final KeyboardControl keyboard;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (!getIt.isRegistered<MouseConfigs>()) {
      getIt.registerSingleton<MouseConfigs>(MouseConfigs());
    }

    mouse = MouseControl(widget.channel);
    keyboard = KeyboardControl(widget.channel);
    movement = MouseMovement(mouse: mouse);

    widget.channel.stream.listen((_) {}, onDone: () {
      if (mounted) {
        Navigator.pop(context);
      }
    }, onError: (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connection Error: $e"),
          ),
        );
      }
    });
    super.initState();
  }

  /// Enable the mouse movement and center the cursor
  void enableMouseMovement() {
    setState(() {
      isCursorMovingEnabled = true;
    });

    // mouse.center();
    movement.startMouseMovement();
  }

  void disableMouseMovement() {
    setState(() {
      isCursorMovingEnabled = false;
    });

    movement.stopMouseMovement();
  }

  enableScrolling() {
    tmpCursorMovingEnabled = isCursorMovingEnabled;

    setState(() {
      isScrollingEnabled = true;
      isCursorMovingEnabled = false;
    });

    movement.stopMouseMovement();
    movement.startScrollMovement();
  }

  bool tmpCursorMovingEnabled = false;

  disableScrolling() {
    setState(() {
      isScrollingEnabled = false;
      isCursorMovingEnabled = tmpCursorMovingEnabled &&
          getIt.get<MouseConfigs>().keepMovingAfterScroll;
    });
    if (isCursorMovingEnabled) {
      movement.startMouseMovement();
    }
    movement.stopScrollMovement();
  }

  Timer? doubleClickDelay;

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  int leftClickPressTimestamp = DateTime.now().millisecondsSinceEpoch;
  int leftClickReleaseTimestamp = DateTime.now().millisecondsSinceEpoch;

  int pressedTimeDiff = 1000;
  int releasedTimeDiff = 1000;

  late Timer leftClickTimer;
  Timer? doubleClickTimer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        actions: [
          const Visibility(
            visible: kDebugMode,
            child: IconButton(
              onPressed: null, //isMicOn ? disableVoiceType : enableVoiceType,
              icon: Icon(
                Icons.mic,
                color: null, // isMicOn ? Colors.greenAccent : null,
              ),
            ),
          ),
          Visibility(
            visible: kDebugMode,
            child: IconButton(
              onPressed: () {
                movement.stopMouseMovement();
                movement.stopScrollMovement();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KeyboardTyppingPage(
                        channel: widget.channel,
                      ),
                    ));
              },
              icon: const Icon(
                Icons.keyboard,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              movement.stopMouseMovement();
              movement.stopScrollMovement();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CursorSettingsPage(
                      channel: widget.channel,
                      configs: getIt.get<MouseConfigs>(),
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
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
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                // height: double.infinity,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTapDown: (_) {
                        leftClickTimer = Timer(
                          Duration(
                            milliseconds:
                                getIt.get<MouseConfigs>().dragStartDelayMS,
                          ),
                          () {
                            showDeactivatedFeatureWarning();
                            //TODO: Fix press
                            // mouse.press(ClickType.left);
                          },
                        );
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.leftClick;
                        });
                      },
                      onTapUp: (_) {
                        if (!leftClickTimer.isActive) {
                          mouse.release(ClickType.left);
                        } else {
                          bool shouldDoubleClick = doubleClickTimer != null &&
                              doubleClickTimer!.isActive;

                          if (shouldDoubleClick) {
                            mouse.doubleClick(ClickType.left);
                          } else {
                            mouse.click(ClickType.left);
                            doubleClickTimer?.cancel();
                          }
                        }
                        leftClickTimer.cancel();
                        doubleClickTimer = Timer(
                          Duration(
                            milliseconds:
                                getIt.get<MouseConfigs>().doubleClickDelayMS,
                          ),
                          () {},
                        );

                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.none;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color:
                              cursorKeysPressed == CursorKeysPressed.leftClick
                                  ? Colors.red[200]
                                  : Colors.red,
                        ),
                        width: size.width / 2 - 20,
                        height: size.height * 0.3,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.circle, color: Colors.red),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.rightClick;
                        });
                        mouse.click(ClickType.right);
                      },
                      onTapUp: (_) {
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.none;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color:
                              cursorKeysPressed == CursorKeysPressed.rightClick
                                  ? Colors.blue[200]
                                  : Colors.blue,
                        ),
                        height: size.height * 0.3,
                        width: size.width / 2 - 20,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.circle, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),

            /// Mouse movement
            Flexible(
              flex: 2,
              child: Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: GestureDetector(
                      onTap: isCursorMovingEnabled
                          ? disableMouseMovement
                          : enableMouseMovement,
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: isCursorMovingEnabled
                              ? Colors.green[200]
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 3,
                    child: GestureDetector(
                      onTapDown: (_) => enableScrolling(),
                      onTapUp: (_) => disableScrolling(),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: isScrollingEnabled
                              ? Colors.purple[200]
                              : Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Flexible(
            //   flex: 1,
            //   child: SizedBox(
            //     height: 0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showDeactivatedFeatureWarning() {
    Fluttertoast.showToast(
        msg: "Hold and Release was deactivated in this version due to game mode prep!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     showCloseIcon: true,
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.yellow[600],
    //     content: const Text(
    //       "Hold and Release was deactivated in this version due to game mode prep!",
    //     ),
    //   ),
    // );
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
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
