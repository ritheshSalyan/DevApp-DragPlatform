import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
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
  double fontSize = 13;
  FontWeight fontWeight = FontWeight.w400;
  @override
  Widget build(context) {
    // print("data $this");
    return Text(
      "$data",
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
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
          children: {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Font Weight "),
            Counter(
              initialValue: fontSize,
              minValue: 10,
              maxValue: 1000,
              step: 1,
              decimalPlaces: 1,
              onChanged: (value) {
                // get the latest value from here

                fontSize = value;
                // refresh();
                super.properties(context);
              },
            ),
          ],
        ),
        DropdownButton<FontWeight>(
          value: fontWeight,
          isDense: true,
          isExpanded: true,
            items: List<DropdownMenuItem<FontWeight>>.generate(
                fontWeightMap.length,
                (index) => DropdownMenuItem(
                      value: fontWeightMap.keys.elementAt(index),
                      child: Text(
                        fontWeightMap.values.elementAt(index),
                        style: TextStyle(
                            fontWeight: fontWeightMap.keys.elementAt(index)),
                      ),
                    )),
            onChanged: (fw) {
              fontWeight = fw;
              super.properties(context);
            }),
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
  ''';

  @override
  Widget buildTree(BuildContext context) {
    return ListTile(
      onTap: () {
        super.setActive(context, this);
      },
      title: Text("$data"),
      leading: Icon(Icons.text_fields),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Icon(Icons.text_fields);
  }

  // @override
  // // TODO: implement prevIcon
  // Widget get prevIcon => Icon(Icons.text_fields);//throw UnimplementedError();
}
