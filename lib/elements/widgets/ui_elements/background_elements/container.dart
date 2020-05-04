import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/alignment_selector.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/width_height_selector.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:tree_view/tree_view.dart';

class CustomContainer with CustomWidget {
  CustomWidget child;
  double width = 1.0, height = 0.5;
  Color color = Colors.transparent;
  bool isSameRadius = true;
  AlignmentGeometry alignment = Alignment.topLeft;
  int elevation;
  int wrand, hrand;
  double tlRad = 0.0;
  double blRad = 0.0;
  double trRad = 0.0;
  double brRad = 0.0;

  TextEditingController tlcontroller = TextEditingController();
  TextEditingController trcontroller = TextEditingController();
  TextEditingController blcontroller = TextEditingController();
  TextEditingController brcontroller = TextEditingController();
  List<CustomBoxShadow> shadows = [];
  CustomContainer() {
    wrand = Random().nextInt(100);
    hrand = Random().nextInt(100);
  }
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    Size size = Provider.of<ControllerClass>(context, listen: false).size;
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomContainer");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Container(
        width: size.width * width,
        height: size.height * height,
        alignment: alignment,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(tlRad),
            topRight: Radius.circular(trRad),
            bottomLeft: Radius.circular(blRad),
            bottomRight: Radius.circular(brRad),
          ),
          boxShadow: List<BoxShadow>.generate(
              shadows.length, (index) => shadows[index].getShadow()),
        ),
        // Colors.red,
        child: child == null
            ? EmptyRepresenter(
                width: size.width * width,
                height: size.height * height) //Container()
            : child.build(
                context,
              ), //Text("data"),
      ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomContainer();
  }

  @override
  get name => "Container";

  @override
  Widget properties(BuildContext context) {
    print("Properitis called");

    return ListView(
      children: <Widget>[
        CustomColorPicker(
          color: color,
          lable: "Background Color",
          onSelected: (Color colorSelected) {
            this.color = colorSelected;
            super.properties(context);
          },
        ),
        WidthSelector(
            key: ValueKey(wrand),
            lable: "Width",
            initialValue: width,
            onChanged: (double newWidth) {
              width = newWidth;
              super.properties(context);
            }),
        WidthSelector(
            key: ValueKey(hrand),
            lable: "height",
            initialValue: height,
            onChanged: (double newHeight) {
              height = newHeight;
              print("Height:$height");
              super.properties(context);
            }),
        AlignmentSelector(
          onSelected: (AlignmentGeometry selectedAlignment) {
            alignment = selectedAlignment;
            print("Alignment Selected $alignment");
            super.properties(context);
          },
        ),
        NeumorphicTheme(
            theme: NeumorphicThemeData(
                depth: 5,
                accentColor: Colors.greenAccent[400], //green,
                variantColor: Colors.greenAccent, //  green,//.withAlpha(100),
                baseColor: neuBackground),
            child:
                // Column(
                // children: <Widget>[
                //     Text("Border radius"),
                Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Same Border radius"),
                    Container(
                      // width: 250,
                      height: 35,
                      child: NeumorphicSwitch(
                        height: 5,
                        value: isSameRadius,
                        duration: Duration(milliseconds: 250),
                        isEnabled: true,
                        style: NeumorphicSwitchStyle(
                            activeThumbColor: neuBackground,
                            activeTrackColor: green,
                            inactiveThumbColor: neuBackground,
                            inactiveTrackColor: neuBackground,
                            thumbDepth: 5,
                            trackDepth: 5,
                            thumbShape: NeumorphicShape.flat),
                        onChanged: (value) {
                          isSameRadius = value;
                          blcontroller.text = brcontroller.text =
                              trcontroller.text =
                                  tlcontroller.text = tlRad.toStringAsFixed(2);
                          brRad = blRad = trRad = tlRad;
                          super.properties(context);
                        },
                      ),
                    ),
                  ],
                ),
                // AnimatedSwitcher(duration: Duration(milliseconds: 250),child: 
                isSameRadius
                    ? Flexible(
                        child: NeuTextField(
                          controller: tlcontroller,
                          decoration: InputDecoration(hintText: "Radius"),
                          onChanged: (value) {
                            if (isNumeric(value)) {
                              brRad =
                                  blRad = trRad = tlRad = double.parse(value);

                              blcontroller.text =
                                  brcontroller.text = trcontroller.text = value;
                              super.properties(context);
                            }
                          },
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: NeuTextField(
                                    controller: tlcontroller,
                                    decoration:
                                        InputDecoration(hintText: "Top Left"),
                                    onChanged: (value) {
                                      if (isNumeric(value)) {
                                        tlRad = double.parse(value);
                                        super.properties(context);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: NeuTextField(
                                    controller: trcontroller,
                                    decoration:
                                        InputDecoration(hintText: "Top Right"),
                                    onChanged: (value) {
                                      if (isNumeric(value)) {
                                        trRad = double.parse(value);
                                        super.properties(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: NeuTextField(
                                    controller: blcontroller,
                                    decoration: InputDecoration(
                                        hintText: "Bottom Left"),
                                    onChanged: (value) {
                                      if (isNumeric(value)) {
                                        blRad = double.parse(value);
                                        super.properties(context);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: NeuTextField(
                                    controller: brcontroller,
                                    decoration: InputDecoration(
                                        hintText: "Bottom Right"),
                                    onChanged: (value) {
                                      if (isNumeric(value)) {
                                        brRad = double.parse(value);
                                        super.properties(context);
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),//)
              ],
            )

            //   ],
            // ),
            ),
        Container(
          child: Column(
            children: <Widget>[
              Text("Shadows "),
              shadows.isNotEmpty
                  ? Column(
                      children: List<Widget>.generate(
                        shadows.length,
                        (index) => shadows[index].propertiesWidget(
                          context,
                          () {
                            super.properties(context);
                          },
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 10),
              NeuButton(
                  decoration: NeumorphicDecoration(
                    color: neuBackground,
                  ),
                  child: Icon(Icons.add, color: green),
                  onPressed: () {
                    shadows.add(CustomBoxShadow());
                    super.properties(context);
                  }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement code
  String get code => ''' Container(
    ${child != null ? "child :" + child.code + "," : ""}
  )\n''';

  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox(width: 0, height: 0),
        title: TreeItemView(customWidget: this), // Text("Container"),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children:

            // child == null
            //     ? ChildList()
            //     : ChildList(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children:
            child != null
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02),
                      child: child?.buildTree(context),
                    ),
                  ]
                : [],
        // ),
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Container(
      color: color == Colors.transparent ? green : color,
      width: constraints.width * 0.9,
      height: constraints.height * 0.9,
    );
  }
}

class CustomBoxShadow {
  int blurRadius = 1;
  int x = 0;
  int y = 0;
  Color color = Colors.black12;

  BoxShadow getShadow() {
    return BoxShadow(
        offset: Offset(x.toDouble(), y.toDouble()),
        blurRadius: blurRadius.toDouble(),
        color: color);
  }

  Widget propertiesWidget(BuildContext context, void Function() refresh) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: NeuCard(
        color: neuBackground,
        curveType: CurveType.flat,
        child: Column(
          children: <Widget>[
            Text(" Same Border radius"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(" Blur radius"),
                Counter(
                  initialValue: blurRadius,
                  minValue: 0,
                  maxValue: 1000,
                  step: 1,
                  decimalPlaces: 1,
                  onChanged: (value) {
                    // get the latest value from here

                    blurRadius = value;
                    // super.properties(context);
                    refresh();
                  },
                ),
              ],
            ),
            Text("Offset"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" X Offset "),
                    Counter(
                      initialValue: x,
                      minValue: -1000,
                      maxValue: 1000,
                      step: 1,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        // get the latest value from here

                        x = value;
                        refresh();
                        // super.properties(context);
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Y Offset "),
                    Counter(
                      initialValue: y,
                      minValue: -1000,
                      maxValue: 1000,
                      step: 1,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        // get the latest value from here

                        y = value;
                        refresh();
                        // super.properties(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
            CustomColorPicker(
              color: color,
              lable: "Shadow Color",
              onSelected: (Color colorSelected) {
                this.color = colorSelected;
                refresh();
                // super.properties(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
