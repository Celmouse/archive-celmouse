import 'package:controller/src/ui/layout_builder/view/layout_builder_page.dart';
import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/material.dart';

class LayoutButtonProperties {
  final String id;
  final double x;
  final double y;
  final double size;

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

class LayoutBuilderItem extends StatefulWidget {
  const LayoutBuilderItem({
    super.key,
    required this.properties,
    required this.viewmodel,
  });

  final LayoutButtonProperties properties;
  final LayoutBuilderViewmodel viewmodel;

  @override
  State<LayoutBuilderItem> createState() => _LayoutBuilderItemState();
}

class _LayoutBuilderItemState extends State<LayoutBuilderItem> {
  late double x;
  late double y;

  @override
  void initState() {
    x = widget.properties.x - widget.properties.size / 2;
    y = widget.properties.y - widget.properties.size / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () {
          print("Item selected!");
        },
        child: Draggable(
          // rootOverlay: true,
          onDragEnd: (details) {
            double appBarHeight = 0;
            if (Scaffold.of(context).hasAppBar && !extendsBodyBehindAppBar) {
              appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
            }

            setState(() {
              x = details.offset.dx;
              y = details.offset.dy - appBarHeight.toDouble();
            });

            widget.viewmodel.releaseItem(widget.properties.id);
          },
          onDragStarted: () {
            widget.viewmodel.holdItem(widget.properties.id);
          },
          feedback: Container(
            width: widget.properties.size,
            height: widget.properties.size,
            color: Colors.blue.withValues(alpha: .5),
          ),
          childWhenDragging: Container(),
          child: Container(
            width: widget.properties.size,
            height: widget.properties.size,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
