import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/instruction_block.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neumorphic/neumorphic.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 500,
            color: neuBackground,
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
                //     function.notify(context);
                //   },
                //   builder: (context, candidateData, rejectedData) => Container(
                //     width: 30,
                //     height: 30,
                //     color: Colors.yellow,
                //     child: a?.build(context),
                //   ),
                // ),
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
                InstuctionVariablePlaceHolder(
                  onAccept: (data) {
                    checkVariable(data, function);
                    b = data;
                    function.notify(context);
                  },
                  child: b?.build(context),
                ),
                // DragTarget<CustomVariables>(
                //   onAccept: (data) {
                //     checkVariable(data, function);
                //     b = data;
                //     function.notify(context);
                //   },
                //   builder: (context, candidateData, rejectedData) => Container(
                //     width: 30,
                //     height: 30,
                //     color: Colors.yellow,
                //     child: b?.build(context),
                //   ),
                // )
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

  @override
  Map<String, dynamic> toJson() {
    return {
      "a": a.toJson(),
      "b": b.toJson(),
      "operator": getOperator(type),
      "true_block": trueBlock.toJson()
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    a = CustomGlobalVariable("variableName").fromJson(json["a"]);
    b = CustomGlobalVariable("variableName").fromJson(json["b"]);
    type = getType(json["operator"]);
    trueBlock = CustomBlock().fromJson(json["true_block"]);
  }
}

enum ComparisonOperationType {
  EQUAL_TO,
  NOT_EQUAL_TO,
  GRATER_THAN,
  GRATER_THAN_OR_EQUAL_TO,
  LESS_THAN,
  LESS_THAN_OR_EQUAL_TO,
}
ComparisonOperationType getType(String sType){
  switch (sType) {
    case "==":
      return ComparisonOperationType.EQUAL_TO; 
      break;
    case "!=":
      return ComparisonOperationType.NOT_EQUAL_TO; 
      break;
    case ">":
      return ComparisonOperationType.GRATER_THAN; 
      break;
    case ">=":
      return ComparisonOperationType.GRATER_THAN_OR_EQUAL_TO; 
      break;
    case "<":
      return ComparisonOperationType.LESS_THAN; 
      break;
    case "<=":
      return ComparisonOperationType.LESS_THAN_OR_EQUAL_TO; 
      break;
  }
  return ComparisonOperationType.EQUAL_TO;
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
