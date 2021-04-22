import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreServices {
  Future<void> firebaseCreateUserInitialData(
      String fullName, String email, String phone, String uid) async {
    try {
      CollectionReference createUserDate =
          FirebaseFirestore.instance.collection("/users");
      final response = await createUserDate.doc(uid).set(
          {"fullName": fullName, "email": email, "phone": phone, "uid": uid});
      return response;
    } catch (e) {
      return null;
    }
  }
}
