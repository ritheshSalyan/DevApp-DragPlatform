import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neumorphic/neumorphic.dart';

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
      // width: 150,
      // height: ,
      color: neuBackground,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InstuctionVariablePlaceHolder(
              onAccept: (data) {
                if (checkVariable(data, function)) {
                  c = data;
                  function.notify(context);
                }
              },
              child: c?.build(context),
            ),
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
            SizedBox(width: 10),
            Text("="),
            SizedBox(width: 10),
            InstuctionVariablePlaceHolder(
              onAccept: (data) {
                checkVariable(data, function);
                a = data;
                function.notify(context);
              },
              child: a?.build(context),
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
            InstuctionVariablePlaceHolder(
              onAccept: (data) {
                checkVariable(data, function);
                b = data;
                function.notify(context);
              },
              child: b?.build(context),
            ),
            // DragTarget<CustomVariables>(
            // onAccept: (data) {
            //   checkVariable(data, function);
            //   b = data;
            //   function.notify(context);
            // },
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

  @override
  Widget iconBuilder(BuildContext context) {
    return Icon(
      SimpleLineIcons.calculator,
      color: green,
    );
  }

  @override
  // TODO: implement name
  String get name => "Arithmatic Operation";

  @override
  Map<String, dynamic> toJson() {
    return {
      "a": a.toJson(),
      "b": b.toJson(),
      "operator":getOperator(type),
    };
  }

  @override
  fromJson(Map<String,dynamic> json) {
       a = CustomGlobalVariable("variableName").fromJson(json["a"]);
    b = CustomGlobalVariable("variableName").fromJson(json["b"]);
    type = getType(json["operator"]);
  }
}

class InstuctionVariablePlaceHolder extends StatelessWidget {
  const InstuctionVariablePlaceHolder({
    Key key,
    @required this.onAccept,
    @required this.child,
  }) : super(key: key);

  final void Function(CustomVariables) onAccept;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DragTarget<CustomVariables>(
      onAccept: onAccept,
      builder: (context, candidateData, rejectedData) => Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NeuCard(
              width: 20,
              height: 20,
              curveType: child != null ? CurveType.flat : CurveType.emboss,
              bevel: child != null ? 1 : 10,
              decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: neuBackground,
              )
              // decoration: BoxDecoration(
              //   color: neuBackground,
              //   boxShadow: [
              //     BoxShadow(
              //       offset: Offset(-5, -5),
              //       color: Colors.white,
              //       blurRadius: 6,
              //     ),
              //     BoxShadow(
              //       offset: Offset(10, 10),
              //       color: Colors.grey[300],
              //       blurRadius: 20,
              //     ),
              //   ],
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(25),
              //   topLeft: Radius.circular(25),
              // ),
              // ),
              ),
          NeuCard(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 50,
              // decoration: BoxDecoration(
              //   color: neuBackground,
              //   boxShadow: [
              //     BoxShadow(
              //       offset: Offset(0, -10),
              //       color: Colors.white,
              //       blurRadius: 20,
              //     ),
              //     BoxShadow(
              //       offset: Offset(10, 10),
              //       color: Colors.grey[300],
              //       blurRadius: 20,
              //     ),
              //   ],
              // ),
              bevel: child != null ? 1 : 10,
              curveType: child != null ? CurveType.flat : CurveType.emboss,
              decoration: NeumorphicDecoration(
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(25),
                //   topLeft: Radius.circular(25),
                // ),
                color: neuBackground,
              ),
              alignment: Alignment.center,
              child: child // Text("${variable.name}"),
              ),
        ],
      ),
    );
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

ArithmaticOperationType getType(String type) {
  switch (type) {
    case "+" :
      return ArithmaticOperationType.ADD;

    case  "-":
      return ArithmaticOperationType.SUBTRACT;

    case  "*":
      return ArithmaticOperationType.MULTIPLY;

    case  "/":
      return ArithmaticOperationType.DEVIDE;

    // case ArithmaticOperationType.MODULO:

    //   return "-";

  }
  return ArithmaticOperationType.ADD;
}
