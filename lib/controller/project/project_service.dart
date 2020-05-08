import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/controller/database/database.dart';
import 'package:flutter_drag_and_drop/models/project.dart';

class ProjectService {
  Project project;

  Future<Project> createProject(String name) async {
    Project newProject = Project(
      projectName: name,
    );
    DocumentReference reference =
        await AppDatabase.getUserProjectsCollection().add(
      newProject.toJson(),
    );
    newProject.id = reference.documentID;
    AppDatabase.getSingleProject(newProject.id)
        .setData(newProject.toJson(), merge: true);
    return newProject;
  }

  Stream<QuerySnapshot> getAllProjectStream() {
    return AppDatabase.getUserProjectsCollection()
        .orderBy(UPDATED_AT, descending: true)
        .snapshots();
  }

  List<Project> convert(QuerySnapshot querySnapshot) {
    List<Project> projects = [];
    for (var document in querySnapshot.documents) {
      projects.add(Project.fromJson(document.data));
    }
    return projects;
  }
}
