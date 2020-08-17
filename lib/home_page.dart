import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/side_tabbar.dart';
import 'package:flutter_drag_and_drop/UI/widgets/mobile.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/widget_Listing.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/instructionBuilder.dart';
import 'package:flutter_drag_and_drop/models/project.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:neumorphic/neumorphic.dart' as p;
import 'package:provider/provider.dart';

class DragDrop extends StatefulWidget {
  // StatefulWidget {
  DragDrop({Key key, this.project}); // : super(key: key);

  final Project project;

  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Project project;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print("Hello");
    return ChangeNotifierProvider<ControllerClass>(
      create: (_) => ControllerClass(project.id),
      child: Scaffold(
        backgroundColor: neuBackground,
        // appBar:
        body: ListView(
          controller: ScrollController(),
          children: <Widget>[
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(widget.project.projectName ?? "",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black) //TextStyle(color: Colors.black),
                  ),
              actions: <Widget>[
                Consumer<ControllerClass>(builder: (context, snapshot, _) {
                  return IconButton(
                    icon: Icon(AntDesign.save),
                    onPressed: () {
                      print("Called Save Icon Press");
                      // Provider.of<ControllerClass>(context, listen: false)
                      snapshot.save(context);
                    },
                  );
                }),
                Consumer<ControllerClass>(builder: (context, snapshot, _) {
                  return snapshot.isUI
                      ? p.NeuButton(
                          decoration: p.NeumorphicDecoration(
                            color: neuBackground,
                          ),
                          child: Text(
                            "Block",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            // print("Called Save Icon Press");
                            // Provider.of<ControllerClass>(context, listen: false)
                            snapshot.isUI = false;
                            snapshot.notify();
                            //save(context);
                          })
                      : p.NeuButton(
                          decoration: p.NeumorphicDecoration(
                            color: neuBackground,
                          ),
                          child: Text("UI",
                              style: Theme.of(context).textTheme.headline6),
                          onPressed: () {
                            // print("Called Save Icon Press");
                            // Provider.of<ControllerClass>(context, listen: false)
                            snapshot.isUI = true;
                            snapshot.notify();
                            //save(context);
                          });
                })
              ],
            ),
            Consumer<ControllerClass>(builder: (context, snapshot, _) {
              return snapshot.isUI
                  ? UIGeneration(size: size, cardKey: cardKey)
                  : Container(
                      height: size.height,
                      child: CodeBuilder(
                          classModel:
                              snapshot.pages[snapshot.activePage].classModel),
                    );
            }),
            SizedBox(height: 25),
            Consumer<ControllerClass>(builder: (context, snapshot, _) {
              return p.NeuCard(
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

class UIGeneration extends StatelessWidget {
  const UIGeneration({
    Key key,
    @required this.size,
    @required this.cardKey,
  }) : super(key: key);

  final Size size;
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    return p.NeuCard(
      color: neuBackground,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          p.NeuCard(
            bevel: 10,

            decoration: p.NeumorphicDecoration(
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
                    // print("@@@@@@@@@@@@@@@@ ${snapshot.pages.length} ");
                    CustomWidget val =
                        snapshot.pages[snapshot.activePage].widgetTree;
                    // print(val.toJson().toString());
                    return Container(
                      //depth: 25,
                      height: size.height * 0.75,
                      width: size.width * 0.25,
                      child: ListView(
                        controller: ScrollController(),
                        children: <Widget>[
                          p.NeuButton(
                              decoration:
                                  p.NeumorphicDecoration(color: neuBackground),
                              child: Text("Copy"),
                              onPressed: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: val.code));
                                showToast("Code copied Successfull",
                            context: context,
                                    backgroundColor: Colors.green,
                                    textStyle: TextStyle(color: Colors.white),
                                    animation:
                                        StyledToastAnimation.slideFromBottom,
                                    curve: Curves.elasticOut,
                                    reverseCurve: Curves.elasticIn,
                                    duration: Duration(seconds: 3));
                              }),
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
          p.NeuCard(
            bevel: 10,
            decoration: p.NeumorphicDecoration(
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
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: getSelectedPage()),
        ),
        CustomTabbar(
          titles: [
            "Properties",
            "Widget Tree",
          ],
          onSelect: (i) {
            // print("object $i");
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
        // height: widget.size.height,
        // width: widget.size.height,
        child: Consumer<ControllerClass>(builder: (context, snapshot, _) {
          CustomWidget val = snapshot.pages[snapshot.activePage].widgetTree;
          return val.buildTree(context);
        }),
      ),
    );
  }

  Container getPropertiesWidget() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: widget.size.height,
      alignment: Alignment.center,
      child: Consumer<ControllerClass>(builder: (context, snapshot, _) {
        // print("INSIDE HERE ${snapshot == null} ");
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
