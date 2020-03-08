import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:provider/provider.dart';

mixin CustomWidget {
  Widget build(BuildContext context);

  get  name;

  CustomWidget copy();

  void addChild(BuildContext context, {CustomWidget childWidget}) {
    Provider.of<ControllerClass>(context, listen: false).update();
  }

  Widget properties(BuildContext context);
}

mixin CustomAppBarWidget on CustomWidget {
 
  Size get size; 
 
}