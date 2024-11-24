import 'dart:async';

import 'package:controller/getit.dart';
import 'package:controller/src/features/mouse/socket_mouse.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:protocol/protocol.dart';

import '../../data/mouse_settings_model.dart';

class LeftMouseButton extends StatefulWidget {
  const LeftMouseButton({
    super.key,
    required this.mouse,
  });

  final MouseControl mouse;

  @override
  State<LeftMouseButton> createState() => _LeftMouseButtonState();
}

class _LeftMouseButtonState extends State<LeftMouseButton> {
  bool isPressed = false;

  late Timer leftClickTimer;
  Timer? doubleClickTimer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        leftClickTimer = Timer(
          Duration(
            milliseconds: getIt.get<MouseSettings>().dragStartDelayMS.duration,
          ),
          () {
            showDeactivatedFeatureWarning();
            // TODO: Fix press and hold
            // mouse.press(ClickType.left);
          },
        );
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        if (!leftClickTimer.isActive) {
          widget.mouse.release(ClickType.left);
        } else {
          bool shouldDoubleClick =
              doubleClickTimer != null && doubleClickTimer!.isActive;

          if (shouldDoubleClick) {
            widget.mouse.doubleClick(ClickType.left);
          } else {
            widget.mouse.click(ClickType.left);
            doubleClickTimer?.cancel();
          }
        }
        leftClickTimer.cancel();
        doubleClickTimer = Timer(
          Duration(
            milliseconds:
                getIt.get<MouseSettings>().doubleClickDelayMS.duration,
          ),
          () {},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: isPressed ? Colors.red[200] : Colors.red,
        ),
        width: size.width / 2 - 20,
        height: size.height * 0.3,
      ),
    );
  }

  void showDeactivatedFeatureWarning() => Fluttertoast.showToast(
        msg:
            "Hold and Release was deactivated in this version due to game mode prep!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow[600],
        textColor: Colors.white,
        fontSize: 16.0,
      );
}
