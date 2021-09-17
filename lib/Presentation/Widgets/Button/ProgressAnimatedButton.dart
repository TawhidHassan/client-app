// ignore_for_file: file_names, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:progress_button/progress_button.dart';

class ProgressAnimatedButton extends StatefulWidget {

  final String text;
  final Function tap;
  final Color colors;
  final  ButtonState progressButtonState;
  const ProgressAnimatedButton({Key key, this.text, this.tap, this.colors, this.progressButtonState}) : super(key: key);

  @override
  _ProgressAnimatedButtonState createState() => _ProgressAnimatedButtonState();
}

class _ProgressAnimatedButtonState extends State<ProgressAnimatedButton> {


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(
                    (ButtonState.normal == widget.progressButtonState ? 18.0 : 0.0)),
                child: ProgressButton(
                  text: widget.text,
                  onPressed:widget.tap,
                  buttonState: widget.progressButtonState,
                  pBackgroundColor: widget.colors,
                  pProgressColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
  }


}