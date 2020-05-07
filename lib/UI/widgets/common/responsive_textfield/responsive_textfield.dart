
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'responsive_text_controller.dart';
import 'textfield_enums.dart' as enums;

class ResponsiveTextField extends StatelessWidget {
  final int maxLines;

  TextInputType keyboardType;

  bool maxLengthEnforced;

  int maxLength;

  ResponsiveTextField(
      {Key key,
      @required this.validate,
      @required this.setMessage,
      this.controller,
      this.lableText,
      this.keyboardType,
      this.initialValue,
      this.leadingIcon,
      this.enabled = true,
      this.maxLength,
      this.maxLengthEnforced = false,
      
      this.maxLines
      })
      : super(key: key);
 final enums.TextFieldState Function(String text) validate;
 final String Function(enums.TextFieldState state, String text) setMessage;
 final String lableText;
 final TextEditingController controller;
 final String initialValue;
 final Icon leadingIcon;
 final bool enabled;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TextFieldValidation>(
      create: (context) =>
          TextFieldValidation(validate: validate, setMessage: setMessage),
      child: Consumer<TextFieldValidation>(
        builder: (context, validator, _) {
          return TextFormField(
            key: validator.textFieldKey,
            keyboardType: keyboardType,
              maxLines: maxLines,
              maxLengthEnforced: maxLengthEnforced,
              maxLength: maxLength,
              enabled: enabled ,
            initialValue: initialValue,
              controller: controller,
              validator: (text) {
                validator.updateText(text);
                enums.TextFieldState state = validate(text);
                print("From Validator ${validator.errorText}");
                if (state == enums.TextFieldState.VALID) {
                  return null;
                } else {
                  return validator.errorText;//setMessage(state, text);
                }
              },
              onChanged: (String text) {
                validator.updateText(text);

              },
              decoration: InputDecoration(
                icon: leadingIcon,
               
                labelText: lableText == null ? "" : lableText,
                errorText: validator.errorText,
                errorStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: validator.errorColor),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:validator.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: validator.errorColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: validator.errorColor),
                ),
                
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:  validator.errorColor),
                ),
              ),
            );
        },
      ),
    );

  }
}



