import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/material.dart';

class ButtomPropertiesDrawer extends StatefulWidget {
  const ButtomPropertiesDrawer({
    super.key,
    required this.viewmodel,
  });

  final LayoutBuilderViewmodel viewmodel;

  @override
  State<ButtomPropertiesDrawer> createState() => _ButtomPropertiesDrawerState();
}

class _ButtomPropertiesDrawerState extends State<ButtomPropertiesDrawer> {
  double buttomSize = 0;

  @override
  void initState() {
    buttomSize = widget.viewmodel.selectedButtom.size;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'Properties',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Size:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    label: (buttomSize / 10).toStringAsFixed(0),
                    value: buttomSize,
                    min: 10,
                    max: 100,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() {
                        buttomSize = value;
                      });
                      widget.viewmodel.updateItem(
                          widget.viewmodel.selectedButtom..size = value);
                    },
                  ),
                  Text(
                    'Color:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    children: [
                      for (final color in [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.yellow,
                        Colors.purple,
                        Colors.orange,
                        Colors.pink,
                        Colors.teal,
                        Colors.cyan,
                        Colors.indigo,
                        Colors.lime,
                        Colors.amber,
                        Colors.brown,
                        Colors.grey,
                      ])
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.viewmodel.updateItem(
                                widget.viewmodel.selectedButtom..color = color,
                              );
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: color,
                              border: Border.all(
                                strokeAlign: 1,
                                width: 3,
                                color: widget.viewmodel.selectedButtom.color ==
                                        color
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Shape:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    children: [
                      for (final shape in [
                        BoxShape.circle,
                        BoxShape.rectangle,
                      ])
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.viewmodel.updateItem(
                                widget.viewmodel.selectedButtom
                                  ..shape = shape,
                              );
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: widget.viewmodel.selectedButtom.color,
                              border: Border.all(
                                strokeAlign: 1,
                                width: 3,
                                color: widget.viewmodel.selectedButtom.shape ==
                                        shape
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                              shape: shape,
                            ),
                          ),
                        ),
                    ],
                  ),
                   Text(
                    'Label:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextField(
                    controller: TextEditingController(
                      text: widget.viewmodel.selectedButtom.label,
                    ),
                    onChanged: (value) {
                      widget.viewmodel.updateItem(
                        widget.viewmodel.selectedButtom..label = value,
                      );
                    },
                    decoration: const InputDecoration(
                      hintText: 'Label',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
