import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/loading.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/auth/auth_service.dart';
import 'package:flutter_drag_and_drop/controller/auth/user_service.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

class SignInViewModel with ChangeNotifier {
  PageViewStates pageViewStates;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  SignInViewModel(this.pageViewStates);
  void swapView() {
    if (pageViewStates == PageViewStates.SIGN_IN) {
      pageViewStates = PageViewStates.SIGN_UP;
    } else {
      pageViewStates = PageViewStates.SIGN_IN;
    }
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    //Perform Signin Logic
    try {
      Loader.showOverlayLoading(context);
      await Provider.of<UserService>(context, listen: false).signIn(
          email: emailController.text, password: passwordController.text);
      // Navigator.of(context).push("route")
      Loader.hideOverlayLoading(context);

      moveToProjectList(context);
    } catch (e) {
      print("e $e");
      Loader.hideOverlayLoading(context);
      // showToast("$e",context: context);
      showToast(
        // Container(
        //   width: MediaQuery.of(context).size.width*0.5,
        //           child: Row(
        //     children: <Widget>[
        //       Icon(
        //         Icons.error,
        //         color: Colors.white,
        //       ),
        //       Flexible(
                            // child: Text(
                  "$e",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        context: context,

        // position: StyledToastPosition.bottom,
        backgroundColor: Colors.red,
        textStyle: TextStyle(color:Colors.white),
      animation: StyledToastAnimation.slideFromBottom,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
      duration: Duration(seconds:3)
      // reverseAnimation: StyledToastAnimation.slideToBottom,
      
      );
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      Loader.showOverlayLoading(context);

      await Provider.of<UserService>(context, listen: false).signUp(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      Loader.hideOverlayLoading(context);
      // Navigator.of(context).push("route")
      moveToProjectList(context);
    } catch (e) {
      print("e $e");
      Loader.hideOverlayLoading(context);
      // showToast("$e",context: context);
      showToast(
        // Container(
        //   width: MediaQuery.of(context).size.width*0.5,
        //           child: Row(
        //     children: <Widget>[
        //       Icon(
        //         Icons.error,
        //         color: Colors.white,
        //       ),
        //       Flexible(
                            // child: Text(
                  "$e",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        context: context,

        // position: StyledToastPosition.bottom,
        backgroundColor: Colors.red,
        textStyle: TextStyle(color:Colors.white),
      animation: StyledToastAnimation.slideFromBottom,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
      duration: Duration(seconds:3)
      // reverseAnimation: StyledToastAnimation.slideToBottom,
      
      );
    }
    moveToProjectList(context);
  }

  void moveToProjectList(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ProjectListPage(),
      ),
    );
  }

  TextFieldState passwordValidator(String data) {
    if (data.length < 6) {
      return TextFieldState.ERROR;
    }
    if (data.length < 8) {
      return TextFieldState.WARNING;
    }
    return TextFieldState.VALID;
  }

  String passwordSetMessage(textFieldState, data) {
    switch (textFieldState) {
      case TextFieldState.ERROR:
        return "Password must Contain minimum 6 charecters";
        break;
      case TextFieldState.WARNING:
        return "Password is Short";

        break;
      case TextFieldState.VALID:
        return null;
        break;
    }
    return null;
  }

  TextFieldState emailValidator(String data) {
    if (emailRegex.hasMatch(data)) {
      return TextFieldState.VALID;
    } else
      return TextFieldState.ERROR;
  }

  String emailSetMessage(textFieldState, data) {
    if (textFieldState == TextFieldState.ERROR) {
      return "Enter a Valid Email Address";
    }
    return null;
  }

  TextFieldState nameValidator(String data) {
    if (nameCharacters.hasMatch(data)) {
      return TextFieldState.VALID;
    } else
      return TextFieldState.ERROR;
  }

  String nameSetMessage(textFieldState, data) {
    if (textFieldState == TextFieldState.ERROR) {
      return "Enter a Valid Name";
    }
    return null;
  }
}
