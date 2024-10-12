import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:controller/src/cursor_settings.dart';
import 'package:controller/src/keyboard_type.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:web_socket_channel/web_socket_channel.dart';

class MoveMousePage extends StatefulWidget {
  const MoveMousePage({super.key, required this.channel,});

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
  bool isCursorMovingEnabled = false;

  CursorKeysPressed cursorKeysPressed = CursorKeysPressed.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return KeyboardTyppingPage(
                  channel: widget.channel,
                );
              },
            )),
            icon: const Icon(Icons.keyboard),
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
              flex: 1,
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
                        final data = {
                          "leftClickEvent": true,
                        };
                        widget.channel.sink.add(jsonEncode(data));
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
                        width: MediaQuery.of(context).size.width / 2 - 20,
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          cursorKeysPressed = CursorKeysPressed.rightClick;
                        });
                        final data = {
                          "rightClickEvent": true,
                        };
                        widget.channel.sink.add(jsonEncode(data));
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
                        width: MediaQuery.of(context).size.width / 2 - 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Flexible(
                flex: 1,
                child: SizedBox(
                  height: 40,
                )),
            Flexible(
              flex: 2,
              child: GestureDetector(
                onTap: onMouseMoveEnableTapped,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: isCursorMovingEnabled ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
            const Flexible(
                flex: 1,
                child: SizedBox(
                  height: 0,
                )),
          ],
        ),
      ),
    );
  }

  void onMouseMoveEnableTapped() {
    if (!isCursorMovingEnabled) {
      setState(() {
        isCursorMovingEnabled = true;
      });

      widget.channel.sink.add(jsonEncode({
        "event": "MouseMotionStart",
      }));

      acelerometerSubscription =
          gyroscopeEventStream(samplingPeriod: SensorInterval.gameInterval)
              .listen((GyroscopeEvent event) {
        sendMouseMovement(event.z * -1, event.x * -1, event.timestamp);
      });
    } else {
      setState(() {
        isCursorMovingEnabled = false;
      });
      acelerometerSubscription?.cancel();
      acelerometerSubscription = null;

      widget.channel.sink.add(jsonEncode({
        "event": "MouseMotionStop",
      }));
    }
  }

  StreamSubscription? acelerometerSubscription;

  DateTime lastMouseMovement = DateTime.now();

  sendMouseMovement(double x, double y, DateTime timestamp) {
    // X é Z e pra direita é negativo
    // X é Y e pra cima é positivo

    var seconds =
        timestamp.difference(lastMouseMovement).inMicroseconds / (pow(10, 6));
    lastMouseMovement = timestamp;

    x = (math.degrees(x * seconds));
    y = (math.degrees(y * seconds));

    const double threshholdX = 0.1;
    const double threshholdY = 0.1;

    if (x.abs() <= threshholdX) {
      x = 0;
    }

    if (y.abs() <= threshholdY) {
      y = 0;
    }

    final data = {
      "event": "MouseMotionMove",
      "axis": {
        "x": x,
        "y": y,
      }
    };

    if (isCursorMovingEnabled) {
      widget.channel.sink.add(jsonEncode(data));
    }
  }

  @override
  void dispose() {
    // Fechar o canal ao sair
    widget.channel.sink.close();
    super.dispose();
  }
}
