import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';

class CustomPrint with CustomInstruction {
  CustomVariables a;
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
        InstuctionVariablePlaceHolder(
            onAccept: (data) {
              checkVariable(data, function);
              a = data;
              function.notify(context);
            },
            child: a?.build(context),
          ),
        // DragTarget<CustomVariables>(
        //   onAccept: (data) {
        //     checkVariable(data, function);
        //     a = data;
        //     print("INSIDE PRINT ${data.value} ");
        //     function.notify(context);
        //   },
        //   builder: (context, candidateData, rejectedData) => Container(
        //     width: 30,
        //     height: 30,
        //     color: Colors.yellow,
        //     child: a?.build(context),
        //   ),
        // )
      ],
    );
  }

  @override
  String get code => '''print(\'\$\{${a?.name ?? ""}\}\')  ''';

  @override
  void performOperation(_, CustomFunction function) {
    print("${a.value}");
  }

  @override
  CustomInstruction copy() {
    return CustomPrint();
  }

  @override
  Widget iconBuilder(BuildContext context) {
    return Icon(Icons.description, color: green);
  }

  @override
  // TODO: implement name
  String get name => "Print";
}
