import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/multi_choice_selector.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomText with CustomWidget {
  String data = "hello";
  Color color = Colors.black;
  TextAlign textAlign = TextAlign.left;
  CustomText();

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

            CustomNeumorpicRadio(
              onSelect: (select) {
                textAlign = select;
              super.properties(context);

              },
              initialSelect: textAlign,
              lable: "Alignment",
              children:  {
            TextAlign.left: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.format_align_left,
                  color: green,
                ) //Text('First'),

                ),
            TextAlign.center: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.format_align_center,
                  color: green,
                ) //Text('First'),

                ),
            TextAlign.right: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.format_align_right,
                  color: green,
                ) //Text('First'),

                ),
            TextAlign.justify: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.format_align_justify,
                  color: green,
                ) //Text('First'),

                ),
          },
            ),
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
