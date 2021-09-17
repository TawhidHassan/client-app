// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_location_get_app/Constants/Colors/constants.dart';

import 'TextFieldContainer.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const PasswordTextField({Key key, this.label, this.controller}) : super(key: key);
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  bool _passwordVisible = true;
  @override
  void initState() {
    _passwordVisible = true;
  }
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(child:
    TextFormField(
      controller: widget.controller,
      obscureText: _passwordVisible,
      // onChanged: widget.onChanged,
      cursorColor: kPrimaryColor,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color:Colors.white,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
