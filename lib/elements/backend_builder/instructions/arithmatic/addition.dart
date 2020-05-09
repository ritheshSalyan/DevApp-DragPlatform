
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

class CustomAddition with CustomInstruction {
  CustomVariables a, b, c;
  bool checkVariable(CustomVariables variables, CustomFunction function) {
    if (!variables.type.toString().contains(CONST_PREFIX)) {
      function.declareVariables(variables);
    }
    return !variables.type.toString().contains(CONST_PREFIX);
  }

  @override
  Widget build(BuildContext context, CustomFunction function) {
    return Row(
      children: <Widget>[
        DragTarget<CustomVariables>(
          onAccept: (data) {
            if (checkVariable(data, function)) {
              c = data;
            }
          },
          builder: (context, candidateData, rejectedData) => Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
            child: c?.build(context),
          ),
        ),
        Text("="),
        DragTarget<CustomVariables>(
          onAccept: (data) {
            checkVariable(data, function);
            a = data;
          },
          builder: (context, candidateData, rejectedData) => Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
            child: a?.build(context),
          ),
        ),
        Text("+"),
        DragTarget<CustomVariables>(
          onAccept: (data) {
            checkVariable(data, function);
            b = data;
          },
          builder: (context, candidateData, rejectedData) => Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
            child: b?.build(context),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement code
  String get code => '''${c.name} =  ${a.name}+${b.name}  ''';

  @override
  void performOperation(CustomFunction function) {
    // print("Inside Addition");
    c.value = a.value+b.value;
  }

  @override
  CustomInstruction copy() {
    return CustomAddition();
  }
}

