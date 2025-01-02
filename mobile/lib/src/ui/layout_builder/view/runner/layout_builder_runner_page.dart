import 'package:controller/src/ui/layout_builder/model/model.dart';
import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/material.dart';

import 'layout_builder_button.dart';

const bool extendsBodyBehindAppBar = false;

class LayoutBuilderRunnerPage extends StatelessWidget {
  const LayoutBuilderRunnerPage({
    super.key,
    this.items = const [],
  });

  final List<LayoutButtonProperties> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Runner'),
      ),
      extendBodyBehindAppBar: extendsBodyBehindAppBar,
      body: Stack(
        children: items
            .map(
              (item) => LayoutBuilderRunnerButton(
                properties: item,
              ),
            )
            .toList(),
      ),
    );
  }
}
