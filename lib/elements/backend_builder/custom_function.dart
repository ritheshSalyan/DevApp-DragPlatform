import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/widgets/instruction_widget.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class CustomFunction {
  String functionName;
  double x = 0, y = 0;
  List<CustomVariables> inputs;
  List<CustomVariables> localVariables = [];
  CustomVariables output;
  // List<CustomInstruction> instructionSet = [];
  // List<NodePoint> nodePoint = [];
  // Map<CustomInstruction, Offset> map = {};
  List<LinkedListNode> instructions = [];
  ScrollController controller = ScrollController();
  CustomFunction(this.functionName) {
    randomNo = Random().nextInt(1000);
  }
  int randomNo;
  String get code => '''
  void $functionName(){
      ${decarationCodeGeneration()}
      ${instructionCodeGeneration()}
  }
   ''';

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
    return Positioned(
      top: y,
      left: x,
      child: Draggable(
        onDragEnd: (details) {
          x = details.offset.dx;
          y = details.offset.dy;
        },
        feedback: Opacity(
          opacity: 0.5,
          child: Container(
            width: size.width * 0.5,
            height: size.height * 0.75,
            color: Colors.red,
            // child: ListView.builder(
            //     itemCount: instructionSet.length,
            //     itemBuilder: (context, i) =>
            //         instructionSet[i].build(context, this)),
          ),
        ),
        // child: CustomPaint(
        //   painter: MultipleLinePainter(instructions),
        child: DragTarget<CustomInstruction>(
          onAccept: (data) {
            // instructionSet.add(data.copy());
            // map[data.copy()] = Offset(x + 30, y + 30);
            // nodePoint.add(NodePoint());
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
              // width: size.width * 0.5,
              // height: size.height * 0.75,
              curveType: CurveType.flat,
              decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: neuBackground,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: radius + radius,
                  bottom: radius + radius,
                  left: 15.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReorderableColumn(
                          //  scrollController: ScrollController(),                 // scrollController: controller,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
  
                          child:
                              instructions[i].instruction.build(context, this),
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
            );
          },
        ),
        // ),
      ),
    );
  }

  void notify(BuildContext context) {
    // Provider.of<ControllerClass>(context, listen: false).notify();
  }

  void execute(BuildContext context) {
    for (var inst in instructions) {
      //instructionSet) {
      inst.instruction.performOperation(context, this);
    }
  }
}

// class MultipleLinePainter extends CustomPainter {
//   List<LinkedListNode> nodes;
//   MultipleLinePainter(this.nodes);
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var node in nodes) {
//       print("HERE Before TO    ${node.sendPoint}, ");
//       if (node.from != null) {
//         print("HERE TO    ${node.from.sendPoint}, ${node.recievePoint},");
//         canvas.drawLine(
//             node.from.sendPoint,
//             node.recievePoint,
//             Paint()
//               ..strokeWidth = 4
//               ..color = Colors.green);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

class LinkedListNode {
  LinkedListNode from, to;

  // Data
  CustomInstruction instruction;
  Offset position, parentPosition;
  GlobalKey globalKeyForRecieve = GlobalKey();
  GlobalKey globalKeyForSend = GlobalKey();
  Offset recievePoint, sendPoint;

  LinkedListNode(this.instruction, this.position, this.parentPosition);
  void updatePosition(Offset newPosition, Offset newParentPosition) {
    position = newPosition;
    parentPosition = newParentPosition;
    setPoints();
  }

  void setSource(LinkedListNode newFrom) {
    from = newFrom;
    newFrom.setTo(this);
    setPoints();
  }

  void setTo(LinkedListNode newTo) {
    to = newTo;
    // to.setSource(this);
    setPoints();
  }

  void setPoints() {
    try {
      RenderBox box = globalKeyForSend.currentContext?.findRenderObject();
      Offset offset = box.globalToLocal(Offset.zero);
      sendPoint = Offset((offset.dx * -1) - parentPosition.dx,
          (offset.dy * -1) - parentPosition.dy);
    } catch (e) {}

    try {
      RenderBox box1 = globalKeyForRecieve.currentContext?.findRenderObject();
      Offset offset1 = box1.globalToLocal(Offset.zero);
      recievePoint = Offset((offset1.dx * -1) - parentPosition.dx,
          (offset1.dy * -1) - parentPosition.dy);
    } catch (e) {}
  }
}
