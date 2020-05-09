import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widget_track.dart';
import 'package:tree_view/tree_view.dart';

class CustomCard with CustomWidget {
  CustomWidget child;

  int elevation;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomCard");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Card(
        color: Colors.red,
        child: child == null
            ? null //Card()
            : child.build(context), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomCard();
  }

  @override
  // TODO: implement widget
  get name => "Card";

  @override
  Widget properties(BuildContext context,page) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (string) {
            elevation = int.parse(string);
          },
        ),
      ],
    );
  }

  String get code => ''' Card(
    ${child != null ? "child :" + child.code + "," : ""}
  )
  
  ''';
  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        trailing: SizedBox(width: 1,height: 1),
        initiallyExpanded: true,
        title: TreeItemView(customWidget: this), // Text("Container"),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children:

            // child == null
            //     ? ChildList()
            //     : ChildList(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children:
            child != null
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02),
                      child: child?.buildTree(context),
                    ),
                  ]
                : [],
        // ),
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
   return SizedBox(
     width: constraints.width,
     height: constraints.height*0.5,
     child: Card(elevation: 3,
      color: green,
      // width: constraints.width*0.9,
      // height: constraints.height*0.9,
  ),
   );
  }

  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    if (json[CHILD] != null) {
      child = getWidgetByName(json[CHILD][0][NAME]);
  child.fromJson(json[CHILD][0]);
    }
    // backgroundColor = json[PROPERTIES]["bg_color"];
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

    map[NAME] = name;
    map[PROPERTIES] = {
      // "bg_color":backgroundColor,
    };
    return map;
  }

}
