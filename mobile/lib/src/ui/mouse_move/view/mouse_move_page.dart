import 'package:controller/getit.dart';
import 'package:controller/main.dart';
import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/keyboard/viewmodel/keyboard_view_model.dart';
import 'package:controller/src/ui/mouse/view/move_button.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_settings_page.dart';
import 'package:controller/src/ui/keyboard/keyboard_type.dart';
import 'package:controller/src/ui/mouse/view/right_button.dart';
import 'package:controller/src/ui/mouse/view/scroll_button.dart';
import 'package:controller/src/ui/mouse_move/viewmodel/mouse_move_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../domain/models/mouse_settings_model.dart';
import '../../../data/services/mouse_settings_persistence_service.dart';
import '../../mouse/view/left_button.dart';
import 'components/mouse_mode_switch.dart';

class MoveMousePage extends StatefulWidget {
  const MoveMousePage({
    super.key,
    required this.viewmodel,
  });

  final MouseMoveViewmodel viewmodel;

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
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    MouseSettingsPersistenceService.loadSettings().then((settings) {
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
          MouseSettingsPersistenceService.saveSettings(getIt<MouseSettings>());
        } else {
          widget.viewmodel.stopMouse();
        }
      },
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
            child: ListenableBuilder(
                listenable: widget.viewmodel,
                builder: (context, _) {
                  return IconButton(
                    onPressed: () {
                      widget.viewmodel.stopMouse();
                      if (widget.viewmodel.keyboardOpenClose()) {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: size.height * 0.4,
                              child: KeyboardTyppingPage(
                                viewmodel: KeyboardViewModel(
                                  keyboardRepository: context.read(),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      widget.viewmodel.isKeyboardOpen
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard,
                    ),
                  );
                }),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Visibility(
              visible: kDebugMode,
              child: MouseModeSwitch(),
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
                    width: 12,
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
