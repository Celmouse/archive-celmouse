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
      body: Column(
        children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
