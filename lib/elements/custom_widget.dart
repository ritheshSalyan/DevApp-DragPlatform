import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:provider/provider.dart';
// import 'package:responsive_builder/responsive_builder.dart';

mixin CustomWidget {
  Widget build(BuildContext context,);

 String get  name;
 Widget prevIcon(Size constraints);
 String get  code;

  CustomWidget copy();

  void addChild(BuildContext context, CustomWidget childWidget) {
    print("Add child ${childWidget.name} ");
    Provider.of<ControllerClass>(context, listen: false).updateChild(childWidget);
  }
  Widget buildTree(BuildContext context);

  Widget properties(BuildContext context){
    Provider.of<ControllerClass>(context, listen: false).notify();
  }
  void setActive(BuildContext context,CustomWidget customWidget){
    Provider.of<ControllerClass>(context, listen: false).latestWidget = customWidget;
    Provider.of<ControllerClass>(context, listen: false).notify();
  }
  CustomWidget fromJson(Map<String,dynamic> json);
  Map<String,dynamic> toJson();
}

mixin CustomAppBarWidget on CustomWidget {
 
  Size get size; 
 
}