import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/class_model_generator.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';

class CustomPage {
  String pageName;
  String id;
  CustomWidget widgetTree;
 CustomClassModel classModel;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  CustomPage({
    this.pageName,
    this.id,
    this.widgetTree,
    this.createdAt,
    this.updatedAt,
    this.classModel,
    this.isActive,
  }) {
    if (widgetTree == null) {
      widgetTree = CustomRootWidget(pageName);
    }
     if (classModel == null) {
      classModel = CustomClassModel(pageName);
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
        // classModel: json[PAGES_WIDGET_TREE] == null
        //     ? CustomClassModel(json[PAGES_NAME]):
        //      CustomClassModel(json[PAGES_WIDGET_TREE]).fromJson(json),
        createdAt: json[CREATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[CREATED_AT]),
        updatedAt: json[UPDATED_AT] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json[UPDATED_AT]),
        isActive: json[IS_ACTIVE] == null ? true : json[IS_ACTIVE],
      );

  Map<String, dynamic> toJson() {
    // var pages_function_tree = PAGES_FUNCTION_TREE;
        return {
            PAGES_NAME: pageName == null ? "HomePage" : pageName,
            PAGES_ID: id == null ? null : id,
            PAGES_WIDGET_TREE: widgetTree == null
                ? CustomRootWidget(pageName).toJson()
                : widgetTree.toJson(),
            PAGES_FUNCTION_TREE: classModel == null
            ? CustomClassModel(pageName).toJson()
            : classModel.toJson(),
        CREATED_AT: createdAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : createdAt.millisecondsSinceEpoch,
        UPDATED_AT: updatedAt == null
            ? DateTime.now().millisecondsSinceEpoch
            : updatedAt.millisecondsSinceEpoch,
        IS_ACTIVE: isActive == null ? true : isActive,
      };
  }
}
