import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

mixin CustomInstruction {
  // Offset get position;
  // set position(Offset pos);

  String get code;
  void performOperation(BuildContext context, CustomFunction customFunction);
  Widget build(
      BuildContext context, 
      CustomFunction function);
  CustomInstruction copy();
}

mixin CustomVariables {
  String get name;
  dynamic get type;
  dynamic get value;
  dynamic get initialValue;
  set value(dynamic);
  Widget build(BuildContext context);
}
String CONST_PREFIX = "CONST";