import 'package:animated_neumorphic/animated_neumorphic.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/UI/widgets/mobile.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/appbar_widgets/custom_appbar.dart';
import 'package:flutter_drag_and_drop/elements/widgets/button.dart';
import 'package:flutter_drag_and_drop/elements/widgets/card.dart';
import 'package:flutter_drag_and_drop/elements/widgets/center.dart';
import 'package:flutter_drag_and_drop/elements/widgets/column.dart';
import 'package:flutter_drag_and_drop/elements/widgets/container.dart';
import 'package:flutter_drag_and_drop/elements/widgets/custom_fab.dart';
import 'package:flutter_drag_and_drop/elements/widgets/row.dart';
import 'package:flutter_drag_and_drop/elements/widgets/scaffold.dart';
import 'package:flutter_drag_and_drop/elements/widgets/text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class DragDrop extends StatefulWidget {
  DragDrop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  CustomScaffold val = CustomScaffold();
GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Hello");
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
                width: size.width * 0.25,
                child: WidgetWindow(size: size),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  // bottom: size.height * 0.05,
                ),
                child: Column(
                  children: <Widget>[
                    NeumorphicButton(
                      minDistance: 3,
                      style:NeumorphicStyle(color:neuBackground),
                        child: Text("Code"),
                        onClick: () {
                          print(val.code);
                           cardKey.currentState.toggleCard();
                        },
                    ),
                    SizedBox(
                      height:size.shortestSide*0.02,
                    ),
                    FlipCard(
                      key: cardKey,
                      flipOnTouch: false,
                      front: MobileWidget(size: size, val: val),
                      back: Consumer<ControllerClass>(
              builder: (context, snapshot, _) {
                        
                          return Container(//depth: 25,
                          child: Text(val.code),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              ClayContainer(
                customBorderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius)),
                // borderRadius: radius,
                color: neuBackground,
                width: size.width * 0.3,
                child:
                    Consumer<ControllerClass>(builder: (context, snapshot, _) {
                  return snapshot.properties(context);
                }),
              ),

              // })
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetWindow extends StatelessWidget {
  const WidgetWindow({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        Draggable<CustomAppBarWidget>(
          data: CustomAppbar(),
          child: Container(
            color: Colors.orange,
            width: size.width * 0.1,
            height: size.width * 0.1,
            child: Text("CustomAppbar"),
          ),
          feedback: Material(
            child: Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              color: Colors.orange,
              child: Text("CustomAppbar"),
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
          data: CustomFAB(),
          child: Container(
            color: Colors.green,
            width: size.width * 0.1,
            height: size.width * 0.1,
            child: Text("CustomFAB"),
          ),
          feedback: Material(
            child: Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              color: Colors.red,
              child: Text("CustomFAB"),
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
    );
  }
}
