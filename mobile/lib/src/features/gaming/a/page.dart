import 'package:controller/src/features/gaming/a/components/shot.dart';
import 'package:controller/src/features/keyboard/ui/components/keycap.dart';
import 'package:controller/src/features/mouse/move/bloc/mouse_movement.dart';
import 'package:controller/src/features/mouse/move/ui/components/left_button.dart';
import 'package:controller/src/features/mouse/move/ui/components/move_button.dart';
import 'package:controller/src/features/mouse/move/ui/components/right_button.dart';
import 'package:controller/src/features/mouse/socket_mouse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// The classic and 1st game mode page
class GameModeDefaultPage extends StatefulWidget {
  const GameModeDefaultPage({super.key});

  @override
  State<GameModeDefaultPage> createState() => _GameModeDefaultPageState();
}

class _GameModeDefaultPageState extends State<GameModeDefaultPage> {
  final MouseControl mouse = MouseControl();
  late final MouseMovement movement;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    movement = MouseMovement(mouse: mouse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Spacer(),
                ShotButtonComponent(),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            MovementControls(),
          ],
        ),
      ),
    );
  }
}

class MovementControls extends StatelessWidget {
  const MovementControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicKeyboardKeyComponent(
              text: 'W',
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicKeyboardKeyComponent(
              text: 'A',
            ),
            SizedBox(
              width: 8,
            ),
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.green,
            ),
            SizedBox(
              width: 8,
            ),
            BasicKeyboardKeyComponent(
              text: 'D',
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicKeyboardKeyComponent(
              text: 'S',
            ),
          ],
        ),
      ],
    );
  }
}
