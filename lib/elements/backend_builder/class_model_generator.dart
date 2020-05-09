
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

class CustomClassModel {
  String pageName;
  CustomClassModel(this.pageName) {
    functions = [];
  }
  List<CustomFunction> functions;
  List<CustomVariables> globalVariables;

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
                  height: size.height*0.5, //* 0.75,
                  color: Colors.blue,
                  child: ListView.builder(
                      itemCount: functions.length,
                      itemBuilder: (context, i) => functions[i].build(
                            context,
                          )),
                ),
              RaisedButton(onPressed: (){
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
}