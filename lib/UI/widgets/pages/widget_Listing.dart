import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/drag_widget_preview.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/on_drag_preview.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/side_tabbar.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/appbar_widgets/custom_appbar.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/column.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/row.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/scrolling/listview.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/card.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/container.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/scaffold.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/buttons/button.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/display_elements/text.dart';

class WidgetWindow extends StatefulWidget {
  const WidgetWindow({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _WidgetWindowState createState() => _WidgetWindowState();
}

class _WidgetWindowState extends State<WidgetWindow> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTabbar(
          titles: ["Background", "Layout", "Elements", "Appbar"],
          onSelect: (i) {
            // print("object $i");
            setState(() {
              selected = i;
            });
          },
        ),
        // Spacer(),
        // AnimatedSwitcher(
        //   duration: Duration(
        //     milliseconds: 250,
        //   ),
        //   child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getWidgetList(selected),
        ),
        // ),
      ],
    );
  }

  Widget getWidgetList(int selected) {
    List<Widget> widgets = [];
    switch (selected) {
      case 0:
        widgets = getBackgroundWidgets();
        break;
      case 1:
        widgets = getLayoutWidgets();
        break;
      case 2:
        widgets = getElemetsWidgets();
        break;
      case 3:
        widgets = getAppbarWidgets();
        break;
      default:
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: ListView(
        children: widgets,
      ),
    );
  }

  List<Widget> getAppbarWidgets() {
    return [
      // Draggable<CustomAppBarWidget>(
      //   data: CustomAppbar(),
      //   child: DragWidgetPrview(
      //     customWidget: CustomAppbar(),
      //   ),
      //   feedback: Material(
      //     child: Container(
      //       width: widget.size.width * 0.1,
      //       height: widget.size.width * 0.1,
      //       color: Colors.orange,
      //       child: Text("CustomAppbar"),
      //     ),
      //   ),
      // )
    ];
  }

  List<Widget> getBackgroundWidgets() {
    return [
      Draggable<CustomWidget>(
        data: CustomCard(),
        child: DragWidgetPrview(
          customWidget: CustomCard(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomCard"),
          ),
        ),
      ),
      Draggable<CustomWidget>(
        data: CustomScaffoldWithAppbar(),
        child: DragWidgetPrview(
          customWidget: CustomScaffoldWithAppbar(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomScaffold"),
          ),
        ),
      ),
      Draggable<CustomWidget>(
        data: CustomContainer(),
        child: DragWidgetPrview(
          customWidget: CustomContainer(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomContainer"),
          ),
        ),
      ),
    ];
  }

  List<Widget> getLayoutWidgets() {
    return [
      Draggable<CustomWidget>(
        data: CustomColumn(),
        child: DragWidgetPrview(
          customWidget: CustomColumn(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomColumn"),
          ),
        ),
      ),
      Draggable<CustomWidget>(
        data: CustomRow(),
        child: DragWidgetPrview(
          customWidget: CustomRow(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomRow"),
          ),
        ),
      ),
      Draggable<CustomWidget>(
        data: CustomListView(),
        child: DragWidgetPrview(
          customWidget: CustomListView(),
        ),
        feedback: Container(
          width: widget.size.width * 0.05,
          height: widget.size.width * 0.1,
          child: OnDragPrview(
            customWidget: CustomListView(),
          ),
        ),
      ),
    ];
  }

  List<Widget> getElemetsWidgets() {
    return [
      Draggable<CustomWidget>(
        data: CustomButton(),
        child: DragWidgetPrview(
          customWidget: CustomButton(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.red,
            child: Text("CustomButton"),
          ),
        ),
      ),
      Draggable<CustomWidget>(
        data: CustomText(),
        child: DragWidgetPrview(
          customWidget: CustomText(),
        ),
        feedback: Material(
          child: Container(
            width: widget.size.width * 0.1,
            height: widget.size.width * 0.1,
            color: Colors.orange,
            child: Text("CustomText"),
          ),
        ),
      ),
    ];
  }
}
