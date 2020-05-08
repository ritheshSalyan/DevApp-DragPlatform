import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseUser firebaseUser;

  static Future<void> signIn(String email, String password) async {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    firebaseUser = result.user;
    return result.additionalUserInfo.isNewUser;
  }
 static Future<void> signUp(String email, String password) async {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
   
    return await signIn(email, password);
  }
  static Future<bool> isSignedIn() async {
    firebaseUser = await auth.currentUser();
    return firebaseUser != null;
  }

  static Future<void> signOut() async {
    await auth.signOut();
    firebaseUser = null;
  }
}
