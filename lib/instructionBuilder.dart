import 'package:flutter/material.dart';
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
              Container(
                width: 50,
                child: Column(
                  children: <Widget>[
                    
                    Draggable<CustomInstruction>(
                      data: CustomPrint(),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Text("prin"),
                        color: Colors.cyanAccent,
                      ),
                      feedback: Container(
                        width: 50,
                        height: 50,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    Draggable<CustomInstruction>(
                      data: CustomUpdateUi(),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Text("notify"),
                        color: Colors.cyanAccent,
                      ),
                      feedback: Container(
                        width: 50,
                        height: 50,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    Draggable<CustomInstruction>(
                      data: CustomArithmaticOperation(),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Text("inst"),
                        color: Colors.cyanAccent,
                      ),
                      feedback: Container(
                        width: 50,
                        height: 50,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    Draggable<CustomInstruction>(
                      data: CustomConditionalOperation(),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Text("Condition"),
                        color: Colors.cyanAccent,
                      ),
                      feedback: Container(
                        width: 50,
                        height: 50,
                        color: Colors.cyanAccent,
                      ),
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
                    Column(
                      children:
                          List<Widget>.from(widget.classModel.globalVariables.map(
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
                      )),
                    ),
                  ],
                ),
              ),
              

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
