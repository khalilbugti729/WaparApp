import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController value;
  final String placeHolder;
  final Function togglePassword;
  final bool showPassword;
  PasswordTextField(
      {this.showPassword, this.placeHolder, this.togglePassword, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: TextField(
        obscureText: showPassword ? true : false,
        controller: value,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: togglePassword,
              child: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              )),
          contentPadding: EdgeInsets.all(7),
          labelText: placeHolder,
          labelStyle: TextStyle(color: Colors.white70),
        ),
      ),
    );
    // IconButton(
    //     icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
  }
}
