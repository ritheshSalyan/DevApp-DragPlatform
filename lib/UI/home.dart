import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:neumorphic/neumorphic.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: neuBackground,
      //  appBar: NeuAppBar(
      //           title: Text("data"),

      //         ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClayContainer(
            borderRadius: radius,
            height: size.height * 0.98,

            customBorderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            width: size.width * 0.48,
            surfaceColor: neuBackground,
            parentColor: neuBackground,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ClayContainer(
                      // emboss: true,
                      customBorderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      height: size.height * 0.75,
                      width: size.width * 0.25,
                      parentColor: neuBackground,
                      surfaceColor: neuBackground,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, i) => Text(i.toString(),
                                  style: TextStyle(color: Colors.red))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ClayContainer(
            width: size.width * 0.48,
            surfaceColor: neuBackground,
            parentColor: neuBackground,
          ),
        ],
      ),
    );
  }
}
