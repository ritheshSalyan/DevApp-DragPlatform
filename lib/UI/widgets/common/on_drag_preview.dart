import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:neumorphic/neumorphic.dart';

class OnDragPrview extends StatelessWidget {
  final CustomWidget customWidget;

  const OnDragPrview({Key key, @required this.customWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 50,
      height: 80,
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
    );
  }
}
