import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:neumorphic/neumorphic.dart';

class DragWidgetPrview extends StatelessWidget {
  final CustomWidget customWidget;

  const DragWidgetPrview({Key key, @required this.customWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: NeuCard(
        curveType: CurveType.flat,
        // width: size.width * 0.1,
        // height: size.width * 0.1,
        bevel: 10,
        color: neuBackground,
        decoration: NeumorphicDecoration(
        color: neuBackground,
          
          borderRadius: BorderRadius.circular(25)
        ),
        child: Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(25),
          color: neuBackground,

          ),
          child: Column(
            children: <Widget>[SizedBox(height: 10),
              Container(
                color: green,
                padding: const EdgeInsets.all(2.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 40,
                    minWidth: 35,
                    maxHeight: 75,
                    minHeight: 74,
                  ),
                  child: Container(
                    color: neuBackground,
                    padding: const EdgeInsets.all(2.0),
                    child: customWidget.prevIcon(Size(40, 75)),
                  ),
                ),
              ),
              Text(
                customWidget.name,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
