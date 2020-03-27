import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/multi_choice_selector.dart';

class CustomText with CustomWidget {
  String data = "hello";
  Color color = Colors.black;
  TextAlign textAlign = TextAlign.left;
  CustomText({this.data});

  @override
  Widget build(context) {
    // print("data $this");
    return Text(
      "$data",
    textAlign: textAlign,
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
        CustomColorPicker(
            color: color,
            lable: "Choose Text Color",
            onSelected: (color) {
              this.color = color;
              super.properties(context);
            }),

            CustomNeumorpicRadio(),
      ],
    );
  }

  @override
 
  String get code => ''' Text(
      "$data",
      textAlign: $textAlign,
      style: TextStyle(
        color: $color,
      ),
    )
  ''';//throw UnimplementedError();
}
