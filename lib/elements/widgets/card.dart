import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomCard with CustomWidget {
  CustomWidget child;

  int elevation;
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
      print("CustomCard");
      addChild(
        context,
         data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Card(
        color: Colors.red,
        child: child == null
            ? null //Card()
            : child.build(context), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomCard();
  }

  @override
  // TODO: implement widget
  get name => "Card";

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
   String get code =>''' Card(
    ${child!=null ? "child :"+child.code+",":"" }
  )
  
  '''; 
}
