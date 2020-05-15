import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widget_track.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tree_view/tree_view.dart';

class CustomColumn with CustomWidget {
  List<CustomWidget> children = [];

  int elevation;
  void addChild(BuildContext context, CustomWidget childWidget,
      {int position}) {
    print(position);

    children.insert(position ?? children.length, childWidget);
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    Size size = Provider.of<ControllerClass>(context, listen: false).size;
    
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomColumn");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Container(
        height: size.height,
        child: ReorderableColumn(
      scrollController: ScrollController(),
          needsLongPressDraggable: false,
          onReorder: (int oldIndex, int newIndex) {
            addChild(context, children.removeAt(oldIndex), position: newIndex);
          },
          children: children.isEmpty
              ? <Widget>[
                  EmptyRepresenter(
                    key: ValueKey(0),
                    width: size.width * 0.5,
                    height: size.height / 3,
                  ),
                  EmptyRepresenter(
                    key: ValueKey(1),
                    width: size.width * 0.5,
                    height: size.height / 3,
                  ),
                  EmptyRepresenter(
                    key: ValueKey(2),
                    width: size.width * 0.5,
                    height: size.height / 3,
                  ),
                ]
              : List.generate(children.length + accept.length, (i) {
                  if (i < children.length) {
                    return SizedBox(
                        key: ValueKey(i), child: children[i].build(context));
                  } else {
                     return Container(
                    key: ValueKey(i),
                    child: accept[i - children.length ].build(context),
                  );
                  }
                }),
        ),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomColumn();
  }

  @override
  // TODO: implement widget
  get name => "Column";
  @override
  Widget properties(BuildContext context,_) {
    return ListView(
      controller: ScrollController(),
      children: <Widget>[
        TextField(
          onChanged: (string) {
            elevation = int.parse(string);
          },
        ),
      ],
    );
  }

  String childrenCode() {
    String code = "";
    children.forEach((child) {
      code += child.code + ',';
    });
    return code;
  }

  @override
  // TODO: implement code
  String get code => '''
  Column(
    children:<Widget>[
      ${childrenCode()}
    ]
  )''';

  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox(width: 1,height: 1),
        title: TreeItemView(customWidget: this),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children: children.isEmpty
            ? []
            : 
            // ChildList(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children:
                 List<Widget>.generate(
                    children.length,
                    (i) => Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: children[i]?.buildTree(context),
                        ),)
                        // )
        // child.buildTree(context),
        ,
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Container(
      // color: green,
      width: constraints.width * 0.9,
      height: constraints.height * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05) ,
            color: green,
          ),
          // Container(
          //   height: (constraints.height * 0.05) ,
          // ),
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05) ,
            color: green,
          ),
          // Container(
          //   height: (constraints.height * 0.05),
          // ),
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05) ,
            color: green,
          ),
        ],
      ),
    );
  }
    @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    if (json[CHILD] != null) {
      children = List<CustomWidget>.from(
          json[CHILD].map((x) => getWidgetByName(x[NAME])));
      // child.fromJson(json[CHILD][0]);
      if (children != null) {
        // children.forEach((element) {
        // });

        for (var i = 0; i < children.length; i++) {
          children[i].fromJson(json[CHILD][i]);
        }
      }
    }
    // color = json[PROPERTIES]["color"];
    // height = json[PROPERTIES]["height"];
    // width = json[PROPERTIES]["width"];
    // tlRad = json[PROPERTIES]["tlRad"];
    // blRad = json[PROPERTIES]["blRad"];
    // trRad = json[PROPERTIES]["trRad"];
    // brRad = json[PROPERTIES]["brRad"];
    // alignment = json[PROPERTIES]["alignment"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (children != null) {
      map[CHILD] = List<dynamic>.from(
          children.map((e) => e.toJson())); // [child.toJson()];
    } else {
      map[CHILD] = null;
    }

    map[NAME] = name;
    // map[PROPERTIES] = {
    //   "color": color,
    //   "height": height,
    //   "width": width,
    //   "tlRad": tlRad,
    //   "blRad": blRad,
    //   "trRad": trRad,
    //   "brRad": brRad,
    //   "alignment": alignment
    // };
    return map;
  }
}
