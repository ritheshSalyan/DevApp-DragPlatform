import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class CustomColorPicker extends StatelessWidget {
  CustomColorPicker({this.color = Colors.black, @required this.onSelected});
  Color color;

  Function(Color) onSelected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Text("The Lable"),
        RaisedButton(
            color: color,
            onPressed: () {
              print("Color picker Displaying");
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Select Color"),
                  content: Container(
                    width:size.shortestSide*0.25,
                    height: size.shortestSide*0.25,
                    child: CircleColorPicker(
                      initialColor: color,
                      onChanged: (value) {
                        color = value;
                      },
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          
                          Navigator.pop(context);
                          if(onSelected!=null){
                            onSelected(color);
                          }
                        },
                        child: Text("Select"))
                  ],
                ),
              );
            })
      ],
    );
  }
}
