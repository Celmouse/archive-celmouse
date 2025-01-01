import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/foundation.dart';

class LayoutBuilderViewmodel extends ChangeNotifier {
  final DeleteButtonViewmodel deleteButtonViewmodel = DeleteButtonViewmodel();

  String? selectedItem;
  final Map<String, LayoutButtonProperties> _items = {};
  Map<String, LayoutButtonProperties> get items => Map.from(_items);

  void holdItem(String id) {
    print("Selected item: $id");
    deleteButtonViewmodel.showDeletionButton = true;
    selectedItem = id;
  }

  void releaseItem(String id, LayoutButtonProperties item) {
    deleteButtonViewmodel.showDeletionButton = false;
    if (deleteButtonViewmodel.isHoveringDeletionButton) {
      print("Deleting item: $id");
      _items.remove(id);
    } else {
      _items.update(id, (value) => item);
    }
    selectedItem = null;
    notifyListeners();
  }

  void addItem(String id, LayoutButtonProperties item) {
    _items.addAll({id: item});
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
