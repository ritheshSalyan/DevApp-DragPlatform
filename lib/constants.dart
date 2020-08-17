import 'package:flutter/material.dart';

Color neuBackground = Color(
    0xFFFAFAFA); // Color(0x0E0E0E);// Color(0xFF0E0E0E);//Colors.grey[900];//Color(0x0E0E0E);//Colors.grey[100];// Colors.grey[900];//
Color green = Colors.greenAccent; //Color(0xFF00FF73);
double radius = 25;
Color textColor = Colors.black;

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(
        s,
      ) !=
      null;
}

//validators
final alphaNumericCharacters = RegExp(r'^[a-zA-Z0-9]+$');
final nameCharacters = RegExp(r'^[a-zA-Z ]+$');
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//
Map<FontWeight, String> fontWeightMap = {
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

//Common Fields
const CREATED_AT = "created_at";
const UPDATED_AT = "updated_at";
const IS_ACTIVE = "is_active";

//User Model
const USER_NAME = "name";
const USER_ID = "uid";
const USER_EMAIL = "email";

//Project Model
const PROJECT_NAME = "project_name";
const PROJECT_ID = "id";

const PAGES_NAME = "page_name";
const PAGES_ID = "page_id";
const PAGES_WIDGET_TREE = "widget_tree";
const PAGES_FUNCTION_TREE = "class_model";
