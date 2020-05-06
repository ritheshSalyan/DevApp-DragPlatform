// import 'package:flutter/material.dart';
// import 'package:flutter_drag_and_drop/UI/widgets/empty_representer.dart';
// import 'package:flutter_drag_and_drop/constants.dart';
// import 'package:flutter_drag_and_drop/elements/custom_widget.dart';

// class CustomAppbar with CustomWidget, CustomAppBarWidget {
//   CustomWidget child;
//   void addChild(BuildContext context, CustomWidget childWidget) {
//     if (child == null) {
//       child = childWidget;
//     } else {
//       child.addChild(context, childWidget);
//     }
//     super.addChild(context, childWidget);
//   }

//   @override
//   Widget build(context) {
//     return AppBar();
//   }

//   @override
//   CustomWidget copy() {
//     return CustomAppbar();
//   }

//   @override
//   get name => "Appbar";

//   @override
//   Size get size => AppBar().preferredSize;

//   @override
//   Widget properties(BuildContext context) {
//     return ListView();
//   }

//   @override
//   // TODO: implement code
//   String get code => ''' Appbar()''';

//   @override
//   Widget buildTree(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         super.setActive(context, this);
//       },
//       child: ExpansionTile(
//         title: Text("Appbar"),
//         onExpansionChanged: (value) {
//           super.setActive(context, this);
//         },
//         children: child == null
//             ? null
//             : <Widget>[
//                 child?.buildTree(context),
//               ],
//       ),
//     );
//   }

//   @override
//   Widget prevIcon(Size constraints) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           width: constraints.width,
//           height: constraints.height * 0.25,
//           color: green,
//         ),
//       ],
//     );
//   }
// }
