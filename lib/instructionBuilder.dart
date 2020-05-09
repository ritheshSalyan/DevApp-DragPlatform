import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/class_model_generator.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/custom_print.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';

class CodeBuilder extends StatefulWidget {
  @override
  _CodeBuilderState createState() => _CodeBuilderState();
}

class _CodeBuilderState extends State<CodeBuilder> {
  CustomClassModel classModel = CustomClassModel("pageName");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Row(
          children: <Widget>[
            classModel.build(context),
            Column(
              children: <Widget>[
                Draggable<CustomInstruction>(
                  data: CustomAddition(),
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
              data: CustomConstInt(variableValue: 20),
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
            Draggable<CustomVariables>(
              data: CustomInt("a"),
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
            )
              ],
            )
          ],
        ),
      ),
    );
  }
}
