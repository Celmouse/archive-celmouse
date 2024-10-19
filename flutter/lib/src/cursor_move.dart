import 'package:controller/src/core/mouse_movement.dart';
import 'package:controller/src/cursor_settings.dart';
import 'package:controller/src/socket/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'socket/mouse.dart';
import 'socket/protocol.dart';

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

  var gyroscopePointer = (x: 0, y: 0);

  late final MouseControl mouse;
  late final MouseMovement movement;
  late final KeyboardControl keyboard;

  @override
  void initState() {
    mouse = MouseControl(widget.channel);
    keyboard = KeyboardControl(widget.channel);
    movement = MouseMovement(mouse: mouse);
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

  bool tmpCursorMovingEnabled = false;

  enableScrolling() {
    tmpCursorMovingEnabled = isCursorMovingEnabled;

    setState(() {
      isScrollingEnabled = true;
      isCursorMovingEnabled = false;
    });

    movement.startScrollMovement();
  }

  disableScrolling() {
    setState(() {
      isScrollingEnabled = false;
      isCursorMovingEnabled = tmpCursorMovingEnabled;
    });
    movement.stopScrollMovement();
    if(isCursorMovingEnabled) movement.startMouseMovement();
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        actions: [
          Visibility(
            visible: false,
            child: IconButton(
              onPressed: null, //isMicOn ? disableVoiceType : enableVoiceType,
              icon: Icon(
                Icons.mic,
                color: null, // isMicOn ? Colors.greenAccent : null,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CursorSettingsPage(
                  channel: widget.channel,
                );
              },
            )),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.leftClick;
                        });
                        mouse.click(ClickEventData.left);
                      },
                      onTapUp: (_) {
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
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.rightClick;
                        });
                        mouse.click(ClickEventData.right);
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
                              ? Colors.green
                              : Colors.grey,
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
                          color:
                              isScrollingEnabled ? Colors.purple : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Flexible(
              flex: 1,
              child: SizedBox(
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
