import 'package:provider/provider.dart';
import '../provider/product_povider.dart';
import '../screens/signup_screen.dart';
import '../widgets/auth_end_text.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/password_text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  final TextEditingController _password = TextEditingController();

  final TextEditingController _email = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  RegExp emailRegix = new RegExp(LoginScreen.emailPattern);

  void checkVerify(context, ProductProvider provider) async {
    Object value =
        await provider.login(email: _email.text, password: _password.text);

    if (value == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: value != null ? Text(value) : Container(),
      ),
    );
  }

  void checkValid(context, ProductProvider authProvider) {
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
    if (!emailRegix.hasMatch(_email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Email is not Valid"),
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
    if (_password.text.length <= 7) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Password must have 8 characters"),
        ),
      );
      return;
    }
    checkVerify(context, authProvider);
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
        PasswordTextField(
            placeHolder: 'Password',
            value: _password,
            showPassword: showPassword,
            togglePassword: togglePassword),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Consumer<ProductProvider>(builder: (ctx, authProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topPart(),
                SizedBox(height: 30),
                bodyPart(),
                SizedBox(height: 10),
                authProvider.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton(
                        text: "Login",
                        whenPress: () {
                          checkValid(context, authProvider);
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                AuthEndText(
                  firstText: "don't have an account",
                  buttonText: "Signup",
                  whenPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => SignupScreen(),
                      ),
                    );
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
