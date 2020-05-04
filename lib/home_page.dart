import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/side_tabbar.dart';
import 'package:flutter_drag_and_drop/UI/widgets/mobile.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/widget_Listing.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/scaffold.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class DragDrop extends StatefulWidget {
  DragDrop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  // CustomScaffoldWithAppbar val = CustomScaffoldWithAppbar();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print("Hello");
    return ChangeNotifierProvider<ControllerClass>(
      create: (_) => ControllerClass(),
      child: Scaffold(
        backgroundColor: neuBackground,
        body: ListView(
          children: <Widget>[
            NeuCard(
              color: neuBackground,
              height: size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NeuCard(
                    bevel: 10,

                    decoration: NeumorphicDecoration(
                        color: neuBackground,
                        borderRadius: BorderRadius.circular(radius)),
                    // borderRadius: radius,
                    // color:Colo neuBackground,
                    // color: Colors.white,
                    width: size.width * 0.3,
                    height: size.height,
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
                          style: NeumorphicStyle(color: neuBackground),
                          child: Text("Code"),
                          onClick: () {
                            // print(val.code);
                            cardKey.currentState.toggleCard();
                          },
                        ),
                        SizedBox(
                          height: size.shortestSide * 0.02,
                        ),
                        FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          front: MobileWidget(
                            size: size,
                          ),
                          back: Consumer<ControllerClass>(
                              builder: (context, snapshot, _) {
                            CustomWidget val =
                                snapshot.pages[snapshot.activePage].rootWidget;
                            return Container(
                              //depth: 25,
                              height: size.height*0.75,
                              width: size.width * 0.25,
                              child: ListView(
                                children: <Widget>[
                                  Text(val.code),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: size.shortestSide * 0.02,
                        ),
                      ],
                    ),
                  ),
                  NeuCard(
                    bevel: 10,
                    decoration: NeumorphicDecoration(
                      color: neuBackground,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          bottomLeft: Radius.circular(radius)),
                    ),
                    // customBorderRadius:
                    // borderRadius: radius,
                    // color: neuBackground,
                    width: size.width * 0.3,
                    child: RightWindow(
                      size: size,
                    ),
                  ),

                  // })
                ],
              ),
            ),
                    SizedBox(height: 25),

            Consumer<ControllerClass>(builder: (context, snapshot, _) {
              return NeuCard(
                alignment: Alignment.center,
                height: size.height * 0.1,
                color: neuBackground,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Current Page"),
                    SizedBox(width: 25),
                    DropdownButton<int>(
                        hint: Text(
                            "${snapshot.pages[snapshot.activePage].pageName}"),
                        // value: Te,
                        items: List<DropdownMenuItem<int>>.generate(
                            snapshot.pages.length + 1,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: index == snapshot.pages.length
                                    ? Text("Add New Page")
                                    : Text(
                                        "${snapshot.pages[index].pageName}"))),
                        onChanged: (int i) {
                          i == snapshot.pages.length
                              ? snapshot.addPage()
                              : snapshot.changePage(i);
                        })
                    // DropdownButton(
                    //   child: Text("${snapshot.pages[snapshot.activePage].pageName}"),
                    //   onPressed: (){

                    // }),
                  ],
                ),

                // ListView.builder(
                //     itemCount: snapshot.pages.length + 1,
                //     scrollDirection: Axis.horizontal,
                // itemBuilder: (context, i) => i == snapshot.pages.length
                //     ? RaisedButton(
                //       child: Text("Add"),
                //       onPressed: () {
                //         snapshot.addPage();
                //       })
                //         : RaisedButton(
                //             onPressed: () {
                //               snapshot.changePage(i);
                //             },
                //             child: Text("$i"))),
                //Text("data"),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class RightWindow extends StatefulWidget {
  const RightWindow({
    Key key,
    @required this.size,
    // @required this.val,
  }) : super(key: key);

  final Size size;
  // final CustomScaffoldWithAppbar val;

  @override
  _RightWindowState createState() => _RightWindowState();
}

class _RightWindowState extends State<RightWindow> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: getSelectedPage()),
        CustomTabbar(
          titles: [
            "Properties",
            "Widget Tree",
          ],
          onSelect: (i) {
            print("object $i");
            setState(() {
              selected = i;
            });
          },
        ),
      ],
    );
  }

  Widget getWidgetTree() {
    return SingleChildScrollView(
      child: Container(
        height: widget.size.height,
        child: Consumer<ControllerClass>(builder: (context, snapshot, _) {
          CustomWidget val = snapshot.pages[snapshot.activePage].rootWidget;
          return val.buildTree(context);
        }),
      ),
    );
  }

  Container getPropertiesWidget() {
    return Container(
      height: widget.size.height,
      alignment: Alignment.center,
      child: Consumer<ControllerClass>(builder: (context, snapshot, _) {
        return snapshot.properties(context);
      }),
    );
  }

  Widget getSelectedPage() {
    switch (selected) {
      case 0:
        return getPropertiesWidget();
      case 1:
        return getWidgetTree();

      default:
        return Container();
    }
  }
}
