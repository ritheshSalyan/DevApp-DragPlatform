import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';

class SignInViewModel with ChangeNotifier {
  PageViewStates pageViewStates;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  SignInViewModel(this.pageViewStates);
  void swapView() {
    if (pageViewStates == PageViewStates.SIGN_IN) {
      pageViewStates = PageViewStates.SIGN_UP;
    } else {
      pageViewStates = PageViewStates.SIGN_IN;
    }
    notifyListeners();
  }

  void signIn(BuildContext context) {
    //Perform Signin Logic

    // Navigator.of(context).push("route")
    moveToProjectList(context);
  }

  void signUp(BuildContext context) {
    //Perform SignUp Logic

    moveToProjectList(context);
  }

  void moveToProjectList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ProjectListPage(),
    ));
  }
}
