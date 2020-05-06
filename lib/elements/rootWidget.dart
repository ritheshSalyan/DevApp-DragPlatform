import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/widget_track.dart';
import 'package:tree_view/tree_view.dart';
// import 'package:flutter_drag_and_drop/elements/widgets/custom_fab.dart';

class CustomRootWidget with CustomWidget {
  CustomWidget child;
  // CustomAppBarWidget appbar;
  final String pageName;

  Color backgroundColor = Colors.white;

  CustomRootWidget(this.pageName);
  void addChild(
    BuildContext context,
    CustomWidget childWidget,
  ) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  // void addAppbar(
  //   BuildContext context, {
  //   CustomAppBarWidget appBarWidget,
  // }) {
  //   appbar = appBarWidget;
  //   super.addChild(context, appBarWidget);
  // }

  @override
  Widget build(context) {
    print("CustomScaffold");

    return Scaffold(
      backgroundColor: backgroundColor,
      body: child != null
          ? child.build(context)
          : DragTarget(onAccept: (CustomWidget data) {
              // print("CustomScaffold");
              addChild(
                context,
                data.copy(),
              );
            }, builder:
              (context, List<CustomWidget> accept, List<dynamic> reject) {
              return accept != null && accept.isNotEmpty
                  ? accept.first.build(context)
                  : EmptyRepresenter();
            }),
    );
  }

  @override
  CustomWidget copy() {
    return CustomRootWidget(pageName);
  }

  @override
  // TODO: implement widget
  get name => pageName;

  @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        // CustomColorPicker(
        //   color: backgroundColor,
        //   lable: "Background Color",
        //   onSelected: (Color colorSelected) {
        //     this.backgroundColor = colorSelected;
        //     super.properties(context);
        //   },
        // ),
      ],
    );
  }

  @override
  String get code => '''
     ${child != null ? child.code : ""}
     '''; //throw UnimplementedError();

  @override
  Widget buildTree(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      trailing: SizedBox(width: 1, height: 1),
      title: TreeItemView(customWidget: this),
      onExpansionChanged: (value) {
        super.setActive(context, this);
      },
      children: child == null
          ? [] //ChildList()
          :
          //  ChildList(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children:
          <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: child?.buildTree(context),
              ),
            ],
      // ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return SizedBox(
      width: 0,
      height: 0,
    );
  }

  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    if (json[CHILD] != null) {
      child = getWidgetByName(json[CHILD][0][NAME]);
     child.fromJson(json[CHILD][0]);
    }
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (child != null) {
      map[CHILD] = [child.toJson()];
    } else {
      map[CHILD] = null;
    }

    map[NAME] = pageName;
    map[PROPERTIES] = {};
    return map;
  }
}
