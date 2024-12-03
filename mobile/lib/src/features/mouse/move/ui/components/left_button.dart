// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:controller/src/features/mouse/move/bloc/mouse_actions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:protocol/protocol.dart';

import 'package:controller/getit.dart';
import 'package:controller/src/features/mouse/socket_mouse.dart';

import '../../data/mouse_settings_model.dart';

class LeftMouseButton extends StatefulWidget {
  const LeftMouseButton({
    super.key,
    required this.mouse,
    this.width,
    this.height,
  });

  final MouseControl mouse;
  final double? width;
  final double? height;

  @override
  State<LeftMouseButton> createState() => _LeftMouseButtonState();
}

class _LeftMouseButtonState extends State<LeftMouseButton>
    with MouseButton, ButtonClick, ButtonDoubleClick {
  late Timer leftClickTimer;
  Timer? doubleClickTimer;

  @override
  void initState() {
    mouse = widget.mouse;
    super.initState();
  }

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
            doubleClick(ClickType.left);
          } else {
            click(ClickType.left);
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
        width: widget.width ?? size.width / 2 - 20,
        height: widget.height ?? size.height * 0.3,
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
