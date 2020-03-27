

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
  enum Gender { MALE, FEMALE, NON_BINARY }

class CustomNeumorpicRadio extends StatelessWidget {
  Gender gender;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Returnninf nscnlnlsvasv");
//  return   DropdownButtonFormField(items: <DropdownMenuItem>[
// DropdownMenuItem(child: Text("Center"),value:"1"),
//     ], onChanged: (value){

//     });
 return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Gender",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              // color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.MALE,
              child: Icon(Icons.account_box),
              onChanged: (value) =>"",//this.onChanged(value),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.FEMALE,
              child: Icon(Icons.pregnant_woman),
              onChanged: (value) =>"",// this.onChanged(value),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.NON_BINARY,
              child: Icon(Icons.supervised_user_circle),
              onChanged: (value) =>"",// this.onChanged(value),
            ),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
    // return Container(
    //   height: size.height*0.5,
    //   width: size.width*0.25,
    //   // child: Radio(value: 1, groupValue: "2", onChanged: (c){}),
    //   child: Column(
    //     children: <Widget>[
    //       NeumorphicRadio(
    //         groupValue: 1,
    //         value: 1,
    //         child: Text("data",style: TextStyle(color:Colors.red),),
    //         style: NeumorphicRadioStyle(
    //         shape:  NeumorphicShape.flat,//(borderRadius: BorderRadius.circular(size.aspectRatio*5), 
    //         ),
    //         onChanged: (value) {
              
    //         },
    //     // boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(size.aspectRatio*5),        
    //       // ),
    //     ),
    //      NeumorphicRadio(
    //         groupValue: 1,
    //         value: 2,
    //         child: Text("data3"),
    //         style: NeumorphicRadioStyle(
    //         shape:  NeumorphicShape.flat,//(borderRadius: BorderRadius.circular(size.aspectRatio*5), 
    //         ),
    //         onChanged: (value) {
              
    //         },
    //     // boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(size.aspectRatio*5),        
    //       // ),
    //     ),
    //      NeumorphicRadio(
    //         groupValue: 1,
    //         value: 3,
    //         child: Text("data2"),
    //         style: NeumorphicRadioStyle(
    //         shape:  NeumorphicShape.flat,//(borderRadius: BorderRadius.circular(size.aspectRatio*5), 
    //         ),
    //         onChanged: (value) {
              
    //         },
    //     // boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(size.aspectRatio*5),        
    //       // ),
    //     ),
    //     ],
    //   ),
    // );
  }
}