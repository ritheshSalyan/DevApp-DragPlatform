import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

mixin CustomInstruction {
  // Offset get position;
  // set position(Offset pos);
  String get name;
  Widget iconBuilder(BuildContext context);
  String get code;
  void performOperation(BuildContext context, CustomFunction customFunction);
  Widget build(BuildContext context, CustomFunction function);
  CustomInstruction copy();

  Map<String, dynamic> toJson();
   fromJson(Map<String, dynamic> json);
}

mixin CustomVariables {
  String get name;
  dynamic get type;
  dynamic get value;
  dynamic get initialValue;
  set value(dynamic);
  Widget build(BuildContext context);
  Map<String, dynamic> toJson();
  fromJson(Map<String, dynamic> json);
}
String CONST_PREFIX = "CONST";
