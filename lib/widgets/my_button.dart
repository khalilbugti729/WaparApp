import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function whenPress;

  static var currentState;
  MyButton({this.text, this.whenPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0.0,
        color: Theme.of(context).accentColor,
        child: Text(
          text,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        onPressed: whenPress,
      ),
    );
  }
}
