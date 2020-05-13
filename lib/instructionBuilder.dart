import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/block_preview.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/class_model_generator.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/conditional.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/custom_print.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/update_ui.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';

class CodeBuilder extends StatefulWidget {
  CustomClassModel classModel;

  CodeBuilder({Key key, @required this.classModel}) : super(key: key);
  @override
  _CodeBuilderState createState() => _CodeBuilderState();
}

class _CodeBuilderState extends State<CodeBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.classModel.build(context),
              BlockListing(widget: widget),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: widget.classModel.variableCreation(context)),
        ],
      ),
    );
  }
}

class BlockListing extends StatelessWidget {
  const BlockListing({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CodeBuilder widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width * 0.15,
      child: ListView(
        controller: ScrollController(),
        children: <Widget>[
          InstructionDraggable(
            instruction: CustomPrint(),
          ),
          InstructionDraggable(
            instruction: CustomUpdateUi(),
          ),
          InstructionDraggable(
            instruction: CustomArithmaticOperation(),
          ),
          InstructionDraggable(
            instruction: CustomConditionalOperation(),
          ),


          Draggable<CustomFunction>(
            data: CustomFunction(""),
            child: Container(
              width: 50,
              height: 50,
              child: Text("Fun"),
              color: Colors.amber,
            ),
            feedback: Container(
              width: 50,
              height: 50,
              color: Colors.amber,
            ),
          ),
          Draggable<CustomVariables>(
            data: CustomConstInt(variableValue: 1),
            child: Container(
              width: 50,
              height: 50,
              child: Text("int"),
              color: Colors.teal,
            ),
            feedback: Container(
              width: 50,
              height: 50,
              color: Colors.teal,
            ),
          ),
          VariableListing(widget: widget),
        ],
      ),
    );
  }
}

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

class VariableListing extends StatelessWidget {
  const VariableListing({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CodeBuilder widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.from(
        widget.classModel.globalVariables.map(
          (e) => Draggable<CustomVariables>(
            data: e, //CustomConstInt(variableValue: 20),
            child: Container(
              width: 50,
              height: 50,
              child: Text(e.name),
              color: Colors.teal,
            ),
            feedback: Container(
              width: 50,
              height: 50,
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}
