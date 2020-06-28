import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController value;
  final String placeHolder;
  MyTextField({this.placeHolder, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: TextField(
        controller: value,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(7),
          labelText: placeHolder,
          labelStyle: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
