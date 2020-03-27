import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatelessWidget {
  CustomColorPicker({this.color = Colors.black, @required this.onSelected,this.lable});
  Color color;
  String lable;

  Function(Color) onSelected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(lable??"Choose Color"),
        RaisedButton(
            color: color,
            onPressed: () {
              print("Color picker Displaying");
              showDialog(
                context: context,
                child: AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: color,
                      onColorChanged: (value) {
                        color = value;
                      },
                      showLabel: true,
                      pickerAreaHeightPercent: 0.8,
                    ),
                    // Use Material color picker:
                    //
                    // child: MaterialPicker(
                    //   pickerColor: pickerColor,
                    //   onColorChanged: changeColor,
                    //   showLabel: true, // only on portrait mode
                    // ),
                    
                    // Use Block color picker:
                    //
                    // child: BlockPicker(
                    //   pickerColor: currentColor,
                    //   onColorChanged: changeColor,
                    // ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (onSelected != null) {
                            onSelected(color);
                          }
                        },
                        child: Text("Select")),
                  ],
                ),
              );
            })
      ],
    );
  }
}
