import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/width_height_selector.dart';
import 'package:provider/provider.dart';

class CustomContainer with CustomWidget {
  CustomWidget child;
  double width = 1.0, height = 0.5;
  Color color = Colors.white;

  int elevation;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    Size size = Provider.of<ControllerClass>(context,listen:false).sizingInformation.localWidgetSize;
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomContainer");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Container(
        width: size.width * width,
        height: size.height * height,
        color: color, // Colors.red,
        child: child == null
            ? EmptyRepresenter(
                width:size.width * width,
                height: size.height*height) //Container()
            : child.build(context,), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomContainer();
  }

  @override
  get name => "Container";

  @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        CustomColorPicker(
          color: color,
          lable: "Background Color",
          onSelected: (Color colorSelected) {
            this.color = colorSelected;
            super.properties(context);
          },
        ),
        WidthSelector(
          lable: "Width",
          initialValue: width,
          onChanged:(double newWidth){
            width = newWidth;
            super.properties(context);
          }
        ),
        WidthSelector(
          lable: "height",
          initialValue: height,
          onChanged:(double newHeight){
            height = newHeight;
            print("Height:$height");
            super.properties(context);
          }
        ),
      ],
    );
  }

  @override
  // TODO: implement code
  String get code => ''' Container(
    ${child != null ? "child :" + child.code + "," : ""}
  )'''; //throw UnimplementedError();
}
