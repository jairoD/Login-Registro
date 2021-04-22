import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/models/user_model.dart';
import 'package:login_register/pages/widgets/general_button.dart';
import 'package:login_register/services/firebase/firebase_auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User currentUser = FirebaseAuthServices().firebaseCurrentUser();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final FirebaseUserModel user =
                  FirebaseUserModel.fromMap(snapshot.data.data());
              return Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome ${user.fullName ?? ""}!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      Text("Email: ${user.email ?? ""}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      Text("PhoneNumber: ${user.phone ?? "Unknown"}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      SizedBox(height: 100),
                      GeneralButton(
                          text: "Cerrar sesión",
                          function: () {
                            FirebaseAuthServices().firebaseSignOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/login", (route) => false);
                          })
                    ]),
              );
            }
          },
        ),
      ),
    );
  }
}
