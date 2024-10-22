import 'package:controller/getit.dart';
import 'package:controller/src/socket/mouse.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CursorSettingsPage extends StatefulWidget {
  const CursorSettingsPage({
    super.key,
    required this.channel,
    required this.configs,
  });

  final MouseConfigs configs;
  final WebSocketChannel channel;

  @override
  State<CursorSettingsPage> createState() => _CursorSettingsPageState();
}

class _CursorSettingsPageState extends State<CursorSettingsPage> {
  late final mouse = MouseControl(widget.channel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
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
                  "Inverter eixo vertical:",
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
                  "Inverter eixo horizontal:",
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
                label: getIt.get<MouseConfigs>().sensitivity.toString(),
                value: getIt.get<MouseConfigs>().sensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    getIt.get<MouseConfigs>().sensitivity = amount.round();
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
                  "Inverter eixo vertical:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseConfigs>().invertedScrollY,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().invertedScrollY = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Inverter eixo horizontal:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseConfigs>().invertedScrollX,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().invertedScrollX = value;
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
                label: getIt.get<MouseConfigs>().scrollSensitivity.toString(),
                value: getIt.get<MouseConfigs>().scrollSensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    getIt.get<MouseConfigs>().scrollSensitivity =
                        amount.round();
                  });
                  mouse.changeScrollSensitivity(amount);
                },
              ),
              Text(
                'Clique',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ListTile(
                title: Text(
                  'Velocidade do clique duplo:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                alignment: Alignment.center,
                isExpanded: true,
                value: getIt.get<MouseConfigs>().doubleClickDelayMS,
                items: DoubleClickDelayOptions.values
                    .map((o) => DropdownMenuItem(
                          alignment: Alignment.center,
                          value: o.duration,
                          child: Text(
                            o.text,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().doubleClickDelayMS =
                        value ?? DoubleClickDelayOptions.standard.duration;
                  });
                },
              ),

              ExpansionTile(
                title: Text(
                  'Opções avançadas',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Reduzir vibração:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      
                    ),
                    
                    alignment: Alignment.center,
                    isExpanded: true,
                    value: getIt.get<MouseConfigs>().threshhold,
                    items: ReduceVibrationOptions.values
                        .map((o) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: o.threshhold,
                              child: Text(
                                o.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        getIt.get<MouseConfigs>().threshhold =
                            value ?? ReduceVibrationOptions.standard.threshhold;
                      });
                    },
                  ),
                ],
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