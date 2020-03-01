import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class CustomText with CustomWidget {
  @override
  Widget build(context) {
    return Text("data");
  }

  @override
  CustomWidget copy() {
    return CustomText();
  }

  @override
  // TODO: implement widget
  get name => "Text";
}
