import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/move_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveMouseButton extends StatelessWidget {
  const MoveMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  Widget build(BuildContext context) {
    final MoveMouseButtonViewmodel viewmodel = MoveMouseButtonViewmodel(
      mouseReposiry: context.read(),
    );

    return ListenableBuilder(
      listenable: viewmodel,
      builder: (_, __) => GestureDetector(
        onTap: viewmodel.toggle,
        child: Container(
          width: settings.width,
          height: settings.height,
          decoration: BoxDecoration(
            borderRadius: settings.borderRadius,
            color: viewmodel.isActive ? settings.color[200] : settings.color,
          ),
        ),
      ),
    );
  }
}
