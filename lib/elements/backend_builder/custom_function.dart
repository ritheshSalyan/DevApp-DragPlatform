import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:provider/provider.dart';

class CustomFunction {
  String functionName;

  List<CustomVariables> inputs;
  List<CustomVariables> localVariables = [];
  CustomVariables output;
  List<CustomInstruction> instructionSet = [];

  CustomFunction(this.functionName);

  String get code => '''
  void $functionName(){
      ${decarationCodeGeneration()}
      ${instructionCodeGeneration()}
  }
   ''';

  String instructionCodeGeneration() {
    String instuctionCode = "";
    for (var inst in instructionSet) {
      instuctionCode += inst.code + ";\n";
    }

    return instuctionCode;
  }

  String decarationCodeGeneration() {
    String code = "";
    for (var item in localVariables) {
      code += "${item.type} ${item.name} = ${item.initialValue} ;";
    }
    return code;
  }

  CustomFunction copy(String name) {
    return CustomFunction(name);
  }

  void declareVariables(CustomVariables variables) {
    // if (localVariables..contains(variables)) {
    //   return;
    // }
    for (var element in localVariables) {
      if (element.name.compareTo(variables.name) == 0) return;
    }
    localVariables.add(variables);
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DragTarget<CustomInstruction>(
      onAccept: (data) {
        instructionSet.add(data.copy());
        notify(context);
      },
      builder: (BuildContext context, List<CustomInstruction> candidateData,
          List<dynamic> rejectedData) {
        // print("object");
        return Container(
          width: size.width * 0.5,
          height: size.height * 0.75,
          color: Colors.red,
          child: ListView.builder(
              itemCount: instructionSet.length,
              itemBuilder: (context, i) =>
                  instructionSet[i].build(context, this)),
        );
      },
      // child:
    );
  }

  void notify(BuildContext context) {
    Provider.of<ControllerClass>(context, listen: false).notify();
  }

  void execute() {
    for (var inst in instructionSet) {
      inst.performOperation(this);
    }
  }
}
