import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomCenter with CustomWidget {
  CustomWidget child;
  void addChild(BuildContext context, {CustomWidget childWidget}) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget: childWidget);
    }
    super.addChild(context);
  }

  @override
  Widget build(context) {
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomCenter");
      addChild(
        context,
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Center(
        // color: Colors.red,
        child: child == null
            ? null //Center()
            : child.build(context), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomCenter();
  }

  @override
  // TODO: implement widget
  get name => "Center";
}
