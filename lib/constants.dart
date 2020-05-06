import 'package:flutter/material.dart';

Color neuBackground =  Color(0xFFF2F2F2);// Color(0x0E0E0E);// Color(0xFF0E0E0E);//Colors.grey[900];//Color(0x0E0E0E);//Colors.grey[100];// Colors.grey[900];//
Color green = Color(0xFF00FF73);
double radius = 25;
Color textColor = Colors.black;

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.tryParse(s,) != null;
}

Map<FontWeight,String> fontWeightMap = {
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
};

const String CHILD = "child";
const String NAME = "name";
const String PROPERTIES = "properties";