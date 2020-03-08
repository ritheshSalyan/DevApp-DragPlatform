import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomText with CustomWidget {
  String data;

  @override
  Widget build(context) {
    return Text("$data");
  }

  @override
  CustomWidget copy() {
    return CustomText();
  }

  @override 
  // TODO: implement widget
  get name => "Text";

    @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (string) {
            data = string;
          },
        ),
      ],
    );
  }
}
