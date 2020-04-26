import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

class TreeItemView extends StatelessWidget {
  final CustomWidget customWidget;

  const TreeItemView({Key key, this.customWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomContainer");
      customWidget.addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          leading: Container(
            color: green,
            padding: const EdgeInsets.all(2.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 30,
                minWidth: 25,
                maxHeight: 75,
                minHeight: 74,
              ),
              child: Container(
                color: neuBackground,
                padding: const EdgeInsets.all(2.0),
                child: customWidget.prevIcon(Size(50, 150)),
              ),
            ),
          ),
          title: Text(
            customWidget.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    });
  }
}
