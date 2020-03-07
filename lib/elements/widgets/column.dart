import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:reorderables/reorderables.dart';

class CustomColumn with CustomWidget {
  List<CustomWidget> children = [];
  void addChild(BuildContext context,
      {CustomWidget childWidget, int position}) {
    print(position);

    children.insert(position ?? 0, childWidget);
    super.addChild(context);
  }

  @override
  Widget build(context) {
    // return Column(
    //   children: List.generate(2 * children.length + 1, (int i) {
    //     if (i.isEven) {
    //       return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
    //         print("CustomColumn");
    //         addChild(context, childWidget: data.copy(), position: (i/2).floor());
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
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return ReorderableColumn(
        needsLongPressDraggable: false,
        onReorder: (int oldIndex, int newIndex) {
          addChild(context,
              childWidget: children.removeAt(oldIndex), position: newIndex);
        },
        children: children.isEmpty
            ? <Widget>[
                EmptyRepresenter(
                  key: ValueKey(0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                EmptyRepresenter(
                  key: ValueKey(1),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                EmptyRepresenter(
                  key: ValueKey(2),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ]
            : List.generate(children.length + accept.length, (i) {
                if (i < children.length) {
                  return Container(
                    key: ValueKey(i),
                    child: children[i].build(context),
                    color: Colors.transparent,
                  );
                } else {
                  return Container(
                      key: ValueKey(0),
                      color: Colors.blueAccent,
                      width: 150,
                      height: 150);
                }
              }),
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
}

