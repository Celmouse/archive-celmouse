import 'package:flutter/material.dart';

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
        onPositionChanged: (double x, double y) {
          setState(() {
            // final element = items.firstWhere((element) => element.id == id);
            // element.x = x;
          });
        },
      ));
    });
  }

  changeItemPosition(String id, double x, double y){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to Place Container'),
      ),
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
    required this.onPositionChanged,
  });

  final String id;
  final double x;
  final double y;
  final double size;
  final Function(double x, double y) onPositionChanged;

  @override
  State<LayoutBuilderItem> createState() => _LayoutBuilderItemState();
}

class _LayoutBuilderItemState extends State<LayoutBuilderItem> {
  @override
  Widget build(BuildContext context) {
    double x = widget.x - widget.size / 2;
    double y = widget.y - widget.size / 2;
    
    return Positioned(
      top: y,
      left: x,
      child: Draggable(
        onDragEnd: (details) {
          widget.onPositionChanged(details.offset.dx, details.offset.dy);
        },
        feedback: Container(
          width: widget.size,
          height: widget.size,
          color: Colors.blue.withOpacity(0.5),
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
