import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/landing_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_checking.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/class_model_generator.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:flutter_drag_and_drop/instructionBuilder.dart';
import 'package:flutter_drag_and_drop/main.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:neumorphic/neumorphic.dart';

import 'models/project.dart';

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(
          "/",
          child: (_, args) => NeuTheme(
            isNeumorphicAppTheme: false,

            data: NeuThemeData(
              cardColor: neuBackground,
              primaryColor: green,
            ),
            child: //CodeBuilder(classModel: CustomClassModel("pageName"),)
               LandingPage(), //DragDrop(title: 'Flutter Demo Home Page'),// HomePage(),//
          ),
        ),
        Router(LOGIN_ROUTE,
            child: (_, args) => SigninChecking(
                  // pageViewStates: args.data,
                )),
        Router(PROJECT_ROUTE, child: (_, args) => ProjectListPage()),
        Router(BUILD_ROUTE,
            child: (_, args) => DragDrop(project: args.data,),//args.params['id'],)// 
            ),
      ];

  // add your main widget here
  @override
  Widget get bootstrap => MyApp();
}

const String LOGIN_ROUTE = "/login";
const String PROJECT_ROUTE = "/project";
const String BUILD_ROUTE = "/project/build";
