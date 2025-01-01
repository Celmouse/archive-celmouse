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
                                widget.viewmodel.selectedButtom..shape = shape,
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
                              widget.viewmodel.selectedButtom..label = value,
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
                          child: widget.viewmodel.selectedButtom.customImage !=
                                  null
                              ? Image.file(
                                  widget.viewmodel.selectedButtom.customImage!,
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
                  )
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
      ),
    );
  }
}
