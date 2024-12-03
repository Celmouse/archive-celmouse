import 'package:flutter/material.dart';
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

class _KeyboardTyppingPageState extends State<KeyboardTyppingPage> {
  late final keyboard = KeyboardControl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teclado'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Center(
          child: TextField(
            onSubmitted: (text) {
              keyboard.type(text);
            },
            decoration: const InputDecoration(labelText: 'Usar teclado'),
          ),
        ),
      ),
    );
  }
}
