import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:reorderables/reorderables.dart';

class CustomBlock {
  // CustomFunction function;
  double x = 0, y = 0;

  List<LinkedListNode> instructions = [];

  int randomNo;
  CustomBlock() {
    randomNo = Random().nextInt(1000);
  }

  String get code => '''
    {
      ${instructionCodeGeneration()}
    }
   ''';
  // ${decarationCodeGeneration()}

  String instructionCodeGeneration() {
    String instuctionCode = "";
    for (var inst in instructions) {
      //instructionSet) {
      instuctionCode += inst.instruction.code + "\n";
    }

    return instuctionCode;
  }

  String decarationCodeGeneration() {
    String code = "";
    // for (var item in localVariables) {
    //   code += "${item.type} ${item.name} = ${item.initialValue} ;";
    // }
    return code;
  }

  CustomBlock copy() {
    return CustomBlock();
  }

  // void declareVariables(CustomVariables variables) {
  //   // if (localVariables..contains(variables)) {
  //   //   return;
  //   // }
  //   for (var element in localVariables) {
  //     if (element.name.compareTo(variables.name) == 0) return;
  //   }
  //   localVariables.add(variables);
  // }

  Widget build(BuildContext context, CustomFunction function) {
    Size size = MediaQuery.of(context).size;
    return DragTarget<CustomInstruction>(
      onAccept: (data) {
        instructions.add(
          LinkedListNode(
            data.copy(),
            Offset(x + 30, y + 30),
            Offset(x, y),
          ),
        );
        notify(context);
      },
      builder: (BuildContext context, List<CustomInstruction> candidateData,
          List<dynamic> rejectedData) {
        return NeuCard(
          curveType: CurveType.emboss,
          // color: neuBackground,
          decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                topLeft: Radius.circular(radius)),
            color: neuBackground,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20, bottom: 10),
            child: NeuCard(
              curveType: CurveType.flat,
              decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: neuBackground,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: radius + radius, bottom: radius + radius, left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReorderableColumn(
                      scrollController:
                          ScrollController(), // scrollController: controller,

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      onReorder: (oldIndex, newIndex) {
                        LinkedListNode temp = instructions.removeAt(oldIndex);
                        instructions.insert(newIndex, temp);
                      },
                      // itemCount: instructionSet.length,
                      // itemBuilder: (context, i) =>
                      // instructionSet[i].build(context, this)

                      children: List<Widget>.generate(
                        instructions.length,
                        (int i) => Container(
                          key: ValueKey(i * randomNo),
                          color: neuBackground,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(vertical: 10),

                          // curveType: CurveType.emboss,
                          // decoration: NeumorphicDecoration(
                          //   borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(radius),
                          //       topLeft: Radius.circular(radius)),
                          //   color: neuBackground,
                          // ),
                          child: instructions[i]
                              .instruction
                              .build(context, function),
                          // child: InstructionNode(
                          //   // position: map.values.elementAt(i),
                          //   // nodePoint:nodePoint[i],
                          //   // connectTo:
                          //   function: this,
                          //   linkedNode: instructions[i],
                          //   shouldpositionUpdate: (newPosition) {
                          //     // print("New Position $newPosition");
                          //     if (newPosition.dx > (x + size.width * 0.5) ||
                          //         newPosition.dy > (y + size.height * 0.75)) {
                          //       // map[e] = newPosition;
                          //       return false;
                          //     }
                          //     instructions[i].updatePosition(
                          //         Offset(newPosition.dx - x, newPosition.dy - y),
                          //         Offset(x, y));
                          //     return true;
                          //   },
                          //   // child:  map.keys.elementAt(i).build(context, this),
                          // ),
                        ),
                      ),
                    ),
                    NeuCard(
                        // key: ValueKey(i*randomNo),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.25,
                        height: size.height * 0.1,
                        curveType: CurveType.emboss,
                        decoration: NeumorphicDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radius),
                              topLeft: Radius.circular(radius)),
                          color: neuBackground,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void notify(BuildContext context) {
    // Provider.of<ControllerClass>(context, listen: false).notify();
  }

  void execute(BuildContext context, CustomFunction function) {
    for (var inst in instructions) {
      //instructionSet) {
      inst.instruction.performOperation(context, function);
    }
  }
}
