import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/home.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        // primaryTextTheme: TextTheme(
        //   headline1: TextStyle(color:textColor)
        //   textTheme:GoogleFonts
        // ),
          brightness: Brightness.light,
        primarySwatch:Colors.green,// green, //Colors.blue,

      ),
      home:DragDrop(title: 'Flutter Demo Home Page'),// HomePage(),//
    );
  }
}
