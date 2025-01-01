import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/foundation.dart';

class LayoutBuilderViewmodel extends ChangeNotifier {
  final DeleteButtonViewmodel deleteButtonViewmodel = DeleteButtonViewmodel();

  String? selectedItem;
  final List<LayoutButtonProperties> _items = [];
  List<LayoutButtonProperties> get items => _items.toList();

  void holdItem(String id) {
    print("Selected item: $id");
    deleteButtonViewmodel.showDeletionButton = true;
    selectedItem = id;
  }

  void releaseItem(LayoutButtonProperties item) {
    deleteButtonViewmodel.showDeletionButton = false;
    if (deleteButtonViewmodel.isHoveringDeletionButton) {
      print("Deleting item: ${item.id}");
      _items.removeWhere((i) => i.id == item.id);
    } else {
      _items[_items.indexWhere((i) => i.id == item.id)] = item;
    }
    selectedItem = null;
    notifyListeners();
  }

  void addItem(LayoutButtonProperties item) {
    _items.add(item);
    notifyListeners();
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
