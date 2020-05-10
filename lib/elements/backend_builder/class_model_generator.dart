import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/responsive_textfield.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/variables/variables.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class CustomClassModel {
  String pageName;
  CustomClassModel(this.pageName) {
    functions = [];
  }
  List<CustomFunction> functions;
  List<CustomVariables> globalVariables = [];

  String get code => '''
        class $pageName {
          ${functions.first.code}
        }
   ''';

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DragTarget<CustomFunction>(
      onAccept: (data) {
        functions.add(data.copy("function${functions.length}"));
      },
      builder: (BuildContext context, List<CustomFunction> candidateData,
          List<dynamic> rejectedData) {
        return Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.5, //* 0.75,
                  color: Colors.blue,
                  child: ListView.builder(
                      itemCount: functions.length,
                      itemBuilder: (context, i) => functions[i].build(
                            context,
                          )),
                ),
                RaisedButton(onPressed: () {
                  functions.first.execute();
                })
              ],
            ),
            Container(
              width: size.width * 0.25,
              height: size.height, //* 0.75,
              color: Colors.blue,
              child: ListView.builder(
                  itemCount: functions.length,
                  itemBuilder: (context, i) => Text(functions[i].code)),
            ),
          ],
        );
      },
    );
  }

  Widget variableCreation(BuildContext context) {
    return VariableAddingWidget(
        addVariable: (String variableName, dynamic value) {
      globalVariables
          .add(CustomGlobalVariable(variableName, variableValue: value));
      Provider.of<ControllerClass>(context, listen: false).notify();
    });
  }
}

class VariableAddingWidget extends StatefulWidget {
  const VariableAddingWidget({
    Key key,
    this.addVariable,
  }) : super(key: key);
  final void Function(String variableName, dynamic value) addVariable;
  @override
  _VariableAddingWidgetState createState() => _VariableAddingWidgetState();
}

class _VariableAddingWidgetState extends State<VariableAddingWidget> {
  String varName;
  int initialValue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.25,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ResponsiveTextField(
                lableText: "Name",
                validate: (text) {
                  varName = text;
                  return TextFieldState.VALID;
                },
                setMessage: (_, __) {
                  return null;
                }),
            ResponsiveTextField(
                lableText: "initial Value",
                validate: (text) {
                  initialValue = int.tryParse(text) ?? 0;
                  return TextFieldState.VALID;
                },
                setMessage: (_, __) {
                  return null;
                }),
            NeuButton(onPressed: () {
              if (_formKey.currentState.validate()) {
                widget.addVariable(varName, initialValue);
              }
            })
          ],
        ),
      ),
    );
  }
}
