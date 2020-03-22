import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';

class CustomText with CustomWidget {
  String data = "hello";
  Color color = Colors.black;
  CustomText({this.data});

  @override
  Widget build(context) {
    // print("data $this");
    return Text("$data",
    style: TextStyle(
        color: color,
    ),
    );
  }

  @override
  CustomWidget copy() {
    return CustomText(
      // data:data
    );
  }

  @override 
  get name => "Text";

    @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (string) {
            data = string;
            print(data);
            super.properties(context);
          },
        ),
        CustomColorPicker(onSelected: (color){
            this.color = color;
            super.properties(context);
        })
        

      ],
    );
  }
}
