import 'package:controller/src/ui/layout_builder/view/button_properties_drawer.dart';
import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:controller/src/ui/layout_builder/viewmodel/layout_builder_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

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

  addItem(Offset offset) {
    final id = UniqueKey().toString();

    viewmodel.addItem(
      LayoutButtonProperties(
        id: id,
        x: offset.dx,
        y: offset.dy,
        size: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: viewmodel.scaffoldKey,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ListenableBuilder(
        listenable: viewmodel,
        builder: (_, __) {
          return Visibility(
            visible: viewmodel.selectedItem != null,
            child: ExpandableFab(
              key: viewmodel.menuKey,
              type: ExpandableFabType.up,
              distance: 72,
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(Icons.edit),
                fabSize: ExpandableFabSize.regular,
                shape: const CircleBorder(),
              ),
              children: [
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: viewmodel.unselectItem,
                  child: const Icon(Icons.edit_off_sharp),
                ),
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: viewmodel.deleteSelected,
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.delete),
                ),
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: viewmodel.openButtonSettings,
                  child: const Icon(Icons.menu),
                ),
              ],
            ),
          );
        },
      ),
      endDrawer: ButtomPropertiesDrawer(
        viewmodel: viewmodel,
      ),
      appBar: AppBar(
        title: const Text('Build Custom Layout'),
        actions: const [
          SizedBox.shrink(),
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: IconButton(
          //       icon: const Icon(Icons.visibility),
          //       onPressed: () {},
          //     ),
          //   ),
        ],
      ),
      extendBodyBehindAppBar: extendsBodyBehindAppBar,
      body: Listener(
        onPointerMove: viewmodel.checkTouch,
        child: Stack(
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                addItem(details.localPosition);
              },
            ),
            ListenableBuilder(
              listenable: viewmodel,
              builder: (__, _) => Stack(
                children: viewmodel.items
                    .map(
                      (item) => LayoutBuilderItem(
                        properties: item,
                        viewmodel: viewmodel,
                      ),
                    )
                    .toList(),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: ListenableBuilder(
                listenable: viewmodel.deleteButtonViewmodel,
                builder: (context, _) {
                  return Visibility(
                    visible: viewmodel.deleteButtonViewmodel.showDeletionButton,
                    child: CircleAvatar(
                      key: viewmodel.widgetKey,
                      radius: viewmodel
                              .deleteButtonViewmodel.isHoveringDeletionButton
                          ? 42
                          : 32,
                      backgroundColor: viewmodel
                              .deleteButtonViewmodel.isHoveringDeletionButton
                          ? Colors.red.shade200
                          : null,
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
