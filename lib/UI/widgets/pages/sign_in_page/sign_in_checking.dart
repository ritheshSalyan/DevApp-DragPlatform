import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/loading.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter_drag_and_drop/controller/auth/auth_service.dart';
import 'package:flutter_drag_and_drop/controller/auth/user_service.dart';
import 'package:provider/provider.dart';

class SigninChecking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, UserService value, _) {
        if (value.silentLoginTried && value.user == null) {
          return SignInPage(
            pageViewStates: PageViewStates.SIGN_UP,
          );
        }
        if (value.silentLoginTried && value.user != null) {
          return ProjectListPage();
        }
        //  else
         return Scaffold(
            body: Center(
             child: Loader.loading(context),
            ),
          );
      },
    );
  }
}
