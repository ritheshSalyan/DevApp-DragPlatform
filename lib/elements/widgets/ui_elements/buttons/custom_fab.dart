// import 'package:flutter/material.dart';
// import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
// import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

// class CustomFAB with CustomWidget {
//   CustomWidget child;

//   int elevation;
//   void addChild(BuildContext context, CustomWidget childWidget) {
//     if (child == null) {
//       child = childWidget;
//     } else {
//       child.addChild(context,   childWidget);
//     }
//     super.addChild(context,childWidget);
//   }

//   @override
//   Widget build(context) {
//     return DragTarget<CustomWidget>(onAccept: (CustomWidget data) {
//       print("CustomFAB");
//       addChild(
//         context,
//       data.copy(),
//       );
//     }, builder: (context, List<CustomWidget> accept, List<dynamic> reject) {
//       return FloatingActionButton(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         onPressed: () {},
//         child: child == null ? EmptyRepresenter():child.build(context),
//       ); //currentWidget(type, child, context);
//     });
//   }

//   @override
//   CustomWidget copy() {
//     return CustomFAB();
//   }

//   @override
//   // TODO: implement widget
//   get name => "Button";
//     @override
//   Widget properties(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         TextField(
//           onChanged: (string) {
//             elevation = int.parse(string);
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   // TODO: implement code
//   String get code =>''' 
//   FloatingActionButton()'''; //throw UnimplementedError();
// }
