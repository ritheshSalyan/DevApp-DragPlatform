import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/color_picker.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/selection_widget.dart';
import 'package:flutter_drag_and_drop/elements/widget_track.dart';
import 'package:tree_view/tree_view.dart';
// import 'package:flutter_drag_and_drop/elements/widgets/custom_fab.dart';

class CustomScaffoldWithAppbar with CustomWidget {
  CustomWidget child;
  CustomAppBarWidget appbar;
  Color backgroundColor = Colors.white;
  void addChild(
    BuildContext context,
    CustomWidget childWidget,
  ) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget);
    }
    super.addChild(context, childWidget);
  }

  void addAppbar(
    BuildContext context, {
    CustomAppBarWidget appBarWidget,
  }) {
    appbar = appBarWidget;
    super.addChild(context, appBarWidget);
  }

  @override
  Widget build(context) {
    print("CustomScaffold");

    return WidgetSelection(
      customWidget: this,
          child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appbar != null
            ? appbar.build(context)
            : PreferredSize(
                child: DragTarget<CustomAppBarWidget>(
                    onAccept: (CustomAppBarWidget data) {
                  print("CustomScaffold");
                  addAppbar(
                    context,
                    appBarWidget: data.copy(),
                  );
                }, builder: (context, List<CustomAppBarWidget> accept,
                        List<dynamic> reject) {
                  return accept != null && accept.isNotEmpty
                      ? accept.first.build(context)
                      : EmptyRepresenter();
                }),
                preferredSize: AppBar().preferredSize,
                // Size(MediaQuery.of(context).size.width,
                //     MediaQuery.of(context).size.height * 0.075),
              ),

        body: child != null
            ? child.build(context)
            : DragTarget(onAccept: (CustomWidget data) {
                print("CustomScaffold");
                addChild(
                  context,
                  data.copy(),
                );
              }, builder:
                (context, List<CustomWidget> accept, List<dynamic> reject) {
                return accept != null && accept.isNotEmpty
                    ? accept.first.build(context)
                    : EmptyRepresenter();
                // }),
              }),
        // floatingActionButton: ,
      ),
    );

    // return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
    //   print("CustomScaffold");
    //   addChild(
    //     context,
    //   data.copy(),
    //   );
    // }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
    //   return Scaffold(
    //       // color: Colors.red,
    //       appBar: PreferredSize(
    //         child: EmptyRepresenter(),
    //         preferredSize: Size(MediaQuery.of(context).size.width,
    //             MediaQuery.of(context).size.height * 0.075),
    //       ), //AppBar(),
    //       body: child == null
    //           ? null //Container()
    //           : child.build(context),
    //       floatingActionButton: CustomFAB().build(
    //           context) //FloatingActionButton(onPressed: () {},child: EmptyRepresenter(),backgroundColor: Colors.transparent,elevation: 0        ),
    //       //Text("data"),
    //       ); //currentWidget(type, child, context);
    // });
  }

  @override
  CustomWidget copy() {
    return CustomScaffoldWithAppbar();
  }

  @override
  // TODO: implement widget
  get name => "Scaffold";

  @override
  Widget properties(BuildContext context,page) {
    return ListView(
      controller: ScrollController(),
      children: <Widget>[
        CustomColorPicker(
          color: backgroundColor,
          lable: "Background Color",
          onSelected: (Color colorSelected) {
            this.backgroundColor = colorSelected;
            super.properties(context,page);
          },
        ),
      ],
    );
  }

  @override
  String get code => '''
  Scaffold(
    ${appbar != null ? "appbar: " + appbar.code + "," : ""}
    ${child != null ? "body: " + child.code + "," : ""}
     )'''; //throw UnimplementedError();

  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox(width: 1,height: 1),
        title: TreeItemView(customWidget: this),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children:
         child == null
            ? []//ChildList()
            :
            //  ChildList(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children:
                 <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    child: child?.buildTree(context),
                  ),
                ],
              // ),
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Container(
      color: neuBackground,
      // padding:  EdgeInsets.symmetric(vertical: 3,horizontal: constraints.width*0.2),
      child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              color: green,
            ),
            preferredSize:
                Size(constraints.width * 0.5, constraints.height * 0.1),
          ),
          body: Container(
              // color: Colors.white,
              )),
    );
  }
  
  @override
  CustomWidget fromJson(Map<String, dynamic> json) {
    if (json[CHILD] != null) {
      child = getWidgetByName(json[CHILD][0][NAME]);
       child.fromJson(json[CHILD][0]);
    }
    backgroundColor = json[PROPERTIES]["bg_color"] == null?Colors.white:Color(json[PROPERTIES]["bg_color"]);
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
      "bg_color":backgroundColor.value,
    };
    return map;
  }

}
