import 'package:flutter/material.dart';
import 'package:login_register/pages/widgets/general_button.dart';
import 'package:login_register/pages/widgets/general_input.dart';
import 'package:login_register/services/firebase/firebase_auth_services.dart';
import 'package:login_register/utils/Alerts.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final registerKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: registerKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                GeneralInput(
                  textInputType: TextInputType.text,
                  controller: fullNameController,
                  hintText: "Full name",
                ),
                SizedBox(height: 10),
                GeneralInput(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email Adress",
                ),
                SizedBox(height: 10),
                GeneralInput(
                  controller: phoneController,
                  textInputType: TextInputType.number,
                  hintText: "Phone Number",
                ),
                SizedBox(height: 10),
                GeneralInput(
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  hintText: "password",
                  obscure: true,
                  showIcon: true,
                ),
                SizedBox(height: 10),
              ],
            ),
            Column(
              children: [
                GeneralButton(
                    text: "Sign up", function: () => register(context)),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an Account? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text("Sign in",
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
      ),
    );
  }

  void register(BuildContext context) async {
    Alerts.loading(context);
    final registerResponse = await FirebaseAuthServices().firebaseRegistration(
        emailController.text,
        passwordController.text,
        fullNameController.text,
        phoneController.text);
    Navigator.of(context).pop();
    if (registerResponse is String) {
      Alerts.errorFlushbar(context, "Error", registerResponse);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }
}
