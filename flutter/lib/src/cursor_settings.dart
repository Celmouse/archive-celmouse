import 'package:controller/src/socket/mouse.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CursorSettingsPage extends StatefulWidget {
  const CursorSettingsPage({
    super.key,
    required this.channel,
    this.sensibilidade = 5,
  });

  final double sensibilidade;
  final WebSocketChannel channel;

  @override
  State<CursorSettingsPage> createState() => _CursorSettingsPageState();
}

class _CursorSettingsPageState extends State<CursorSettingsPage> {
  late final mouse = MouseControl(widget.channel);

  late double sensibilidade = widget.sensibilidade;
  bool invertedScroll = false;
  bool invertedPointer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              Text(
                'Ponteiro',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Inverter:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              ListTile(
                title: Text(
                  'Sensibilidade:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Slider(
                label: sensibilidade.round().toString(),
                value: sensibilidade,
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    sensibilidade = amount;
                  });
                  mouse.changeSensitivity(amount);
                },
              ),
              /// Scroll configurations
              Text(
                'Rolagem',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Inverter:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              ListTile(
                title: Text(
                  'Sensibilidade:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Slider(
                label: sensibilidade.round().toString(),
                value: sensibilidade,
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    sensibilidade = amount;
                  });
                  mouse.changeSensitivity(amount);
                },
              ),
            ],
          )),
    );
  }
}
/*

              RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  label: sensibilidade.toStringAsFixed(2),
                  value: sensibilidade,
                  min: 0.01,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      sensibilidade = v;
                    });

                    var data = {"changeSensitivityEvent": v};
                    widget.channel.sink.add(jsonEncode(data));
                  },
                ),
              ),
*/