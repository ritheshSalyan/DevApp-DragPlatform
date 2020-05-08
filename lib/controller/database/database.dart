import 'package:cloud_firestore/cloud_firestore.dart';

class AppDatabase {
static  CollectionReference userCollectionReference =
      Firestore.instance.collection("user");

 static DocumentReference getUserDocumentReference(String uid) =>
      userCollectionReference.document(uid);

  
}
