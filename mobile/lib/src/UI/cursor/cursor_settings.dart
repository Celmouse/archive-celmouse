import 'package:controller/getit.dart';
import 'package:controller/src/socket/mouse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'help_walkthrough.dart';

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
        title: const Text('Configuration'),
        actions: [
          Visibility(
            visible: kDebugMode,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MouseScreenHelpWalkthrough(),
                  ),
                );
              },
              icon: const Icon(Icons.help),
            ),
          ),
        ],
      ),
      body: SafeArea(
          minimum: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 10,
          ),
          child: ListView(
            children: [
              Text(
                'Pointer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Invert vertical axis:",
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
                  "Invert horizontal axis:",
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
                  'Sensitivity:',
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
              SwitchListTile(
                title: Text(
                  "Keep moving after scroll:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseConfigs>().keepMovingAfterScroll,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseConfigs>().keepMovingAfterScroll = value;
                  });
                },
              ),

              /// Scroll configurations
              Text(
                'Scroll',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Invert vertical axis:",
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
                  "Invert horizontal axis:",
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
                  'Sensitivity:',
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
                'Click',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ListTile(
                title: Text(
                  'Double click speed:',
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
                  'Advanced options',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Reduce vibration:',
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
                  ListTile(
                    title: Text(
                      'Press and Hold delay:',
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
                    value: getIt.get<MouseConfigs>().dragStartDelayMS,
                    items: DragStartDelayOptions.values
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
                        getIt.get<MouseConfigs>().dragStartDelayMS =
                            value ?? DragStartDelayOptions.standard.duration;
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
              const SizedBox(
                height: 42,
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