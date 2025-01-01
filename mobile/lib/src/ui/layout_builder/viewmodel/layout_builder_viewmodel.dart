import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/material.dart';

class LayoutBuilderViewmodel extends ChangeNotifier {
  final DeleteButtonViewmodel deleteButtonViewmodel = DeleteButtonViewmodel();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey widgetKey = GlobalKey();

  String? selectedItem;
  final List<LayoutButtonProperties> _items = [];
  List<LayoutButtonProperties> get items => _items.toList();

  LayoutButtonProperties get selectedButtom => _items.firstWhere(
        (i) => i.id == selectedItem,
      );

  void deleteSelected() {
    if (selectedItem == null) {
      return;
    }
    _items.removeWhere((i) => i.id == selectedItem);
    selectedItem = null;
    notifyListeners();
  }

  void holdItem(String id) {
    deleteButtonViewmodel.showDeletionButton = true;
    selectedItem = id;
  }

  void openButtonSettings() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void releaseItem(LayoutButtonProperties item) {
    deleteButtonViewmodel.showDeletionButton = false;
    if (deleteButtonViewmodel.isHoveringDeletionButton) {
      _items.removeWhere((i) => i.id == item.id);
    } else {
      _items[_items.indexWhere((i) => i.id == item.id)] = item;
    }
    notifyListeners();
  }



  void addItem(LayoutButtonProperties item) {
    _items.add(item);
    notifyListeners();
  }

  void selectItem(String id) {
    if(selectedItem == id){
      selectedItem = null;
    } else {
      selectedItem = id;
    }
    notifyListeners();
  }

  void unselectItem() {
    selectedItem = null;
    notifyListeners();
  }

  void updateItem(LayoutButtonProperties item) {
    _items[_items.indexWhere((i) => i.id == item.id)] = item;
    notifyListeners();
  }

  void checkTouch(PointerEvent event) {
    if (selectedItem == null) {
      return;
    }

    final RenderBox? renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      return;
    }

    final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    final Size widgetSize = renderBox.size;

    // Define the widget boundaries
    final Rect widgetRect = Rect.fromLTWH(
      widgetPosition.dx,
      widgetPosition.dy,
      widgetSize.width,
      widgetSize.height,
    );

    deleteButtonViewmodel.isHoveringDeletionButton =
        widgetRect.contains(event.position);
  }
}

class DeleteButtonViewmodel extends ChangeNotifier {
  bool _showDeletionButton = false;
  bool _isHoveringDeletionButton = false;

  bool get isHoveringDeletionButton => _isHoveringDeletionButton;

  set isHoveringDeletionButton(bool value) {
    _isHoveringDeletionButton = value;
    notifyListeners();
  }

  bool get showDeletionButton => _showDeletionButton;

  set showDeletionButton(bool value) {
    _showDeletionButton = value;
    notifyListeners();
  }

  void changeHoveringDeletion(bool value) {
    showDeletionButton = value;
  }
}
