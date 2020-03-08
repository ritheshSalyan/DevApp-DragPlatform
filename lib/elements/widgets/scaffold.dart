import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/custom_fab.dart';

class CustomScaffold with CustomWidget {
  CustomWidget child;
  CustomAppBarWidget appbar;
  void addChild(
    BuildContext context, {
    CustomWidget childWidget,
  }) {
    if (child == null) {
      child = childWidget;
    } else {
      child.addChild(context, childWidget: childWidget);
    }
    super.addChild(context);
  }

  void addAppbar(
    BuildContext context, {
    CustomAppBarWidget appBarWidget,
  }) {
    appbar = appBarWidget;
    super.addChild(context);
  }

  @override
  Widget build(context) {
    print("CustomScaffold");

    return Scaffold(
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
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.075),
            ),

      body: child != null
          ? child.build(context)
          : DragTarget(onAccept: (CustomWidget data) {
              print("CustomScaffold");
              addChild(
                context,
                childWidget: data.copy(),
              );
            }, builder:
              (context, List<CustomWidget> accept, List<dynamic> reject) {
              return accept != null && accept.isNotEmpty
                  ? accept.first.build(context)
                  : EmptyRepresenter();
              // }),
            }),
      // floatingActionButton: ,
    );

    // return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
    //   print("CustomScaffold");
    //   addChild(
    //     context,
    //     childWidget: data.copy(),
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
    return CustomScaffold();
  }

  @override
  // TODO: implement widget
  get name => "Scaffold";

    @override
  Widget properties(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (string) {
            // elevation = int.parse(string);
          },
        ),
      ],
    );
  }
}
