import 'package:controller/src/ui/layout_builder/view/layout_builder_page.dart';
import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/material.dart';

class LayoutButtonProperties {
  String id;
  double x;
  double y;
  double size;

  LayoutButtonProperties({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
  });

  @override
  String toString() {
    return "id: $id, x: $x, y: $y";
  }
}

class LayoutBuilderItem extends StatelessWidget {
  const LayoutBuilderItem({
    super.key,
    required this.properties,
    required this.viewmodel,
  });

  final LayoutButtonProperties properties;
  final LayoutBuilderViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    print("Button id: ${properties.id}");
    final double x = properties.x - properties.size / 2;
    final double y = properties.y - properties.size / 2;

    return Positioned(
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () {
          //TODO: Implement select item and show options.
        },
        child: Draggable(
          // rootOverlay: true,
          onDragEnd: (details) {
            double appBarHeight = 0;
            if (Scaffold.of(context).hasAppBar && !extendsBodyBehindAppBar) {
              appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
            }

            viewmodel.releaseItem(
              properties.id,
              properties
                ..x = details.offset.dx + properties.size / 2
                ..y = details.offset.dy -
                    appBarHeight.toDouble() +
                    properties.size / 2,
            );
          },
          onDragStarted: () {
            viewmodel.holdItem(properties.id);
          },
          feedback: Container(
            width: properties.size,
            height: properties.size,
            color: Colors.blue.withValues(alpha: .5),
          ),
          childWhenDragging: Container(),
          child: Container(
            width: properties.size,
            height: properties.size,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
