import 'package:controller/src/ui/layout_builder/view/layout_builder_page.dart';
import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/material.dart';

class LayoutButtonProperties {
  String id;
  double x;
  double y;
  double size;
  Color color;
  BoxShape shape;
  String label;
  // TODO: Add shape
  // TODO: Add custom image

  LayoutButtonProperties({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    this.label = "",
    this.color = Colors.blue,
    this.shape = BoxShape.rectangle,
  });

  @override
  String toString() {
    return "$id: ($x, $y)";
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
    final double x = properties.x - properties.size / 2;
    final double y = properties.y - properties.size / 2;
    return Positioned(
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () {
          viewmodel.selectItem(properties.id);
        },
        child: Draggable(
          // rootOverlay: true,
          onDragEnd: (details) {
            double appBarHeight = 0;
            if (Scaffold.of(context).hasAppBar && !extendsBodyBehindAppBar) {
              appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
            }

            viewmodel.releaseItem(
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
            decoration: BoxDecoration(
              color: properties.color.withValues(alpha: .4),
              shape: properties.shape,
            ),
          ),
          childWhenDragging: Container(),
          child: Container(
            width: properties.size,
            height: properties.size,
            decoration: BoxDecoration(
              color: properties.color,
              shape: properties.shape,
              border: Border.all(
                color: viewmodel.selectedItem == properties.id
                    ? Colors.black
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                properties.label,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
