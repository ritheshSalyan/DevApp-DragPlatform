import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

import 'package:flutter_drag_and_drop/constants.dart';

class CustomArithmaticOperation with CustomInstruction {
  CustomVariables a, b, c;
  ArithmaticOperationType type = ArithmaticOperationType.ADD;
  bool checkVariable(CustomVariables variables, CustomFunction function) {
    if (!variables.type.toString().contains(CONST_PREFIX)) {
      function.declareVariables(variables);
    }
    return !variables.type.toString().contains(CONST_PREFIX);
  }

  @override
  Widget build(BuildContext context, CustomFunction function) {
    return Container(
      width: 150,
      // height: ,
      color: neuBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DragTarget<CustomVariables>(
            onAccept: (data) {
              if (checkVariable(data, function)) {
                c = data;
                function.notify(context);
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
              function.notify(context);
            },
            builder: (context, candidateData, rejectedData) => Container(
              width: 30,
              height: 30,
              color: Colors.yellow,
              child: a?.build(context),
            ),
          ),
          SizedBox(width: 10),
          // Text("${getOperator(type)}"),
          Flexible(
            child: DropdownButton<ArithmaticOperationType>(
              value: type,
              items: List<DropdownMenuItem<ArithmaticOperationType>>.from(
                ArithmaticOperationType.values.map(
                  (e) => DropdownMenuItem<ArithmaticOperationType>(
                    child: Text(getOperator(e)),
                    value: e,
                  ),
                ),
              ),
              onChanged: (newType) {
                type = newType;
                function.notify(context);
              },
            ),
          ),
          DragTarget<CustomVariables>(
            onAccept: (data) {
              checkVariable(data, function);
              b = data;
              function.notify(context);
            },
            builder: (context, candidateData, rejectedData) => Container(
              width: 30,
              height: 30,
              color: Colors.yellow,
              child: b?.build(context),
            ),
          )
        ],
      ),
    );
  }

  @override
  String get code =>
      ''' ${c?.name ?? "_"} =  ${a?.name ?? 0} ${getOperator(type)} ${b?.name ?? 0} ;''';

  @override
  void performOperation(_, CustomFunction function) {
    // print("Inside Addition");
    c.value = getResult(type); //a.value + b.value;
  }

  @override
  CustomInstruction copy() {
    return CustomArithmaticOperation();
  }

  getResult(ArithmaticOperationType type) {
    switch (type) {
      case ArithmaticOperationType.ADD:
        return a.value + b.value;
        break;
      case ArithmaticOperationType.SUBTRACT:
        return a.value - b.value;
        break;
      case ArithmaticOperationType.MULTIPLY:
        return a.value * b.value;
        break;
      case ArithmaticOperationType.DEVIDE:
        return a.value / b.value;
        break;
    }
  }
}

enum ArithmaticOperationType {
  ADD,
  SUBTRACT,
  MULTIPLY,
  DEVIDE,
  // MODULO,
}

String getOperator(ArithmaticOperationType type) {
  switch (type) {
    case ArithmaticOperationType.ADD:
      return "+";

    case ArithmaticOperationType.SUBTRACT:
      return "-";

    case ArithmaticOperationType.MULTIPLY:
      return "*";

    case ArithmaticOperationType.DEVIDE:
      return "/";

    // case ArithmaticOperationType.MODULO:

    //   return "-";

  }
  return "+";
}
