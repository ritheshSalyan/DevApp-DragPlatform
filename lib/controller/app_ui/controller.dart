import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/controller/database/database.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';
import 'package:flutter_drag_and_drop/models/page.dart';
// import 'package:responsive_builder/responsive_builder.dart';

class ControllerClass with ChangeNotifier {
  CustomWidget latestWidget;
  int activePage = 0;
  List<CustomPage> pages = [];
  String projectId;
  Size size;
  ControllerClass(this.projectId) {
    pages = [CustomPage(pageName: "")];
    // projectId = "NNJHE0zlumPetpe6RN5I";
    print("projectID $projectId");
    getAllPages(projectId);
  }

  bool isUI = true;

  Future<void> getAllPages(String projectId) async {
    print("Started getAllPages ");
    pages = [CustomPage(pageName: "")];
    // QuerySnapshot querySnapshot =
    //     await AppDatabase.getPagesOfProject(projectId).getDocuments();
    pages = [];
    // for (var document in querySnapshot.documents) {
    //   pages.add(CustomPage.fromJson(document.data, document.documentID));
    // }
    if (pages.isEmpty) {
      pages.add(CustomPage(pageName: "Page${pages.length + 1}"));
    }
    print("Ended getAllPages ");

    notify();
  }

  updatePageName(String name) {
    pages[activePage].pageName = name;
  }

  Future<void> save(BuildContext context) async {
    print("Inside Save");
    for (var i = 0; i < pages.length; i++) {
      print("Insise For $i");
      await AppDatabase.getPagesOfProject(projectId).document("$i").setData(
            pages[i].toJson(),
            merge: true,
          );
    }
  }

  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }

  void addPage() {
    pages.add(CustomPage(pageName: "Page${pages.length + 1}"));
    activePage = pages.length - 1;
    latestWidget = null;
    notifyListeners();
  }

  void updateChild(CustomWidget latest) {
    latestWidget = latest;
    print("Add updateChild ${latestWidget.name} ");

    notifyListeners();
  }

  void notify() {
    // latestWidget = latest;
    notifyListeners();
  }

  Widget properties(BuildContext context) {
    // print("Properitis called ${latestWidget?.name}");
    return latestWidget != null
        ? latestWidget.properties(context, pages[activePage])
        : Container();
  }
}
