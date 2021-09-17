// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class MaterialRoundButton extends StatelessWidget {
  final String text;
  final Function tap;

  const MaterialRoundButton({Key key, this.text, this.tap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: tap,
      color: Colors.deepOrangeAccent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),

      ),
      child: Text(
        text, style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.white,

      ),
      ),

    );
  }
}
