import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/UI/widgets/mobile.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/button.dart';
import 'package:flutter_drag_and_drop/elements/widgets/card.dart';
import 'package:flutter_drag_and_drop/elements/widgets/center.dart';
import 'package:flutter_drag_and_drop/elements/widgets/column.dart';
import 'package:flutter_drag_and_drop/elements/widgets/container.dart';
import 'package:flutter_drag_and_drop/elements/widgets/row.dart';
import 'package:flutter_drag_and_drop/elements/widgets/scaffold.dart';
import 'package:flutter_drag_and_drop/elements/widgets/text.dart';
import 'package:provider/provider.dart';

class DragDrop extends StatefulWidget {
  DragDrop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  CustomScaffold val = CustomScaffold();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ControllerClass>(
      create: (_) => ControllerClass(),
      child: Scaffold(
        backgroundColor: neuBackground,
        body: ClayContainer(
          color: neuBackground,
          height: size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClayContainer(
                borderRadius: radius,
                color: neuBackground,
                width: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Wrap(children: <Widget>[
                    Draggable<CustomWidget>(
                      data: CustomContainer(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomContainer"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomContainer"),
                        ),
                      ),
                    ),
                    Draggable<CustomWidget>(
                      data: CustomScaffold(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomScaffold"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomScaffold"),
                        ),
                      ),
                    ),
                    Draggable<CustomWidget>(
                      data: CustomButton(),
                      child: Container(
                        color: Colors.green,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomButton"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.red,
                          child: Text("CustomButton"),
                        ),
                      ),
                    ),
                    Draggable<CustomWidget>(
                      data: CustomText(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomText"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomText"),
                        ),
                      ),
                    ),
                    Draggable<CustomWidget>(
                      data: CustomColumn(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomColumn"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomColumn"),
                        ),
                      ),
                    ),
                    Draggable<CustomWidget>(
                      data: CustomRow(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomRow"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomRow"),
                        ),
                      ),
                    ),
                     Draggable<CustomWidget>(
                      data: CustomCard(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomCard"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomCard"),
                        ),
                      ),
                    ),
                       Draggable<CustomWidget>(
                      data: CustomCenter(),
                      child: Container(
                        color: Colors.orange,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        child: Text("CustomCenter"),
                      ),
                      feedback: Material(
                        child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          color: Colors.orange,
                          child: Text("CustomCenter"),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    // bottom: size.height * 0.05,
                    right: size.width * 0.1),
                child: MobileWidget(size: size, val: val),
              ),
              // }) 
            ],
          ),
        ),
      ),
    );
  }
}
