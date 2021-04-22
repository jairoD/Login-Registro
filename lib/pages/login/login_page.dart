import 'package:flutter/material.dart';
import 'package:login_register/pages/login/widgets/login_body.dart';
import 'package:login_register/pages/login/widgets/login_header.dart';
import 'package:login_register/pages/widgets/general_button.dart';
import 'package:login_register/pages/widgets/general_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [LoginHeader(), LoginBody()],
          ),
        ),
      ),
    );
  }
}
