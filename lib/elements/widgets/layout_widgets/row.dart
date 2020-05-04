import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tree_view/tree_view.dart';

class CustomRow with CustomWidget {
  List<CustomWidget> children = [];
  // void addChild(BuildContext context, CustomWidget childWidget) {
  //   children.add(childWidget);
  //   super.addChild(context,childWidget;
  // }

  // @override
  // Widget build(context) {
  //   return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
  //     print("CustomRow");
  //     addChild(
  //       context,
  //     data.copy(),
  //     );
  //   }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
  //     return Row(
  //       children: children.isEmpty
  //           ? <Widget>[Container(width: 150, height: 150,color: Colors.transparent),]
  //           : List.generate(children.length + accept.length, (i) {
  //               if (i < children.length) {
  //                 return children[i].build(context);
  //               } else {
  //                 return Container(
  //                     color: Colors.blueAccent, width: 150, height: 150);
  //               }
  //             }),
  //     ); //currentWidget(type, child, context);
  //   });
  // }
  void addChild(BuildContext context, CustomWidget childWidget,
      {int position}) {
    print(position);

    children.insert(position ?? children.length, childWidget);
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    // return Column(
    //   children: List.generate(2 * children.length + 1, (int i) {
    //     if (i.isEven) {
    //       return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
    //         print("CustomColumn");
    //         addChild(context,   data.copy(), position: (i/2).floor());
    //       }, builder:
    //           (context, List<CustomWidget> accept, List<dynamic> reject) {
    //         // return Column(
    //         //   children: children.isEmpty
    //         //       ? <Widget>[Container(width: 150, height: 150,color: Colors.transparent),]
    //         //       :List.generate(children.length + accept.length, (i) {
    //         //     if (i < children.length) {
    //         // return children[(i/2).round()].build(context);
    //         // }
    //         // else{
    //         return accept.length>0? accept.first.build(context):Container(color: Colors.transparent,height: 10,);
    //         // }
    //       });
    //       // ); //currentWidget(type, child, context);
    //       // });
    //     } else {
    //       return children[(i / 2).floor()].build(context);
    //     }
    //   }),
    // );
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomColumn");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return ReorderableRow(
        needsLongPressDraggable: false,
        onReorder: (int oldIndex, int newIndex) {
          addChild(context, children.removeAt(oldIndex), position: newIndex);
        },
        children: children.isEmpty
            ? <Widget>[
                EmptyRepresenter(
                  key: ValueKey(0),
                  width: MediaQuery.of(context).size.width * 0.125,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                EmptyRepresenter(
                  key: ValueKey(1),
                  width: MediaQuery.of(context).size.width * 0.125,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                // EmptyRepresenter(
                //   key: ValueKey(2),
                //   width: MediaQuery.of(context).size.width * 0.1,
                //   height: MediaQuery.of(context).size.height * 0.2,
                // ),
              ]
            : List.generate(children.length + accept.length, (i) {
                if (i < children.length) {
                  return Container(
                    key: ValueKey(i),
                    child: children[i].build(
                      context,
                    ),
                    color: Colors.transparent,
                  );
                } else {
                  return Container(
                    key: ValueKey(i),
                    child: accept[i-children.length ].build(context),
                  );
                }
              }),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomRow();
  }

  @override
  // TODO: implement widget
  get name => "Row";
  @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (string) {
            // elevation = int.parse(string);
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
  Row(
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
                    ))
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: (constraints.width * 0.1),
            height: constraints.height * 0.9,
            color: green,
          ),
          Container(
            width: (constraints.width * 0.1),
            height: constraints.height * 0.9,
            color: green,
          ),
          Container(
            width: (constraints.width * 0.1),
            height: constraints.height * 0.9,
            color: green,
          ),
        ],
      ),
    );
  }
}
