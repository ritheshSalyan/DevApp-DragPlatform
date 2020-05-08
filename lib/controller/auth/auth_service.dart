import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseUser firebaseUser;

  static Future<void> signIn(String email, String password) async {
    try {
      AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    firebaseUser = result.user;
    return result.additionalUserInfo.isNewUser;
    } catch (error) {
      throw error;
    //   switch (error.code) {
    //   case "ERROR_INVALID_EMAIL":
    //     throw "Your email address appears to be malformed.";
    //     break;
    //   case "ERROR_WRONG_PASSWORD":
    //     throw "Your password is wrong.";
    //     break;
    //   case "ERROR_USER_NOT_FOUND":
    //     throw "User with this email doesn't exist.";
    //     break;
    //   case "ERROR_USER_DISABLED":
    //     throw "User with this email has been disabled.";
    //     break;
    //   case "ERROR_TOO_MANY_REQUESTS":
    //     throw "Too many requests. Try again later.";
    //     break;
    //   case "ERROR_OPERATION_NOT_ALLOWED":
    //     throw "Signing in with Email and Password is not enabled.";
    //     break;
    //   default:
    //     throw "An undefined Error happened.";
    // }
    }
     
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
