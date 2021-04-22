import 'package:flutter/material.dart';
import 'package:login_register/pages/register/widgets/register_body.dart';
import 'package:login_register/pages/register/widgets/register_header.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

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
            children: [RegisterHeader(), RegisterBody()],
          ),
        ),
      ),
    );
  }
}
