import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_drag_and_drop/controller/auth/auth_service.dart';

class AppDatabase {
  static CollectionReference userCollectionReference =
      Firestore.instance.collection("user");

  static DocumentReference getUserDocumentReference(String uid) =>
      userCollectionReference.document(uid);

  static CollectionReference getUserProjectsCollection() {
    return getUserDocumentReference(AuthService.firebaseUser.uid)
        .collection("projects");
  }

    static DocumentReference getSingleProject(String projectId) {
    return getUserDocumentReference(AuthService.firebaseUser.uid)
        .collection("projects").document(projectId);
  }
      static CollectionReference getPagesOfProject(String projectId) {
    return getUserDocumentReference(AuthService.firebaseUser.uid)
        .collection("projects").document(projectId).collection("pages");
  }
        static CollectionReference getSingleOfProject(String projectId,int index) {
    return getUserDocumentReference(AuthService.firebaseUser.uid)
        .collection("projects").document(projectId).collection("pages");
  }
}
