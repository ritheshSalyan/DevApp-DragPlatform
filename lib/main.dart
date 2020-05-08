import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/home.dart';
import 'package:flutter_drag_and_drop/UI/landing_page.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/project_list_page.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/auth/user_service.dart';
import 'package:flutter_drag_and_drop/controller/project/project_service.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserService>(
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
        home: NeuTheme(
          isNeumorphicAppTheme: false,

          data: NeuThemeData(
            cardColor: neuBackground,
            primaryColor: green,
          ),
          child:
              LandingPage(), //DragDrop(title: 'Flutter Demo Home Page'),// HomePage(),//
        ),
      ),
    );
  }
}
