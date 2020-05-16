import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:provider/provider.dart';

class WidgetSelection extends StatelessWidget {
 final Widget child;
CustomWidget customWidget;
   WidgetSelection({Key key,@required this.child,@required  this.customWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ControllerClass>(context,listen: false).updateChild(customWidget);
      },
      child: child,
      
    );
  }
}