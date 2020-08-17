import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'dart:ui';

import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/models/page.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class CustomIcon with CustomWidget {
  IconData icon = Icons.ac_unit;
  double size = 10;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }

  @override
  Widget properties(BuildContext context, CustomPage page) {
    return ListView(
      children: [
        FlatButton(
            onPressed: () async {
              icon = await FlutterIconPicker.showIconPicker(
                context,
              );

              // icon = Icon(iconData);

              super.properties(context, page);
              // icon = Icon(icon)
            },
            child: Text("Pick Icon")),
        CustomColorPicker(
            color: color,
            lable: "Choose Text Color",
            onSelected: (color) {
              this.color = color;
              super.properties(context, page);
            }),
        Counter(
          initialValue: size,
          minValue: 0,
          maxValue: 100,
          step: 3,
          decimalPlaces: 1,
          onChanged: (value) {
            // get the latest value from here

            size = value;
            super.properties(context, page);
          },
        ),
      ],
    );
  }

  @override
  Widget buildTree(BuildContext context) {
    return Icon(icon ?? Icons.ac_unit);
  }

  @override
  // TODO: implement code
  String get code => '''Icon(
      ${icon},
      size: ${size},
      color: ${color},
    )''';

  @override
  CustomWidget copy() {
    return CustomIcon();
  }

  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    color = Color(json["color"]);
    size = json["size"];
    icon = IconData(json["icon"]);
  }

  @override
  // TODO: implement name
  String get name => "Icon";

  @override
  Widget prevIcon(Size constraints) {
    return Icon(Icons.insert_emoticon);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "color": color.value,
      "size": size,
      "icon": icon.codePoint,
    };
  }
}
