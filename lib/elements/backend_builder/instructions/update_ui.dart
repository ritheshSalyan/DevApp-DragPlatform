import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CustomUpdateUi with CustomInstruction {
  @override
  Widget build(BuildContext context, CustomFunction function) {
    return Row(
      children: <Widget>[
        Text("Update UI"),
        // )
      ],
    );
  }

  @override
  // TODO: implement code
  String get code => '''    notifyListeners()''';

  @override
  void performOperation(BuildContext context, CustomFunction function) {
    // print("${a.value}");
    Provider.of<ControllerClass>(context, listen: false).notify();
  }

  @override
  CustomInstruction copy() {
    return CustomUpdateUi();
  }

  @override
  Widget iconBuilder(BuildContext context) {
    return Icon(
      Octicons.desktop_download,
      color: green,
    );
  }

  @override
  String get name => "Update UI";

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  fromJson(_) {
   
  }
}
