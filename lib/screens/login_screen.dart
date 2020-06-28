import 'package:wapar/widgets/my_button.dart';
import 'package:wapar/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RegExp regex = new RegExp(LoginScreen.pattern);

  void submitForm() {}

  void checkValid() {
    bool password = _password.text.trim().isEmpty;
    bool email = _email.text.trim().isEmpty;

    if (password && email) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("All Fields Empty"),
        ),
      );
      return;
    }

    if (email) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Email is Empty"),
        ),
      );
      return;
    }
    if (password) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Password is Empty"),
        ),
      );
      return;
    }
    submitForm();
  }

  Widget topPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontSize: 25),
              ),
              Text("Welcome to wapar"),
            ],
          ),
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/k.jpg'),
        ),
      ],
    );
  }

  Widget bodyPart() {
    return Column(
      children: <Widget>[
        MyTextField(
          placeHolder: "Email",
          value: _email,
        ),
        SizedBox(height: 10),
        MyTextField(
          placeHolder: "Password",
          value: _password,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topPart(),
              SizedBox(height: 30),
              bodyPart(),
              SizedBox(height: 10),
              MyButton(
                text: "Login",
                whenPress: () {
                  checkValid();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
