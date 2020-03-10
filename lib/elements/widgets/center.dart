import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomCenter with CustomWidget {
  CustomWidget child;

  int elevation;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context,childWidget);
  }

  @override
  Widget build(context) {
      print("CustomCenter");

    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomCenter");
      addChild(
        context,
      data.copy(),
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
    @override
  Widget properties(BuildContext context) {
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
}
