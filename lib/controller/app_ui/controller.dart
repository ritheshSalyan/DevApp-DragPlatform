import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class ControllerClass with ChangeNotifier {
  CustomWidget latestWidget;

  

  void updateChild(CustomWidget latest) {
    latestWidget = latest;
    notifyListeners();
  }

  void notify() {
    // latestWidget = latest;
    notifyListeners();
  }

  Widget properties(BuildContext context){
   return latestWidget!=null?latestWidget.properties(context):Container();
  }
}
