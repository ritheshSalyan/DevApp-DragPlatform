import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/home.dart';
import 'package:flutter_drag_and_drop/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home:DragDrop(title: 'Flutter Demo Home Page'),// HomePage(),//
    );
  }
}
