import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ControllerClass with ChangeNotifier {
  CustomWidget latestWidget;
  int activePage = 0;
  List<CustomPage> pages = [];

  Size size;
  ControllerClass() {
    pages.add(CustomPage("Page ${pages.length + 1} "));
  }
  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }

  void addPage() {
    pages.add(CustomPage("Page ${pages.length + 1} "));
    activePage = pages.length - 1;
    notifyListeners();
  }

  void updateChild(CustomWidget latest) {
    latestWidget = latest;
    print("Add updateChild ${latestWidget.name} ");

    notifyListeners();
  }

  void notify() {
    // latestWidget = latest;
    notifyListeners();
  }

  Widget properties(BuildContext context) {
    print("Properitis called ${latestWidget?.name}");
    return latestWidget != null
        ? latestWidget.properties(context)
        : Container();
  }
}

class CustomPage {
  String pageName;
  CustomWidget rootWidget;

  CustomPage(this.pageName) {
    rootWidget = CustomRootWidget();
  }
}
