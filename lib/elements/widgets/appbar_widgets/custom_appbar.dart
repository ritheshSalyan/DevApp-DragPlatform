import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomAppbar with CustomWidget, CustomAppBarWidget {
  CustomWidget child;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context,   childWidget);
    }
    super.addChild(context,childWidget);
  }

  @override
  Widget build(context) {
    return AppBar();
    
  }

  @override
  CustomWidget copy() {
    return CustomAppbar();
  }

  @override
  
  get name => "Container";

  @override
 
  Size get size => AppBar().preferredSize;

  @override
  Widget properties(BuildContext context) {
   return ListView();
  }
}
