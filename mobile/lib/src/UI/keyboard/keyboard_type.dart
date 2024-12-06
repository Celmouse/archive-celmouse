import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../socket/keyboard.dart';

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
      if (words.length > speechedText.length) {
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

class KeyboardTyppingPage extends StatefulWidget {
  const KeyboardTyppingPage({
    super.key,
  });

  @override
  State<KeyboardTyppingPage> createState() => _KeyboardTyppingPageState();
}

Icon? replaceIcon(String char) {
  IconData? data;
  switch (char) {
    case '*':
      data = Icons.mouse;
      break;
    case '[':
      data = Icons.calculate;
      break;
    default:
      return null;
  }
  // if(data == null)
  return Icon(data);
}

class KeyboardKey {
  late final (String?, IconData?) _icon;
  final VoidCallback onTap;
  bool isUpperCase;

  KeyboardKey({
    String? char,
    IconData? icon,
    required this.onTap,
    this.isUpperCase = false,
  }) {
    _icon = (char, icon);
  }

  Widget get icon {
    if (_icon.$1 != null) {
      final char = isUpperCase ? _icon.$1?.toUpperCase() : _icon.$1;
      return Text(char!);
    } else {
      return Icon(_icon.$2);
    }
  }
}

onCharPressed(String char) {
  print(char);
}

enum SpecialKeyType {
  mouse,
}

onSpecialKeyPressed(SpecialKeyType type) {
  print(type);
}

const ROW_KEY_AMOUNT = 10;
const COLUMN_KEY_AMOUNT = 5;
const HEIGHT_MULTIPLYER = 0.78;
const WIDTH_MULTIPLYER = 0.8;

class _KeyboardTyppingPageState extends State<KeyboardTyppingPage> {
  // late final keyboard = KeyboardControl(widget.channel);
  @override
  Widget build(BuildContext context) {
    final List<List<KeyboardKey>> keys = [
      "0123456789"
          .split("")
          .map(
            (e) => KeyboardKey(char: e, onTap: () => onCharPressed(e)),
          )
          .toList(),
      "0123456789"
          .split("")
          .map(
            (e) => KeyboardKey(char: e, onTap: () => onCharPressed(e)),
          )
          .toList(),
      "qwertyuiop"
          .split("")
          .map(
            (e) => KeyboardKey(
                char: e, onTap: () => onCharPressed(e), isUpperCase: true),
          )
          .toList(),
      "asdfghjkl"
          .split("")
          .map(
            (e) => KeyboardKey(char: e, onTap: () => onCharPressed(e)),
          )
          .toList(),
      "zxcvbnm"
          .split("")
          .map(
            (e) => KeyboardKey(char: e, onTap: () => onCharPressed(e)),
          )
          .toList()
    ];
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teclado'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: keys
            .map<Row>((e) => Row(
                  children: e.map<Widget>(
                    (e) {
                      return GestureDetector(
                        onTap: e.onTap,
                        child: Container(
                          height: (MediaQuery.of(context).size.height *
                                  HEIGHT_MULTIPLYER) /
                              COLUMN_KEY_AMOUNT,
                          width: (MediaQuery.of(context).size.width *
                                  WIDTH_MULTIPLYER) /
                              ROW_KEY_AMOUNT,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: e.icon,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ))
            .toList(),
      )),
    );
  }
}
