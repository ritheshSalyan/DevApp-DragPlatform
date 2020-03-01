
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomScaffold with CustomWidget {
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
      print("CustomScaffold");
      addChild(
        context,
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Scaffold(
        // color: Colors.red,
        appBar: AppBar(),
        body: child == null
            ? null //Container()
            : child.build(context),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomScaffold();
  }

  @override
  // TODO: implement widget
  get name => "Scaffold";
}
