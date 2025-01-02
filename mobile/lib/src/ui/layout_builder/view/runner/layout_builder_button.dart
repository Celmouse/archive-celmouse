import 'package:controller/src/ui/layout_builder/model/model.dart';
import 'package:flutter/material.dart';

class LayoutBuilderRunnerButton extends StatelessWidget {
  const LayoutBuilderRunnerButton({
    super.key,
    required this.properties,
  });

  final LayoutButtonProperties properties;

  @override
  Widget build(BuildContext context) {
    final double x = properties.x - properties.size / 2;
    final double y = properties.y - properties.size / 2;
    return Positioned(
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () {
          print('Tapped');
        },
        child: Container(
          width: properties.size,
          height: properties.size,
          decoration: BoxDecoration(
            color: properties.color,
            shape: properties.shape,
            image: properties.customImage != null
                ? DecorationImage(
                    image: FileImage(properties.customImage!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              properties.label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
