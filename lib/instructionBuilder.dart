import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/block_preview.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/side_tabbar.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/class_model_generator.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/conditional.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/custom_print.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/update_ui.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neumorphic/neumorphic.dart';

class CodeBuilder extends StatefulWidget {
  CustomClassModel classModel;

  CodeBuilder({Key key, @required this.classModel}) : super(key: key);
  @override
  _CodeBuilderState createState() => _CodeBuilderState();
}

class _CodeBuilderState extends State<CodeBuilder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("CLassModel ${widget.classModel}");
    return Scaffold(
      // appBar: AppBar(),
      // backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  width: size.width * 0.7,
                  height: size.height, //* 0.75,
                  color: Colors.transparent,
                  child: widget.classModel.build(context)),
              Container(
                  width: size.width * 0.3,
                  height: size.height, //* 0.75,
                  child: BlockListing(widget: widget)),
            ],
          ),
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: widget.classModel.variableCreation(context)),
        ],
      ),
    );
  }
}

class BlockListing extends StatefulWidget {
  const BlockListing({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CodeBuilder widget;

  @override
  _BlockListingState createState() => _BlockListingState();
}

class _BlockListingState extends State<BlockListing> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, right: 15.0),
            child: getSelectedPage(),
          ),
        ),
        CustomTabbar(
          titles: [
            "Instructions",
            "Control Instruction",
            "Variables",
            "Code",
          ],
          onSelect: (i) {
            // print("object $i");
            setState(() {
              selected = i;
            });
          },
        ),
      ],
    );
  }

  getSelectedPage() {
    return selected == 0
        ? ListView(
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
            ],
          )
        : selected == 1
            ? ListView(
                children: <Widget>[
                  InstructionDraggable(
                    instruction: CustomConditionalOperation(),
                  ),
                  Draggable<CustomFunction>(
                    data: CustomFunction(""),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: NeuCard(
                        curveType: CurveType.flat,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        bevel: 10,
                        color: neuBackground,
                        decoration: NeumorphicDecoration(
                            color: neuBackground,
                            borderRadius: BorderRadius.circular(25)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: neuBackground,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Container(
                                // color: green,
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  color: neuBackground,
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    MaterialCommunityIcons.gesture_tap,
                                    color: green,
                                  ),
                                ),
                              ),
                              Text(
                                "Function",
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
                    ),
                    feedback: Container(
                      width: 50,
                      height: 50,
                      color: Colors.amber,
                    ),
                  ),
                ],
              )
            : selected == 2
                ? Column(
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  VariablePreview(
                                    variable: CustomConstInt(variableValue: 1),
                                  ),
                                ],
                              ),
                              VariableListing(widget: widget.widget),
                            ],
                          )),
                      widget.widget.classModel.variableCreation(context),
                    ],
                  )
                : ListView(
                    children: [
                      NeuButton(
                        decoration: NeumorphicDecoration(color: neuBackground),
                        child: Text("Copy"),
                        onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.widget.classModel.code));
                      }),
                      Text(widget.widget.classModel.code),
                    ],
                  );
  }
}

class VariablePreview extends StatelessWidget {
  VariablePreview({
    Key key,
    @required this.variable,
  }) : super(key: key);
  CustomVariables variable;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Draggable<CustomVariables>(
        data: variable,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: neuBackground,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-5, -5),
                    color: Colors.white,
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    offset: Offset(10, 10),
                    color: Colors.grey[300],
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 50,
              decoration: BoxDecoration(
                color: neuBackground,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -10),
                    color: Colors.white,
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    offset: Offset(10, 10),
                    color: Colors.grey[300],
                    blurRadius: 20,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text("${variable.name}"),
            ),
          ],
        ),
        feedback: Opacity(
          opacity: 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: neuBackground,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-5, -5),
                      color: Colors.white,
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Colors.grey[300],
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: 50,
                decoration: BoxDecoration(
                  color: neuBackground,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -10),
                      color: Colors.white,
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Colors.grey[300],
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
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
          (e) => VariablePreview(
            variable: e, //CustomConstInt(variableValue: 1),
          ),
        ),
      ),
    );
  }
}
