import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/home.dart';
import 'package:flutter_drag_and_drop/UI/landing_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/auth/user_service.dart';
import 'package:flutter_drag_and_drop/controller/project/project_service.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:flutter_drag_and_drop/instructionBuilder.dart';
import 'package:flutter_drag_and_drop/roure.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());
void main() => runApp(ModularApp(module: AppModule()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(
          create: (context) => UserService(),
        ),
        Provider<ProjectService>(
          create: (context) => ProjectService(),
        ),
      ],
      child: MaterialApp(
          title: 'Build It',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            // primaryTextTheme: TextTheme(
            //   headline1: TextStyle(color:textColor)
            //   textTheme:GoogleFonts
            // ),
            brightness: Brightness.light,
            primarySwatch: Colors.green, // green, //Colors.blue,
          ),
          initialRoute: "/",
          // add Modular to manage the routing system
          onGenerateRoute: Modular.generateRoute,//generateRoute //
          // home: NeuTheme(
          //   isNeumorphicAppTheme: false,

          //   data: NeuThemeData(
          //     cardColor: neuBackground,
          //     primaryColor: green,
          //   ),
          //   child://CodeBuilder()
          //       LandingPage(), //DragDrop(title: 'Flutter Demo Home Page'),// HomePage(),//
          // ),
          ),
    );
  }

  // Route generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/":
  //       return MaterialPageRoute(builder: (_) => LandingPage());
  //       break;
  //     case LOGIN_ROUTE:
  //       return MaterialPageRoute(
  //           builder: (_) => SignInPage(
  //                 pageViewStates: settings.arguments,
  //               ));
  //       break;
  //     case PROJECT_ROUTE:
  //       return MaterialPageRoute(builder: (_) => ProjectListPage());
  //       break;
  //     case BUILD_ROUTE:
  //       return MaterialPageRoute(
  //           builder: (_) => DragDrop(
  //                 project: settings.arguments,
  //               ));
  //       break;
  //     default:
  //       return MaterialPageRoute(builder: (_) => LandingPage());
  //   }
  // }
}
