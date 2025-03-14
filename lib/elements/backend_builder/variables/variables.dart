import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';

class CustomGlobalVariable with CustomVariables {
  String variableName;
  int variableValue;
  int initalValue;
  dynamic variableType;
  CustomGlobalVariable(this.variableName,
      {this.variableValue = 0, this.variableType}) {
    initalValue = variableValue;
  }
  @override
  String get name => variableName;

  @override
  get type => int;

  @override
  get value => variableValue;

  @override
  Widget build(BuildContext context) {
    return Text("$variableName");
  }

  @override
  void set value(dynamic nvalue) {
    variableValue = nvalue;
  }

  @override
  // TODO: implement initialValue
  get initialValue => initalValue;

  @override
  Map<String, dynamic> toJson() {
    return {
      "variableName": variableName,
      "value": value,
    };
  }

  @override
   fromJson(Map<String, dynamic> json) {
    variableName = json["variableName"];
    value = json["value"];

  }
}

class CustomConstInt with CustomVariables {
  String variableName;
  int variableValue;

  CustomConstInt({this.variableValue = 0});
  @override
  String get name => "$variableValue";

  @override
  get type => CONST_PREFIX;

  @override
  get value => variableValue;

  @override
  CustomConstInt copy() {
    return CustomConstInt(variableValue: variableValue);
  }

  @override
  Widget build(BuildContext context) {
    return Text("$variableValue");
  }

  @override
  void set value(dynamic nvalue) {
    //  variableValue = nvalue;
  }

  @override
  // TODO: implement initialValue
  get initialValue => variableValue;

  @override
  Map<String, dynamic> toJson() {
    return {
      "variableName": variableName,
      "value": value,
    };
  }
   @override
   fromJson(Map<String, dynamic> json) {
    variableName = json["variableName"];
    value = json["value"];

  }
}
