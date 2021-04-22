import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_register/services/firebase/firebase_firestore_services.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future firebaseRegistration(
      String email, String password, String fullName, String phone) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.additionalUserInfo.isNewUser)
        await FirebaseFirestoreServices().firebaseCreateUserInitialData(
            fullName, email, phone, userCredential.user.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ("Contraseña demasiado insegura.");
      } else if (e.code == 'email-already-in-use') {
        return ('Correo electrónico no disponible.');
      } else
        return ("Error, al registrar revise los datos e intente nuevamente");
    } catch (e) {
      return ('Error al registrar, intente nuevamente.');
    }
  }

  Future firebaseLoginUserPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return ('Usuario o cantraseña incorrecto.');
    }
  }

  Future firebaseGoogleLogin() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential.
      final GoogleAuthCredential googleCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the Google [UserCredential].
      final UserCredential googleUserCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      if (googleUserCredential.additionalUserInfo.isNewUser)
        await FirebaseFirestoreServices().firebaseCreateUserInitialData(
            googleUserCredential.user.displayName,
            googleUserCredential.user.email,
            googleUserCredential.user.phoneNumber,
            googleUserCredential.user.uid);
    } catch (e) {
      return null;
    }
  }

  User firebaseCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return auth.currentUser;
    } else {
      return null;
    }
  }

  Future firebaseSignOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
