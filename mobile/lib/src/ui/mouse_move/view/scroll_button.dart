import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/scroll_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollMouseButton extends StatelessWidget {
  const ScrollMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  Widget build(BuildContext context) {
    final ScrollMouseButtonViewmodel viewmodel = ScrollMouseButtonViewmodel(
      mouseReposiry: context.read(),
    );

    return ListenableBuilder(
      listenable: viewmodel,
      builder: (_, __) {
        return GestureDetector(
          onTapDown: (_) => viewmodel.toggle(),
          onTapUp: (_) => viewmodel.toggle(),
          child: Container(
            width: settings.width,
            height: settings.height,
            decoration: BoxDecoration(
              borderRadius: settings.borderRadius,
              color: viewmodel.isActive ? settings.color[200] : settings.color,
            ),
          ),
        );
      },
    );
  }
}
