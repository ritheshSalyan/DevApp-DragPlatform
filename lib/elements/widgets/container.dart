import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomContainer with CustomWidget {
  CustomWidget child;

  int elevation;
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
      print("CustomContainer");
      addChild(
        context,
        childWidget: data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) { 

      return child==null?EmptyRepresenter(width: null, height: null): Container(
        color: Colors.red,
        child: child == null
            ? EmptyRepresenter(width: null, height: null)//Container()
            : child.build(context), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomContainer();
  }

  @override
  // TODO: implement widget
  get name => "Container";

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
