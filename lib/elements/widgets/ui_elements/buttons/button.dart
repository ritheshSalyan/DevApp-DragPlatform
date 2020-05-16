import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/selection_widget.dart';
import 'package:flutter_drag_and_drop/elements/widget_track.dart';
import 'package:flutter_drag_and_drop/models/page.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';

class CustomButton with CustomWidget {
  CustomWidget child;
  int elevation = 1;
  Widget icon;
  int navigateTo;
  CustomFunction function;
  // double height= 0.25;
  void addChild(BuildContext context, CustomWidget childWidget) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    return WidgetSelection(
      customWidget: this,
      child: DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
        print("Button");
        addChild(
          context,
          data.copy(),
        );
      }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
        return RaisedButton(
          onPressed: function != null
              ? () {
                  function.execute(context);
                  // if (navigateTo == null) {
                  //   return;
                  // }
                  // Provider.of<ControllerClass>(context, listen: false)
                  //     .changePage(navigateTo);
                }
              : null,
          child: child == null ? null : child.build(context),
        ); //currentWidget(type, child, context);
      }),
    );
  }

  @override
  CustomWidget copy() {
    return CustomButton();
  }

  @override
  get name => "Button";

//  @override
//  get prevIcon =>
  @override
  Widget properties(BuildContext context, CustomPage page) {
    return ListView(
      controller: ScrollController(),
      children: <Widget>[
        // TextField(
        //   onChanged: (string) {
        //     elevation = int.parse(string);
        //   },
        // ),
        // NavigationModule(
        //   selected: navigateTo,
        //   onSelected: (int index) {
        //   navigateTo = index;
        //   super.properties(context,page);
        // }
        // ),

        Consumer<ControllerClass>(
          builder: (context, value, child) {
            return DropdownButton<CustomFunction>(
                value: function,
                items: List<DropdownMenuItem<CustomFunction>>.from(value
                    .pages[value.activePage].classModel.functions
                    .map((e) => DropdownMenuItem<CustomFunction>(
                          child: Text(e.functionName),
                          value: e,
                        ))),
                onChanged: (newFunction) {
                  function = newFunction;
                  super.properties(context, page);
                });
          },
        ),
        FlatButton(
            onPressed: () async {
              IconData iconData = await FlutterIconPicker.showIconPicker(
                context,
              );

              icon = Icon(iconData);

              super.properties(context, page);
              // icon = Icon(icon)
            },
            child: icon)
      ],
    );
  }

  @override
  // TODO: implement code
  String get code => '''RaisedButton(
        onPressed: () {
         ${function != null ? "viewModel." + function.functionName + "();" : ""}
        },
        ${child == null ? "" : "child:" + child.code + ','}
      )''';

  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox(width: 0, height: 0),
        title: TreeItemView(customWidget: this), // Text("Container"),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children: child != null
            ? <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: child?.buildTree(context),
                ),
              ]
            : [],
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: constraints.width,
          height: constraints.height * 0.25,
          // color: green,
          child: RaisedButton(color: green, onPressed: () {}),
        ),
      ],
    );
  }

  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    if (json[CHILD] != null) {
      child = getWidgetByName(json[CHILD][0][NAME]);
      child.fromJson(json[CHILD][0]);
    }
    navigateTo = json[PROPERTIES]["navigate_to"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (child != null) {
      map[CHILD] = [child.toJson()];
    } else {
      map[CHILD] = null;
    }

    map[NAME] = name;
    map[PROPERTIES] = {
      "navigate_to": navigateTo,
    };
    return map;
  }
}

class NavigationModule extends StatelessWidget {
  const NavigationModule({
    Key key,
    this.onSelected,
    this.selected,
  }) : super(key: key);
  final Function(int selected) onSelected;
  final int selected;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        hint: Text("Navigate To"),
        value: selected,
        items: List<DropdownMenuItem>.generate(
            Provider.of<ControllerClass>(context, listen: false).pages.length,
            (index) => DropdownMenuItem(
                value: index,
                child: Text(
                    "${Provider.of<ControllerClass>(context, listen: false).pages[index].pageName}"))),
        onChanged: onSelected);
  }
}
