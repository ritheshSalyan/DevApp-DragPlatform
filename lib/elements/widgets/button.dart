import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomButton with CustomWidget {
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
      print("Button");
      addChild(
        context,
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return RaisedButton(
        onPressed: () {},
        child: child == null ? null : child.build(context),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomButton();
  }

  @override
  // TODO: implement widget
  get name => "Button";
}
