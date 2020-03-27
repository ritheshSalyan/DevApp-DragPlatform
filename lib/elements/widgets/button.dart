import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomButton with CustomWidget {
  CustomWidget child;
  int elevation = 1;
  // double height= 0.25;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context,  childWidget);
    }
    super.addChild(context,childWidget);
  }

  @override
  Widget build(context) {
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("Button");
      addChild(
        context,
        data.copy(),
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
  get name => "Button";

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

  @override
  // TODO: implement code
  String get code => '''RaisedButton(
        onPressed: () {},
        ${ child == null ? "" : "child:"+child.code+','}
      )''';
  
}
