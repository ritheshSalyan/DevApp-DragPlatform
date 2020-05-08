import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';
// import 'package:responsive_builder/responsive_builder.dart';

class ControllerClass with ChangeNotifier {
  CustomWidget latestWidget;
  int activePage = 0;
  List<CustomPage> pages = [];

  Size size;
  ControllerClass() {
    pages.add(CustomPage("Page${pages.length + 1}"));
    // pages.first.rootWidget.fromJson({
    //   "child": [
    //     {
    //       "child":
    //        [
    //         {
    //           "child":
    //            [
    //             {
    //               "child":
    //                [
    //                 {
    //                   "child": null,
    //                   "properties": {
    //                     "font_weight": "Regular",
    //                     "font_size": 13,
    //                     "text_align": TextAlign.left,
    //                     "text": "hai wotld"
    //                   },
    //                   "name": "Text"
    //                 },
    //                 {
    //                   "child": 
    //                   [
    //                     {
    //                       "child": null,
    //                       "properties": {
    //                         "font_weight": "Regular",
    //                         'font_size': 13,
    //                         "text_align": TextAlign.left,
    //                         "text": 'bt'
    //                       },
    //                       'name': 'Text'
    //                     }
    //                   ],
    //                   "name": 'Button',
    //                   "properties": {'navigate_to': null}
    //                 },
    //                  {
    //                   "child": 
    //                   [
    //                     {
    //                       "child": null,
    //                       "properties": {
    //                         "font_weight": "Regular",
    //                         'font_size': 13,
    //                         "text_align": TextAlign.left,
    //                         "text": 'bt'
    //                       },
    //                       'name': 'Text'
    //                     }
    //                   ],
    //                   "name": 'Button',
    //                   "properties": {'navigate_to': null}
    //                 }, 
    //                 {
    //                   "child": 
    //                   [
    //                     {
    //                       "child": null,
    //                       "properties": {
    //                         "font_weight": "Regular",
    //                         'font_size': 13,
    //                         "text_align": TextAlign.left,
    //                         "text": 'bt'
    //                       },
    //                       'name': 'Text'
    //                     }
    //                   ],
    //                   "name": 'Button',
    //                   "properties": {'navigate_to': null}
    //                 },
    //                 {
    //                   "child": null,
    //                 //   [ {
    //                 //   "child": 
    //                 //   [
    //                 //     {
    //                 //       "child": null,
    //                 //       "properties": {
    //                 //         "font_weight": "Regular",
    //                 //         'font_size': 13,
    //                 //         "text_align": TextAlign.left,
    //                 //         "text": 'bt'
    //                 //       },
    //                 //       'name': 'Text'
    //                 //     }
    //                 //   ],
    //                 //   "name": 'Button',
    //                 //   "properties": {'navigate_to': null}
    //                 // },],
    //                   "name": 'Container',
    //                   "properties": {
    //         'color': Color(0xffff0000),
    //         'height': 1,
    //         'width': 1,
    //         'tlRad': 0,
    //         'blRad': 0,
    //         'trRad': 0,
    //         'brRad': 0,
    //         'alignment': 'topLeft'
    //       }
    //                   // {
    //                   //   'color': Color(0xff00cfff),
    //                   //   'height': 0.5,
    //                   //   'width': 1,
    //                   //   'tlRad': 0,
    //                   //   'blRad': 0,
    //                   //   'trRad': 0,
    //                   //   'brRad': 0,
    //                   //   'alignment': 'topLeft'
    //                   // }
    //                 }
    //               ],
                 
    //               "name": 'Column'
    //             }
    //           ],
             
    //           "name": 'Scaffold',
    //           "properties": {'bg_color': Color(0xff29f400)}
    //         }
    //       ],
      
    //       "name": 'Container',
    //       "properties": {
    //         'color': Color(0xffff0000),
    //         'height': 1,
    //         'width': 1,
    //         'tlRad': 0,
    //         'blRad': 0,
    //         'trRad': 0,
    //         'brRad': 0,
    //         'alignment': 'topLeft'
    //       }
    //     }
    //   ],
    //   "name": ' Page 1',
    //   "properties": {}
    // });
 
  }
  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }

  void addPage() {
    pages.add(CustomPage("Page ${pages.length + 1} "));
    activePage = pages.length - 1;
    latestWidget = null;
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
    rootWidget = CustomRootWidget(pageName);
  }
}
