import 'package:flutter/material.dart';
import 'package:login_register/pages/widgets/general_button.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage("assets/icons/cinema.jpg"),
              fit: BoxFit.fitWidth)),
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GeneralButton(
            text: "Get started",
            function: () => Navigator.of(context)
                .pushNamedAndRemoveUntil("/login", (route) => false)),
      ),
    );
  }
}
