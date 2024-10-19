import 'package:controller/getit.dart';
import 'package:controller/src/socket/mouse.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CursorSettingsPage extends StatefulWidget {
  const CursorSettingsPage({
    super.key,
    required this.channel,
    this.sensibilidade = 5,
  });

  final int sensibilidade;
  final WebSocketChannel channel;

  @override
  State<CursorSettingsPage> createState() => _CursorSettingsPageState();
}

class _CursorSettingsPageState extends State<CursorSettingsPage> {
  late final mouse = MouseControl(widget.channel);

  late int pointerSensitivity = widget.sensibilidade;
  late int scrollSensitivity = 4;
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
                  "Inverter eixo Vertical:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseConfigs>().invertedPointerY,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().invertedPointerY = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Inverter eixo Horizontal:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseConfigs>().invertedPointerX,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().invertedPointerX = value;
                  });
                },
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
                label: pointerSensitivity.toString(),
                value: pointerSensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    pointerSensitivity = amount.round();
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
                value: getIt.get<MouseConfigs>().invertedScroll,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().invertedScroll = value;
                  });
                },
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
                label: scrollSensitivity.toString(),
                value: scrollSensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    scrollSensitivity = amount.round();
                  });
                  mouse.changeScrollSensitivity(amount);
                },
              ),

              /// Layout
              Visibility(
                visible: false,
                child: Text(
                  'Layout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
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