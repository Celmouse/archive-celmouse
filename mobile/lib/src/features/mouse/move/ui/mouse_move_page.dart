import 'package:controller/getit.dart';
import 'package:controller/src/features/gaming/a/page.dart';
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
    // required this.channel,
  });

  // final WebSocketChannel channel;

  @override
  State<MoveMousePage> createState() => _MoveMousePageState();
}

enum CursorKeysPressed {
  none,
  leftClick,
  rightClick,
}

class _MoveMousePageState extends State<MoveMousePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    // TODO: Find other way to load settings
    MouseSettingsPersistence.loadSettings().then((settings) {
      getIt.registerSingleton<MouseSettings>(settings);
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
          Visibility(
            visible: kDebugMode,
            child: IconButton(
              onPressed: () {
                movement.stopMouseMovement();
                movement.stopScrollMovement();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KeyboardTyppingPage(),
                    ));
              },
              icon: const Icon(
                Icons.keyboard,
              ),
            ),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.settings),
          ),
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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameModeDefaultPage(),
                ),
              ),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
