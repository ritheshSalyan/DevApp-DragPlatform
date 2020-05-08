import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader {
  static showOverlayLoading(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SpinKitDualRing(color: green),
    );
  }

  static hideOverlayLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Widget loading(BuildContext context) => SpinKitDualRing(color: green);
}
