import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final bool myKeyboardtypeNumber;
  final TextEditingController value;
  final String placeHolder;
  MyTextField({this.placeHolder, this.value, this.myKeyboardtypeNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: TextField(
        inputFormatters: myKeyboardtypeNumber
            ? [WhitelistingTextInputFormatter.digitsOnly]
            : null,
        keyboardType:
            myKeyboardtypeNumber ? TextInputType.number : TextInputType.text,
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
