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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teclado'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
                4.0), // Reduced padding for less space between keys
            child: Consumer<KeyboardViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: viewModel.keys
                      .map<Row>((row) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: row.map<Widget>((key) {
                              return Expanded(
                                flex: key.flex,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      theme.keySpacing / 2), // Reduced spacing
                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      HapticFeedback.lightImpact();
                                      if (key.label != null) {
                                        viewModel.onCharPressed(key.label!);
                                      } else if (key.icon != null) {
                                        viewModel.onSpecialKeyPressed(
                                            _getSpecialKeyType(key.icon!));
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          height: theme.keyHeight,
                                          width: theme.keyWidth * key.flex,
                                          decoration: BoxDecoration(
                                            color: key.type == KeyType.normal
                                                ? theme.keyColor
                                                : key.type == KeyType.special
                                                    ? theme.specialKeyColor
                                                    : theme.aderenceKeyColor,
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(2, 2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: key.label != null
                                                ? Text(
                                                    viewModel.isShiftActive
                                                        ? key.label!
                                                            .toUpperCase()
                                                        : key.label!,
                                                    style: key.type ==
                                                            KeyType.normal
                                                        ? theme.textStyle
                                                        : key.type ==
                                                                KeyType.special
                                                            ? theme
                                                                .specialTextStyle
                                                            : theme
                                                                .aderenceTextStyle,
                                                  )
                                                : Icon(key.icon, size: 24),
                                          ),
                                        ),
                                        if (key.label == "Shift" &&
                                            viewModel.isShiftActive)
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
                                ),
                              );
                            }).toList(),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
