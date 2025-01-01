import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const bool extendsBodyBehindAppBar = false;

// TODO: Get the position of the tap and place a container there
// When I do select the container, I should be able to drag it around
// When I do select the container, a drawer will be opened on the other half of the screen with the
// container's properties
class LayoutBuilderPage extends StatefulWidget {
  const LayoutBuilderPage({super.key});

  @override
  State<LayoutBuilderPage> createState() => _LayoutBuilderPageState();
}

class _LayoutBuilderPageState extends State<LayoutBuilderPage> {
  final LayoutBuilderViewmodel viewmodel = LayoutBuilderViewmodel();

  final GlobalKey _widgetKey = GlobalKey();

  addItem(Offset offset) {
    final id = UniqueKey().toString();

    viewmodel.addItem(
      id,
      LayoutButtonProperties(
        id: id,
        x: offset.dx,
        y: offset.dy,
        size: 50,
      ),
    );
  }

  onPositionChanged(String id, double x, double y) {}

  void _checkTouch(PointerEvent event) {
    if (viewmodel.selectedItem == null) {
      return;
    }

    final RenderBox? renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    final Size widgetSize = renderBox.size;

    // Define the widget boundaries
    final Rect widgetRect = Rect.fromLTWH(
      widgetPosition.dx,
      widgetPosition.dy,
      widgetSize.width,
      widgetSize.height,
    );

    viewmodel.changeHoveringDeletion(widgetRect.contains(event.position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Custom Layout'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {},
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: extendsBodyBehindAppBar,
      body: Listener(
        onPointerMove: _checkTouch,
        child: Stack(
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                addItem(details.localPosition);
              },
            ),
            ListenableBuilder(
              listenable: viewmodel,
              builder: (context, _) {
                return Stack(
                  children: viewmodel.items.values.map(
                    (item) {
                      print(item);
                      return LayoutBuilderItem(
                        properties: item,
                        viewmodel: viewmodel,
                      );
                    },
                  ).toList(),
                );
              },
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: ListenableBuilder(
                listenable: viewmodel,
                builder: (context, _) {
                  return Visibility(
                    visible: viewmodel.selectedItem != null,
                    child: CircleAvatar(
                      key: _widgetKey,
                      radius: viewmodel.isHovering ? 42 : 32,
                      backgroundColor:
                          viewmodel.isHovering ? Colors.red.shade200 : null,
                      child: const Icon(
                        CupertinoIcons.trash,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
