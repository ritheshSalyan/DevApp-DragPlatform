import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomRow with CustomWidget {
  List<CustomWidget> children = [];
  void addChild(BuildContext context, {CustomWidget childWidget}) {
    children.add(childWidget);
    super.addChild(context);
  }

  @override
  Widget build(context) {
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomRow");
      addChild(
        context,
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Row(
        children: children.isEmpty
            ? <Widget>[Container(width: 150, height: 150,color: Colors.transparent),]
            : List.generate(children.length + accept.length, (i) {
                if (i < children.length) {
                  return children[i].build(context);
                } else {
                  return Container(
                      color: Colors.blueAccent, width: 150, height: 150);
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
}
