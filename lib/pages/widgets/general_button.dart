import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final Function function;
  final icon;
  const GeneralButton({
    Key key,
    this.backgroundColor,
    this.textColor,
    this.text,
    this.function,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor ?? Color(0xff5667f9),
      ),
      child: FlatButton(
          onPressed: function != null ? function : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Row(
                  children: [icon, SizedBox(width: 10)],
                ),
              Text(text ?? "",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor ?? Colors.white)),
            ],
          )),
    );
  }
}
