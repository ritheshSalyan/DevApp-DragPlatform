import 'package:flutter/foundation.dart';

class ControllerClass with ChangeNotifier {
  void update() {
    notifyListeners();
  }
}
