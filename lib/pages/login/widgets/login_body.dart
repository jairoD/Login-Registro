import 'package:flutter/material.dart';
import 'package:login_register/pages/widgets/general_button.dart';
import 'package:login_register/pages/widgets/general_input.dart';
import 'package:login_register/services/firebase/firebase_auth_services.dart';
import 'package:login_register/utils/Alerts.dart';
import 'package:login_register/utils/inputs_validation.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final loginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Form(
            key: loginKey,
            child: Column(
              children: [
                GeneralInput(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "email@email.com",
                  validate: (value) => InputsValidator.inputEmpty(value),
                ),
                SizedBox(height: 10),
                GeneralInput(
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  hintText: "password",
                  validate: (value) => InputsValidator.inputEmpty(value),
                  obscure: true,
                  showIcon: true,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GeneralButton(
                text: "Sign In",
                function: () => login(context),
              ),
              SizedBox(height: 10),
              GeneralButton(
                  text: "Sign In with Google",
                  backgroundColor: Colors.white,
                  function: () => loginGoogle(context),
                  icon: Image(
                      image: AssetImage("assets/icons/google_icon.png"),
                      width: 22),
                  textColor: Colors.black),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/register"),
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff5567fa))),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    if (loginKey.currentState.validate()) {
      Alerts.loading(context);
      final loginResponse = await FirebaseAuthServices()
          .firebaseLoginUserPassword(
              emailController.text, passwordController.text);
      Navigator.of(context).pop();
      if (loginResponse is String) {
        Alerts.errorFlushbar(context, "Error", loginResponse);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      }
    }
  }

  void loginGoogle(BuildContext context) async {
    try {
      final loginResponse = await FirebaseAuthServices().firebaseGoogleLogin();
      if (loginResponse is String) {
        Alerts.errorFlushbar(context, "Error", loginResponse);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      }
    } catch (e) {
      Alerts.errorFlushbar(context, "Error", "Error al inciar sesión");
    }
  }
}
