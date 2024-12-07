import 'package:controller/getit.dart';
import 'package:controller/src/UI/keyboard/keyboard_repository.dart';
import 'package:controller/src/UI/keyboard/keyboard_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../UI/keyboard/model.dart';
import '../../UI/keyboard/keyboard_theme.dart';
import '../../UI/keyboard/keyboard_view_model.dart';

class KeyboardTyppingPage extends StatelessWidget {
  const KeyboardTyppingPage({
    super.key,
    this.theme = defaultKeyboardTheme,
  });

  final KeyboardTheme theme;

  SpecialKeyType _getSpecialKeyType(IconData icon) {
    switch (icon) {
      case Icons.backspace:
        return SpecialKeyType.backspace;
      case Icons.keyboard_hide:
        return SpecialKeyType.hide;
      case Icons.keyboard_return:
        return SpecialKeyType.enter;
      default:
        return SpecialKeyType.space;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KeyboardViewModel(getIt<KeyboardRepository>()),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer<KeyboardViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: viewModel.keys
                  .map<Row>((row) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: row.map<Widget>((keyItem) {
                          return Expanded(
                            flex: keyItem.flex,
                            child: Padding(
                              padding: EdgeInsets.all(theme.keySpacing / 2),
                              child: KeyButton(
                                keyItem: keyItem,
                                viewModel: viewModel,
                                theme: theme,
                                onPressed: () {
                                  if (keyItem.label != null) {
                                    viewModel.onCharPressed(keyItem.label!);
                                  } else if (keyItem.icon != null) {
                                    viewModel.onSpecialKeyPressed(
                                        _getSpecialKeyType(keyItem.icon!));
                                  }
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class KeyButton extends StatefulWidget {
  final MKey keyItem;
  final KeyboardViewModel viewModel;
  final KeyboardTheme theme;
  final VoidCallback onPressed;

  const KeyButton({
    super.key,
    required this.keyItem,
    required this.viewModel,
    required this.theme,
    required this.onPressed,
  });

  @override
  KeyButtonState createState() => KeyButtonState();
}

class KeyButtonState extends State<KeyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.theme.keyHeight,
        width: widget.theme.keyWidth * widget.keyItem.flex,
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.theme.keyPressedColor
              : widget.keyItem.type == KeyType.normal
                  ? widget.theme.keyColor
                  : widget.keyItem.type == KeyType.special
                      ? widget.theme.specialKeyColor
                      : widget.theme.aderenceKeyColor,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: widget.keyItem.label != null
                  ? Text(
                      widget.viewModel.isShiftActive
                          ? widget.keyItem.label!.toUpperCase()
                          : widget.keyItem.label!,
                      style: widget.keyItem.type == KeyType.normal
                          ? widget.theme.textStyle
                          : widget.keyItem.type == KeyType.special
                              ? widget.theme.specialTextStyle
                              : widget.theme.aderenceTextStyle,
                    )
                  : Icon(widget.keyItem.icon, size: 24),
            ),
            if (widget.keyItem.label == "Shift" &&
                widget.viewModel.isShiftActive)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
