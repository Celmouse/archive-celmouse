import 'package:controller/getit.dart';
import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/view/move_button.dart';
import 'package:controller/src/ui/mouse_move/view/right_button.dart';
import 'package:controller/src/ui/mouse_move/view/scroll_button.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_settings_page.dart';
import 'package:controller/src/ui/keyboard/keyboard_type.dart';
import 'package:controller/src/ui/mouse_move/viewmodel/mouse_move_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../features/mouse/move/data/mouse_settings_model.dart';
import '../../../features/mouse/move/data/mouse_settings_persistence.dart';
import '../../mouse/view/left_button.dart';

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
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    MouseSettingsPersistence.loadSettings().then((settings) {
      getIt.registerSingleton<MouseSettings>(settings);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CursorSettingsPage(),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          MouseSettingsPersistence.saveSettings(getIt<MouseSettings>());
        } else {
          widget.viewmodel.stopMouse();
        }
      },
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
                widget.viewmodel.stopMouse();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KeyboardTyppingPage(),
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
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
        child: Stack(
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
                    LeftMouseButton(
                      settings: ButtonSettings(
                        width: size.width / 2 - 20,
                        height: size.height * 0.3,
                        color: Colors.red,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                    RightMouseButton(
                      settings: ButtonSettings(
                        width: size.width / 2 - 20,
                        height: size.height * 0.3,
                        color: Colors.blue,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    )
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
                    child: MoveMouseButton(
                      settings: ButtonSettings(
                        color: Colors.green,
                        width: double.infinity,
                        height: size.height * 0.13,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Flexible(
                    flex: 3,
                    child: ScrollMouseButton(
                      settings: ButtonSettings(
                        color: Colors.purple,
                        width: double.infinity,
                        height: size.height * 0.13,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return _buildPositionedKeyboard(context);
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
