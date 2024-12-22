import 'package:controller/src/ui/layout_builder/view/layout_button.dart';
import 'package:flutter/foundation.dart';

class LayoutBuilderViewmodel extends ChangeNotifier {
  bool isItemSelected = false;
  List<LayoutButtonProperties> items = [];
  bool isHovering = false;

  void holdItem(String id) {
    isItemSelected = true;
    notifyListeners();
  }

  void releaseItem(String id) {
    if(isHovering){
      print(id);
      items.removeWhere((element) => element.id == id);
    }
    isItemSelected = false;
    notifyListeners();
  }

  void changeHoveringDeletion(bool value) {
    isHovering = value;
    notifyListeners();
  }

  void addItem(LayoutButtonProperties item) {
    items.add(item);
    notifyListeners();
  }
}
