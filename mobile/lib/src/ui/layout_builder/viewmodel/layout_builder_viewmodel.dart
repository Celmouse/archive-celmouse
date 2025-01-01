import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/foundation.dart';

class LayoutBuilderViewmodel extends ChangeNotifier {
  String? selectedItem;
  bool isHovering = false;
  final Map<String, LayoutButtonProperties> _items = {};
  Map<String, LayoutButtonProperties> get items => Map.from(_items);

  void holdItem(String id) {
    selectedItem = id;
    notifyListeners();
  }

  void releaseItem(String id) {
    if (isHovering) {
      _items.remove(id);
    }
    selectedItem = null;
    notifyListeners();
  }

  void changeHoveringDeletion(bool value) {
    isHovering = value;
    notifyListeners();
  }

  void updateItem(String id, LayoutButtonProperties item) {
    print(id == selectedItem);
    _items.update(id, (value) => item);
    notifyListeners();
  }

  void addItem(String id, LayoutButtonProperties item) {
    _items.addAll({id: item});
    notifyListeners();
  }
}
