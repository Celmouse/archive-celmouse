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
  List<LayoutBuilderItem> items = [];

  addItem(Offset offset) {
    setState(() {
      final id = items.length.toString();
      items.add(LayoutBuilderItem(
        id: id,
        x: offset.dx,
        y: offset.dy,
        size: 50,
      ));
    });
  }

  changeItemPosition(String id, double x, double y) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to Place Container'),
      ),
      extendBodyBehindAppBar: extendsBodyBehindAppBar,
      body: Stack(
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              addItem(details.localPosition);
            },
          ),
          ...items
        ],
      ),
    );
  }
}

class LayoutBuilderItem extends StatefulWidget {
  const LayoutBuilderItem({
    super.key,
    required this.id,
    required this.x,
    required this.y,
    required this.size,
  });

  final String id;
  final double x;
  final double y;
  final double size;

  @override
  State<LayoutBuilderItem> createState() => _LayoutBuilderItemState();
}

class _LayoutBuilderItemState extends State<LayoutBuilderItem> {
  late double x;
  late double y;

  @override
  void initState() {
    x = widget.x - widget.size / 2;
    y = widget.y - widget.size / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y,
      left: x,
      child: Draggable(
        rootOverlay: true,
        onDragEnd: (details) {
          double appBarHeight = 0;
          if (Scaffold.of(context).hasAppBar && !extendsBodyBehindAppBar) {
            appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
          }

          setState(() {
            x = details.offset.dx;
            y = details.offset.dy - appBarHeight.toDouble();
          });
        },
        feedback: Container(
          width: widget.size,
          height: widget.size,
          color: Colors.blue.withValues(alpha: .5),
        ),
        childWhenDragging: Container(),
        child: Container(
          width: widget.size,
          height: widget.size,
          color: Colors.blue,
        ),
      ),
    );
  }
}
