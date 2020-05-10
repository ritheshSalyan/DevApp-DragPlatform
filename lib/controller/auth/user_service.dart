import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_drag_and_drop/controller/auth/auth_service.dart';
import 'package:flutter_drag_and_drop/controller/database/database.dart';
import 'package:flutter_drag_and_drop/models/user.dart';

class UserService with ChangeNotifier {
  User user;
  bool silentLoginTried = false;
  UserService() {
    isSignedIn();
  }
  Future<void> signIn({String email, String password}) async {
    try {
      await AuthService.signIn(email, password);
      getUserDetails();

    } catch (e) {
      throw e.message;
    }
    notifyListeners();

  }

  Future<void> getUserDetails() async {
    DocumentSnapshot documentSnapshot =
        await AppDatabase.getUserDocumentReference(AuthService.firebaseUser.uid)
            .get();
    user = User.fromJson(documentSnapshot.data, documentSnapshot.documentID);
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
    notifyListeners();

  }

  Future<void> isSignedIn() async {
    if (await AuthService.isSignedIn()) {
     await getUserDetails();
    }
    silentLoginTried = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    await AuthService.signOut();
    user = null;
    notifyListeners();

  }
}
