import 'dart:io';

import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  late final TextEditingController labelController;
  final PageController pageController = PageController();

  int action = -1;

  Widget get actionPage {
    if (action == 0) {
      return MouseButtonOptions(
        onBack: () {
          pageController.previousPage(
            duration: const Duration(microseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      );
    }
    return Container();
  }

  @override
  void initState() {
    buttomSize = widget.viewmodel.selectedButtom.size;
    labelController = TextEditingController(
      text: widget.viewmodel.selectedButtom.label,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
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
                                    widget.viewmodel.selectedButtom
                                      ..color = color,
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
                                    color:
                                        widget.viewmodel.selectedButtom.color ==
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
                                    color:
                                        widget.viewmodel.selectedButtom.shape ==
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'Label:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 3,
                            child: TextField(
                              controller: labelController,
                              onChanged: (value) {
                                widget.viewmodel.updateItem(
                                  widget.viewmodel.selectedButtom
                                    ..label = value,
                                );
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                labelController.clear();
                                widget.viewmodel.updateItem(
                                  widget.viewmodel.selectedButtom..label = "",
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Image:',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            GestureDetector(
                              child:
                                  widget.viewmodel.selectedButtom.customImage !=
                                          null
                                      ? Image.file(
                                          widget.viewmodel.selectedButtom
                                              .customImage!,
                                          width: 50,
                                          height: 50,
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey,
                                          child: const Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        ),
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();

                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (image == null) {
                                  return;
                                }
                                setState(() {
                                  widget.viewmodel.updateItem(
                                    widget.viewmodel.selectedButtom
                                      ..customImage = File(image.path),
                                  );
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.viewmodel.updateItem(
                                    widget.viewmodel.selectedButtom
                                      ..customImage = null,
                                  );
                                });
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.auto_fix_high_sharp),
                        label: const Text("Add Action"),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.viewmodel.deleteSelected();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomizeButtonAction(
              onBack: () {
                pageController.previousPage(
                  duration: const Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              onCancel: () {
                Navigator.of(context).pop();
              },
              onTap: (value) {
                setState(() {
                  action = value;
                });
                pageController.nextPage(
                  duration: const Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            actionPage,
          ],
        ),
      ),
    );
  }
}

class _Btn {
  final String text;
  final IconData icon;

  _Btn(
    this.text,
    this.icon,
  );
}

class CustomizeButtonAction extends StatelessWidget {
  const CustomizeButtonAction({
    super.key,
    required this.onTap,
    required this.onBack,
    required this.onCancel,
  });

  final void Function(int) onTap;
  final VoidCallback onBack;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                'Select one',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: onCancel,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          Wrap(
            children: [
              _Btn("Mouse Button", Icons.mouse),
              _Btn("Mouse Gesture", Icons.sensors_rounded),
              _Btn("Keyboard Keys", Icons.keyboard),
              _Btn("Modifier Keys", Icons.keyboard_command_key_rounded),
              _Btn("Shortcuts", Icons.shortcut_rounded),
              _Btn("Touch", Icons.touch_app),
              _Btn("Voice", Icons.mic),
            ].indexed.map<Widget>((e) {
              final index = e.$1;
              final btn = e.$2;

              return GestureDetector(
                onTap: () => onTap(index),
                child: Card(
                  child: SizedBox(
                    width: 120,
                    height: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(btn.icon),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(btn.text),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class MouseButtonOptions extends StatelessWidget {
  const MouseButtonOptions({
    super.key,
    required this.onBack,
    required this.onCancel,
  });

  final VoidCallback onBack;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                'Mouse buttons',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: onCancel,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          Wrap(
            children: [
              _Btn("Left", Icons.mouse),
              _Btn("Right", Icons.mouse),
              _Btn("Middle", Icons.mouse),
              _Btn("Scroll Up", Icons.mouse),
              _Btn("Scroll Down", Icons.mouse),
              _Btn("Scroll Left", Icons.mouse),
              _Btn("Scroll Right", Icons.mouse),
            ].indexed.map<Widget>((e) {
              final index = e.$1;
              final btn = e.$2;

              return GestureDetector(
                // onTap: () => onTap(index),
                child: Card(
                  child: SizedBox(
                    width: 120,
                    height: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(btn.icon),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(btn.text),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
