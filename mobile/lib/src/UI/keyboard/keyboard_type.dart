import 'package:controller/getit.dart';
import 'package:controller/src/UI/keyboard/keyboard_repository.dart';
import 'package:controller/src/UI/keyboard/keyboard_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import '../../UI/keyboard/model.dart';
import '../../UI/keyboard/keyboard_theme.dart';
import '../../UI/keyboard/keyboard_view_model.dart';

/*
  enableVoiceType() {
    setState(() {
      isMicOn = true;
    });
    if (speechAvailable) {
      speech.listen(
          onResult: onSpeechRecognizion,
          localeId: 'pt-BR',
          listenOptions: SpeechListenOptions(
            listenMode: ListenMode.search,
          ));
    }
  }

  initSpeechToText() async {
    speechAvailable = await speech.initialize();
    // var speechLocales = await speech.locales();
    // speechLocale = speechLocales.firstWhere((l)=>l.localeId == 'pt-BR');
  }

  onSpeechRecognizion(SpeechRecognitionResult result) {
    final words = result.recognizedWords;
    String splited = "";
    if (speechedText == "") {
      if (words length > speechedText.length) {
        splited = speechedText.substring(speechedText.length);
      }
    } else {
      splited = words;
    }

    print('Words: $words | Speeched: $speechedText | Result: $splited');
    keyboard.type(splited);
    speechedText = words;
  }

  disableVoiceType() {
    setState(() {
      isMicOn = false;
    });
    speech.stop();
    speechedText = "";
  }

  */

class KeyboardTyppingPage extends StatelessWidget {
  const KeyboardTyppingPage({
    super.key,
    this.theme = defaultKeyboardTheme,
  });

  final KeyboardTheme theme;

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
            padding: const EdgeInsets.all(8.0),
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
                                  padding: EdgeInsets.all(theme.keySpacing),
                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      HapticFeedback.lightImpact();
                                      if (key.label != null) {
                                        viewModel.onCharPressed(key.label!);
                                      } else if (key.icon != null) {
                                        viewModel.onSpecialKeyPressed(
                                            SpecialKeyType.mouse);
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      height: theme.keyHeight,
                                      width: theme.keyWidth,
                                      decoration: BoxDecoration(
                                        color: key.type == KeyType.normal
                                            ? theme.keyColor
                                            : key.type == KeyType.special
                                                ? theme.specialKeyColor
                                                : theme.aderenceKeyColor,
                                        border:
                                            Border.all(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(8),
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
                                                    ? key.label!.toUpperCase()
                                                    : key.label!,
                                                style: key.type ==
                                                        KeyType.normal
                                                    ? theme.textStyle
                                                    : key.type ==
                                                            KeyType.special
                                                        ? theme.specialTextStyle
                                                        : theme
                                                            .aderenceTextStyle,
                                              )
                                            : Icon(key.icon, size: 24),
                                      ),
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
