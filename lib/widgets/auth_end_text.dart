import 'package:flutter/material.dart';

class AuthEndText extends StatelessWidget {
  final String firstText;
  final String buttonText;
  final Function whenPressed;
  AuthEndText({this.buttonText, this.firstText, this.whenPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(firstText),
        InkWell(
          onTap: whenPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
