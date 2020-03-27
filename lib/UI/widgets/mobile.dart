import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileWidget extends StatelessWidget {
  const MobileWidget({
    Key key,
    @required this.size,
    @required this.val,
  }) : super(key: key);

  final Size size;
  final CustomScaffold val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.shortestSide * 0.01),
      child: ClayContainer(
        // height: size.height * 0.8,
        color: neuBackground,
        width: size.width * 0.25,

        borderRadius: radius,

        // child: Container(
        //   height: size.height*0.5,
        //   width: size.width*0.4,
        //   color: Colors.deepOrange,
        //   child: Text("data"),
        // ),
        child: ScreenTypeLayout(
          mobile: PreferredSize(
            preferredSize: Size(size.width * 0.25, size.height * 0.8),
            child: ResponsiveBuilder(builder: (context, sizeingInfo) {
              return Consumer<ControllerClass>(builder: (context, snapshot, _) {
                snapshot.sizingInformation = sizeingInfo;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClayContainer(
                          emboss: true,
                          spread: 2,
                          color: neuBackground,
                          borderRadius: radius,
                          width: size.width * 0.06,
                          height: radius / 2,
                        ),
                        SizedBox(
                          height: radius * 2,
                          width: 10,
                        ),
                        ClayContainer(
                          emboss: true,
                          // depth: 5,
                          spread: 2,
                          color: neuBackground,
                          borderRadius: radius,
                          width: radius / 2,
                          height: radius / 2,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 8.0, top: 10.0, bottom: 8.0),
                      child: ClayContainer(
                          emboss: true,
                          // borderRadius: radius,
                          spread: 2,
                          color: neuBackground,
                          height: size.longestSide * 0.39,
                          width: size.width * 0.25,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.0, right: 4.0),
                            child: val.build(context),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.menu,
                          color: green,
                        ),
                        Icon(
                          Icons.crop_square,
                          color: green,
                        ),
                        Icon(
                          Icons.navigate_before,
                          color: green,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
