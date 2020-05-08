import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/project_list/create_project_page.dart';
import 'package:flutter_drag_and_drop/controller/project/project_service.dart';
import 'package:flutter_drag_and_drop/home_page.dart';
import 'package:flutter_drag_and_drop/models/project.dart';
import 'package:provider/provider.dart';

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

      project = await createProject(projectName, context);
    } else {
      project = projects[i-1];
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
    return await Provider.of<ProjectService>(context, listen: false)
        .createProject(name);
  }

  void moveToBuilding(BuildContext context, Project project) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DragDrop(
          project: project,
        ),
      ),
    );
  }
}
