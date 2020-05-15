import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:neumorphic/neumorphic.dart';



class InstructionDraggable extends StatelessWidget {
  const InstructionDraggable({Key key, @required this.instruction})
      : super(key: key);
  final CustomInstruction instruction;
  @override
  Widget build(BuildContext context) {
    return Draggable<CustomInstruction>(
      data: instruction, //CustomPrint(),
      child: InstructionPreview(
        customInstruction: instruction, // CustomPrint(),
      ),
      feedback: Opacity(
        opacity: 0.5,
        child: Material(
          child: InstructionPreview(
            customInstruction: instruction, // CustomPrint(),
          ),
        ),
      ),
    );
  }
}



class InstructionPreview extends StatelessWidget {
  final CustomInstruction customInstruction;

  const InstructionPreview({Key key, @required this.customInstruction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: NeuCard(
        curveType: CurveType.flat,
        width: size.width * 0.1,
        height: size.width * 0.1,
        bevel: 10,
        color: neuBackground,
        decoration: NeumorphicDecoration(
        color: neuBackground,
          
          borderRadius: BorderRadius.circular(25)
        ),
        child: Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(25),
          color: neuBackground,

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[SizedBox(height: 10),
              Container(
                // color: green,
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: neuBackground,
                  padding: const EdgeInsets.all(2.0),
                  child: customInstruction.iconBuilder(context),
                ),
              ),
              Text(
                customInstruction.name,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


