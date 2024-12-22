import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/view/left_button.dart';
import 'package:controller/src/ui/mouse/view/move_button.dart';
import 'package:controller/src/ui/mouse/view/right_button.dart';
import 'package:controller/src/ui/mouse/view/scroll_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class MoveMouseBody extends StatefulWidget {
  const MoveMouseBody({
    super.key,
  });

  @override
  State<MoveMouseBody> createState() => _MoveMouseBodyState();
}

class _MoveMouseBodyState extends State<MoveMouseBody> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (
      context,
      orientation,
    ) {
      if (orientation == Orientation.landscape) {
        return const Center(child: CupertinoActivityIndicator());
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
      );
    });
  }
}
