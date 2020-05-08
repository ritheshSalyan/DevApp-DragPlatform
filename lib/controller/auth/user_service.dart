import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_drag_and_drop/controller/auth/auth_service.dart';
import 'package:flutter_drag_and_drop/controller/database/database.dart';
import 'package:flutter_drag_and_drop/models/user.dart';

class UserService {
  User user;

  Future<void> signIn({String email, String password}) async {
    try {
      await AuthService.signIn(email, password);
      DocumentSnapshot documentSnapshot =
          await AppDatabase.getUserDocumentReference(
                  AuthService.firebaseUser.uid)
              .get();
      user = User.fromJson(documentSnapshot.data, documentSnapshot.documentID);
    } catch (e) {
      throw e.message;
    }
  }

  Future<void> signUp({String email, String password, String name}) async {
    try {
      await AuthService.signUp(email, password);
      user = User(
        name: name,
        uid: AuthService.firebaseUser.uid,
        email: AuthService.firebaseUser.email,
      );
      await AppDatabase.getUserDocumentReference(AuthService.firebaseUser.uid)
          .setData(user.toJson());
    } catch (e) {
      throw e.message;
    }
  }

  Future<void> signOut() async {
    await AuthService.signOut();
    user = null;
  }
}
