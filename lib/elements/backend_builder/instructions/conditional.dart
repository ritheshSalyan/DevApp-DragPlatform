import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/instruction_block.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomConditionalOperation with CustomInstruction {
  CustomVariables a, b;
  ComparisonOperationType type = ComparisonOperationType.EQUAL_TO;
  bool checkVariable(CustomVariables variables, CustomFunction function) {
    if (!variables.type.toString().contains(CONST_PREFIX)) {
      function.declareVariables(variables);
    }
    return !variables.type.toString().contains(CONST_PREFIX);
  }

  CustomBlock trueBlock = CustomBlock();
  @override
  Widget build(BuildContext context, CustomFunction function) {
    return Container(
      // width: 150,
      // height: ,
      child: Column(
        children: <Widget>[
          Container(
            width:500,
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // DragTarget<CustomVariables>(
                //   onAccept: (data) {
                //     if (checkVariable(data, function)) {
                //       c = data;
                //       function.notify(context);
                //     }
                //   },
                //   builder: (context, candidateData, rejectedData) => Container(
                //     width: 30,
                //     height: 30,
                //     color: Colors.yellow,
                //     child: c?.build(context),
                //   ),
                // ),
                // Text("="),
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
                  child: DropdownButton<ComparisonOperationType>(
                    value: type,
                    items: List<DropdownMenuItem<ComparisonOperationType>>.from(
                      ComparisonOperationType.values.map(
                        (e) => DropdownMenuItem<ComparisonOperationType>(
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
          ),
          trueBlock.build(context, function),
        ],
      ),
    );
  }

  @override
  String get code =>
      '''if(${a?.name ?? 0} ${getOperator(type)} ${b?.name ?? 0} ){
          
      }''';

  @override
  void performOperation(context, CustomFunction function) {
    // print("Inside Addition");
    if (getResult(type)) {
      trueBlock.execute(context, function);
    }
  }

  @override
  CustomInstruction copy() {
    return CustomConditionalOperation();
  }

  getResult(ComparisonOperationType type) {
    switch (type) {
      case ComparisonOperationType.EQUAL_TO:
        return a.value == b.value;
        break;
      case ComparisonOperationType.NOT_EQUAL_TO:
        return a.value != b.value;
        break;
      case ComparisonOperationType.GRATER_THAN:
        return a.value > b.value;

        break;
      case ComparisonOperationType.GRATER_THAN_OR_EQUAL_TO:
        return a.value >= b.value;
        break;
      case ComparisonOperationType.LESS_THAN:
        return a.value < b.value;

        break;
      case ComparisonOperationType.LESS_THAN_OR_EQUAL_TO:
        return a.value <= b.value;

        break;
    }
  }
@override
  Widget iconBuilder(BuildContext context) {
    return Icon(
      MaterialIcons.call_split,
      color: green,
    );
  }

  @override
  // TODO: implement name
  String get name => "Condition";
}

enum ComparisonOperationType {
  EQUAL_TO,
  NOT_EQUAL_TO,
  GRATER_THAN,
  GRATER_THAN_OR_EQUAL_TO,
  LESS_THAN,
  LESS_THAN_OR_EQUAL_TO,
  // MODULO,
}

String getOperator(ComparisonOperationType type) {
  switch (type) {
    case ComparisonOperationType.EQUAL_TO:
      return "==";
      break;
    case ComparisonOperationType.NOT_EQUAL_TO:
      return "!=";
      break;
    case ComparisonOperationType.GRATER_THAN:
      return ">";
      break;
    case ComparisonOperationType.GRATER_THAN_OR_EQUAL_TO:
      return ">=";
      break;
    case ComparisonOperationType.LESS_THAN:
      return "<";
      break;
    case ComparisonOperationType.LESS_THAN_OR_EQUAL_TO:
      return "<=";
      break;
  }
  return "==";
}
