import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/responsive_textfield.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/constants.dart';
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
  String getClassName() {
    String classname = pageName.substring(0, 1).toUpperCase() +
        pageName.substring(1).toLowerCase() +
        "ViewModel";
    return classname;
  }

  String get code => '''
import 'package:flutter/foundation.dart';

class ${getClassName()} with with ChangeNotifier {
  ${decarationCodeGeneration()}

  ${functionCodeGeneration()}
}
   ''';
  String decarationCodeGeneration() {
    String code = "";
    for (var item in globalVariables) {
      code += "${item.type} ${item.name} = ${item.initialValue} ;";
    }
    return code;
  }

  String functionCodeGeneration() {
    String fcode = "";
    for (var item in functions) {
      fcode += item.code + "\n\n";
    }
    return fcode;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NeuCard(
      curveType: CurveType.emboss,
      color: neuBackground,
      child: DragTarget<CustomFunction>(
        onAccept: (data) {
          functions.add(data.copy("function${functions.length}"));
        },
        builder: (BuildContext context, List<CustomFunction> candidateData,
            List<dynamic> rejectedData) {
          return Stack(
            // itemCount: functions.length,
            // itemBuilder: (context, i) =>
            children: List<Widget>.from(
              functions.map(
                (f) => f.build(
                  context,
                ),
              ),
            ),
          );
        },
      ),
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
      height: MediaQuery.of(context).size.height * 0.25,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ResponsiveTextField(
              lableText: "Name",
              validate: (text) {
                varName = text;
                if (RegExp(r'^[a-z][a-zA-Z_0-9]*$').hasMatch(text)) {
                  varName = text;
                  return TextFieldState.VALID;
                }
                return TextFieldState.ERROR;
              },
              setMessage: (TextFieldState fieldState, text) {
                if (fieldState == TextFieldState.VALID) {
                  return null;
                }

                return "Variable name can contain alpha Numeric character";
              },
            ),
            ResponsiveTextField(
                lableText: "initial Value",
                validate: (text) {
                  initialValue = int.tryParse(text) ?? 0;
                  return TextFieldState.VALID;
                },
                setMessage: (_, __) {
                  return null;
                }),
            NeuButton(
                child: Text("Create Variable",
                    style: TextStyle(color: Colors.black)),
                decoration: NeumorphicDecoration(
                  color: neuBackground,
                ),
                onPressed: () {
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
