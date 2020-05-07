import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'textfield_enums.dart' as enums;

class TextFieldValidation with ChangeNotifier {
  final textFieldKey = GlobalKey<FormFieldState>();
  String text = "";
  enums.TextFieldState errorStatus;
  Color errorColor = Colors.grey;
  String errorText;
  enums.TextFieldState Function(String text) validate;
  String Function(enums.TextFieldState state, String text) setMessage;

  TextFieldValidation({@required this.validate, @required this.setMessage});
  void updateText(String data) {
    text = data;

    if (validate != null) {
      errorStatus = validate(text);
    }
    if (setMessage != null) {
      errorText = setMessage(errorStatus, text);
      if (errorStatus == enums.TextFieldState.ERROR) {
        errorColor = Colors.red;
      } else if (errorStatus == enums.TextFieldState.WARNING) {
        errorColor = Colors.orangeAccent;
      } else {
        errorColor = Colors.greenAccent;
      }
    }
    print(errorText);
    // updateError();
    notifyListeners();
  }
}
