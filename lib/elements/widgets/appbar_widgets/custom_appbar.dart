import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomAppbar with CustomWidget, CustomAppBarWidget {
  CustomWidget child;
  void addChild(BuildContext context, {CustomWidget childWidget}) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget: childWidget);
    }
    super.addChild(context);
  }

  @override
  Widget build(context) {
    return AppBar();
    // return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
    //   print("CustomContainer");
    //   addChild(
    //     context,
    //     childWidget: data.copy(),
    //   );
    // }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {

    //   return child==null?EmptyRepresenter(width: null, height: null): Container(
    //     color: Colors.red,
    //     child: child == null
    //         ? EmptyRepresenter(width: null, height: null)//Container()
    //         : child.build(context), //Text("data"),
    //   ); //currentWidget(type, child, context);
    // });
  }

  @override
  CustomWidget copy() {
    return CustomAppbar();
  }

  @override
  // TODO: implement widget
  get name => "Container";

  @override
  // TODO: implement size
  Size get size => throw UnimplementedError();
}
