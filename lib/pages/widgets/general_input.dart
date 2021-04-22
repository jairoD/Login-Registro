import 'package:flutter/material.dart';

class GeneralInput extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final void Function(String) onChanged;
  final String Function(String) validate;
  bool obscure;
  final TextEditingController controller;
  final String error;
  final bool showIcon;

  GeneralInput(
      {Key key,
      this.hintText,
      this.textInputType,
      this.onChanged,
      this.validate,
      this.controller,
      this.error,
      this.showIcon = false,
      this.obscure = false})
      : super(key: key);

  @override
  _GeneralInputState createState() => _GeneralInputState();
}

class _GeneralInputState extends State<GeneralInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.obscure ?? false,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorText: widget.error,
        labelStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w300,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        fillColor: Color(0xff22262f),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        border: inputBorder(),
        errorBorder: inputBorder(color: Colors.red),
        disabledBorder: inputBorder(color: Colors.red),
        suffixIcon: widget.showIcon
            ? GestureDetector(
                onTap: () =>
                    this.setState(() => widget.obscure = !widget.obscure),
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
      ),
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
      validator: widget.validate,
    );
  }

  InputBorder inputBorder({Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.transparent, width: 1.0),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
