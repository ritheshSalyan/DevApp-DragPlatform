import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';

class CustomPage {
  String pageName;
  String id;
  CustomWidget widgetTree;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  CustomPage({
    this.pageName,
    this.id,
    this.widgetTree,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  }) {
    if (widgetTree == null) {
      widgetTree = CustomRootWidget(pageName);
    }
  }
  factory CustomPage.fromJson(Map<String, dynamic> json, String id) =>
      CustomPage(
        pageName: json[PAGES_NAME] == null ? "Page" : json[PAGES_NAME],
        id: json[PAGES_ID] == null ? id : json[PAGES_ID],
        widgetTree: json[PAGES_WIDGET_TREE] == null
            ? CustomRootWidget(json[PAGES_NAME])
            : CustomRootWidget(json[PAGES_NAME])
                .fromJson(json[PAGES_WIDGET_TREE]),
        createdAt: json[CREATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[CREATED_AT]),
        updatedAt: json[UPDATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[UPDATED_AT]),
        isActive: json[IS_ACTIVE] == null ? true : json[IS_ACTIVE],
      );

  Map<String, dynamic> toJson() => {
        PAGES_NAME: pageName == null ? "HomePage" : pageName,
        PAGES_ID: id == null ? null : id,
        PAGES_WIDGET_TREE: widgetTree == null
            ? CustomRootWidget(pageName).toJson()
            : widgetTree.toJson(),
        CREATED_AT: createdAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : createdAt.millisecondsSinceEpoch,
        UPDATED_AT: updatedAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : updatedAt.millisecondsSinceEpoch,
        IS_ACTIVE: isActive == null ? true : isActive,
      };
}
