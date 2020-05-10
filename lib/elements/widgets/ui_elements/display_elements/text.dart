import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/responsive_textfield.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/multi_choice_selector.dart';
import 'package:flutter_drag_and_drop/models/page.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CustomText with CustomWidget {
  String data = "hello";
  CustomVariables variables;
  Color color = Colors.black;
  TextAlign textAlign = TextAlign.left;
  CustomText();
  double fontSize = 13;
  FontWeight fontWeight = FontWeight.w400;
  bool isVar = false;
  @override
  Widget build(context) {
    // print("data $this");
    return Text(
      "${isVar?variables?.value??"":data}",
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
  Widget properties(BuildContext context, CustomPage page) {
    return ListView(
      children: <Widget>[
        // Provider.of<ControllerClass>(context,listen: false).
        DropdownButton<CustomVariables>(
            value: variables,
            items: List<DropdownMenuItem<CustomVariables>>.from(page
                .classModel.globalVariables
                .map((e) => DropdownMenuItem<CustomVariables>(
                      child: Text(e.name),
                      value: e,
                    ))),
            onChanged: (newFunction) {
              variables = newFunction;
              isVar = true;
              super.properties(context, page);
            }),
        // page.classModel.globalVariables.forEach((element) {}),
        Text("OR"),
        ResponsiveTextField(
            validate: (string) {
              data = string;
              print(data);
              isVar = false;
              super.properties(context, page);
              return TextFieldState.VALID;
            },
            setMessage: (_, __) => null),

        // TextField(
        //   onChanged: (string) {

        //   },
        // ),
        CustomColorPicker(
            color: color,
            lable: "Choose Text Color",
            onSelected: (color) {
              this.color = color;
              super.properties(context, page);
            }),
        CustomNeumorpicRadio(
          onSelect: (select) {
            textAlign = select;
            super.properties(context, page);
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
            Text("Font Size "),
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
                super.properties(context, page);
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
              super.properties(context, page);
            }),
      ],
    );
  }

  @override
  String get code => ''' Text(
      ${isVar?"viewModel."+variables?.name??"":data}
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

  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    // if (json[CHILD] != null) {
    //   child = getWidgetByName(json[CHILD][NAME]);
    //   child.fromJson(json[CHILD]);
    // }
    fontWeight = fontWeightMap.keys.elementAt(
        fontWeightMap.values.toList().indexOf(json[PROPERTIES]["font_weight"]));
    fontSize = json[PROPERTIES]["font_size"] * 1.0;
    textAlign = convertStringToTextAlign(json[PROPERTIES]["text_align"]);
    data = json[PROPERTIES]["text"];
    color = json[PROPERTIES]["color"] != null
        ? Color(json[PROPERTIES]["color"])
        : Colors.black;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    // if (child != null) {
    //   map[CHILD] = child.toJson();
    // } else {
    map[CHILD] = null;
    // }

    // map[NAME] = pageName;
    map[PROPERTIES] = {
      "font_weight": fontWeightMap[fontWeight],
      "font_size": fontSize,
      "text_align": convertTextAlignToString(textAlign),
      "text": data,
      "color": color.value
    };
    map[NAME] = name;

    return map;
  }
}

String convertTextAlignToString(TextAlign textAlign) {
  switch (textAlign) {
    case TextAlign.left:
      return "left";
      break;
    case TextAlign.right:
      return "right";

      break;
    case TextAlign.center:
      return "center";

      break;
    case TextAlign.justify:
      return "justify";

      break;
    case TextAlign.start:
      return "start";

      break;
    case TextAlign.end:
      return "end";

      break;
  }
  return "left";
}

TextAlign convertStringToTextAlign(String text) {
  switch (text) {
    case "left":
      return TextAlign.left;
      break;
    case "right":
      return TextAlign.right;

      break;
    case "center":
      return TextAlign.center;

      break;
    case "justify":
      return TextAlign.justify;

      break;
    case "start":
      return TextAlign.start;

      break;
    case "end":
      return TextAlign.end;

      break;
    default:
      return TextAlign.left;
  }
}
