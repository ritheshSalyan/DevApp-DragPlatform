import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/tree_item.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/controller/app_ui/controller.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/properties_elements/multi_choice_selector.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tree_view/tree_view.dart';

class CustomListView with CustomWidget {
  List<CustomWidget> children = [];
  Axis scrollDirection = Axis.vertical;
  int elevation;
  void addChild(BuildContext context, CustomWidget childWidget,
      {int position}) {
    print(position);

    children.insert(position ?? children.length, childWidget);
    super.addChild(context, childWidget);
  }

  @override
  Widget build(context) {
    Size size = Provider.of<ControllerClass>(context, listen: false).size;

    return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
      print("CustomListView");
      addChild(
        context,
        data.copy(),
      );
    }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
      return children.isEmpty
          ? Container(
              height: size.height,
              width: size.width,
              child: ListView(scrollDirection: scrollDirection,
                  // needsLongPressDraggable: false,
                  // onReorder: (int oldIndex, int newIndex) {
                  //   addChild(context, children.removeAt(oldIndex), position: newIndex);
                  // },
                  children: <Widget>[
                    EmptyRepresenter(
                      key: ValueKey(0),
                      width: size.width * 0.5,
                      height: size.height / 3,
                    ),
                    EmptyRepresenter(
                      key: ValueKey(1),
                      width: size.width * 0.5,
                      height: size.height / 3,
                    ),
                    EmptyRepresenter(
                      key: ValueKey(2),
                      width: size.width * 0.5,
                      height: size.height / 3,
                    ),
                  ]),
            )
          : ListView(
              scrollDirection: scrollDirection,
              // needsLongPressDraggable: false,
              // onReorder: (int oldIndex, int newIndex) {
              //   addChild(context, children.removeAt(oldIndex), position: newIndex);
              // },
              children: List.generate(children.length + 1 + accept.length, (i) {
                if (i < children.length) {
                  return SizedBox(
                      key: ValueKey(i), child: children[i].build(context));
                } else
                if(children.length == i){
                  return  Container(width:30,height:30
                    );
                }else
                 {
                  return Container(
                    key: ValueKey(i),
                    child: accept[i-1 - children.length].build(context),
                  );
                }
              }, growable: true),
            ); //currentWidget(type, child, context);
    });
  }

  @override
  CustomWidget copy() {
    return CustomListView();
  }

  @override
  get name => "ListView";

  @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("ListView Properties"),
        CustomNeumorpicRadio(
          onSelect: (select) {
            scrollDirection = select;
            super.properties(context);
          },
          initialSelect: scrollDirection,
          lable: "Scroll direction",
          children: {
            Axis.horizontal: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.gesture_swipe_horizontal,
                  color: green,
                ) //Text('First'),

                ),
            Axis.vertical: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Icon(
                  MaterialCommunityIcons.gesture_swipe_vertical,
                  color: green,
                ) //Text('First'),

                ),
          },
        ),
      ],
    );
  }

  String childrenCode() {
    String code = "";
    children.forEach((child) {
      code += child.code + ',';
    });
    return code;
  }

  @override
  // TODO: implement code
  String get code => '''
  ListView(
    children:<Widget>[
      ${childrenCode()}
    ]
  )''';

  @override
  Widget buildTree(BuildContext context) {
    return InkWell(
      onTap: () {
        super.setActive(context, this);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox(width: 1, height: 1),
        title: TreeItemView(customWidget: this),
        onExpansionChanged: (value) {
          super.setActive(context, this);
        },
        children: children.isEmpty
            ? []
            :
            // ChildList(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children:
            List<Widget>.generate(
                children.length,
                (i) => Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: children[i]?.buildTree(context),
                ),
              )
        // )
        // child.buildTree(context),
        ,
      ),
    );
  }

  @override
  Widget prevIcon(Size constraints) {
    return Container(
      // color: green,
      width: constraints.width * 0.9,
      height: constraints.height * 0.9,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05),
            color: green,
          ),
          Container(
            height: (constraints.height * 0.05),
          ),
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05),
            color: green,
          ),
          Container(
            height: (constraints.height * 0.05),
          ),
          Container(
            width: constraints.width * 0.9,
            height: (constraints.height * 0.05),
            color: green,
          ),
          Container(
            height: (constraints.height * 0.05),
          ),
          Icon(Icons.arrow_downward),
        ],
      ),
    );
  }
}
