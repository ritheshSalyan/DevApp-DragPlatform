import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/loading.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/create_project_page.dart';
import 'package:flutter_drag_and_drop/controller/project/project_service.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:flutter_drag_and_drop/models/project.dart';
import 'package:flutter_drag_and_drop/roure.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;

class ProjectListViewModel with ChangeNotifier {
  List<Project> projects = [];
  Future<void> projectPressed(BuildContext context, int i) async {
    Project project;
    if (i == 0) {
      String projectName = await showDialog(
        context: context,
        builder: (context) {
          return CreateProjectPage();
        },
      );

      if (projectName == null || projectName.isEmpty) {
        return;
      }
      Loader.showOverlayLoading(context);

      project = await createProject(projectName, context);
      Loader.hideOverlayLoading(context);
    } else {
      project = projects[i - 1];
    }
    moveToBuilding(context, project);
  }

  Stream<QuerySnapshot> getAllProject(BuildContext context) {
    return Provider.of<ProjectService>(context, listen: false)
        .getAllProjectStream();
  }

  void convert(BuildContext context, QuerySnapshot querySnapshot) {
    projects = Provider.of<ProjectService>(context, listen: false)
        .convert(querySnapshot);
  }

  Future<Project> createProject(String name, BuildContext context) async {
    print(name);
    Project project = await Provider.of<ProjectService>(context, listen: false)
        .createProject(name);
    js.context.callMethod("open", [
      "https://firebasestorage.googleapis.com/v0/b/build-it-2e578.appspot.com/o/Sample%20Project%2Fproject_sample.zip?alt=media&token=1397ece5-538a-44aa-bf34-8fa554023ef0"
    ]);
    return project;
  }

  void moveToBuilding(BuildContext context, Project project) {
    Navigator.of(context).pushNamed(BUILD_ROUTE, arguments: project
        // MaterialPageRoute(
        //   builder: (_) => DragDrop(
        //     project: project,
        //   ),
        // ),
        );
  }
}
