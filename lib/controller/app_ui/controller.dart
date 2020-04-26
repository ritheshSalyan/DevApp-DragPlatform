import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ControllerClass with ChangeNotifier {
  CustomWidget latestWidget;

  Size size;
  ControllerClass();

  void updateChild(CustomWidget latest) {
    latestWidget = latest;
    print("Add updateChild ${latestWidget.name} ");

    notifyListeners();
  }

  void notify() {
    // latestWidget = latest;
    notifyListeners();
  }

  Widget properties(BuildContext context){
    print("Properitis called ${latestWidget?.name}");
   return latestWidget!=null?latestWidget.properties(context):Container();
  }
}
