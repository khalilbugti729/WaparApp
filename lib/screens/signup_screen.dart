import 'package:provider/provider.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/login_screen.dart';
import 'package:wapar/widgets/auth_end_text.dart';
import 'package:wapar/widgets/my_button.dart';
import 'package:wapar/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';

import 'package:wapar/widgets/password_text_field.dart';

class SignupScreen extends StatefulWidget {
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phoneNumberPattern =
      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _auth = FirebaseAuth.instance;
  bool showPassword = true;
  bool showConfirmPassword = true;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  String _gender = "Male";
  final TextEditingController _address = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isMale = true;
  RegExp emailRegix = new RegExp(SignupScreen.emailPattern);
  RegExp phoneRegix = new RegExp(SignupScreen.phoneNumberPattern);
  File _image;

  void toggleConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  var provider;
  Future profileImage(ImageSource mySource) async {
    final pickedFile = await ImagePicker()
        .getImage(
            source: mySource, imageQuality: 80, maxHeight: 480, maxWidth: 720)
        .whenComplete(() => Navigator.of(context).pop());
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        onPressed: () {
                          profileImage(ImageSource.camera);
                        }),
                    Text("Camera"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        onPressed: () {
                          profileImage(ImageSource.gallery);
                        }),
                    Text("Gallery"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkVerify(ProductProvider provider) async {
    Object value = await provider.signUp(
      address: _address.text,
      email: _email.text,
      fullName: _fullName.text,
      gender: _gender,
      image: _image,
      password: _password.text,
      phoneNumber: _phoneNumber.text,
    );
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

  void checkValid(ProductProvider provider) {
    bool fullName = _fullName.text.trim().isEmpty;
    bool password = _password.text.trim().isEmpty;
    bool confirmPassword = _confirmPassword.text.trim().isEmpty;
    bool phoneNumber = _phoneNumber.text.trim().isEmpty;
    bool email = _email.text.trim().isEmpty;
    bool myAddress = _address.text.trim().isEmpty;

    if (_image == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Photo is Empty"),
        ),
      );
      return;
    }

    if (fullName &&
        password &&
        confirmPassword &&
        phoneNumber &&
        email &&
        myAddress) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("All Fields Empty"),
        ),
      );
      return;
    }

    if (fullName) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Name is Empty"),
        ),
      );
      return;
    }
    if (email) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
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
          backgroundColor: Theme.of(context).errorColor,
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
    if (confirmPassword) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Confirm Password is Empty"),
        ),
      );
      return;
    }

    if (!_confirmPassword.text.contains(_password.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Password not matched"),
        ),
      );
      return;
    }

    if (phoneNumber) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number is Empty"),
        ),
      );
      return;
    }

    if (!phoneRegix.hasMatch(_phoneNumber.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number must be 11 numbers"),
        ),
      );
      return;
    }

    if (myAddress) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Address is empty"),
        ),
      );
      return;
    }

    checkVerify(provider);
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
                "Signup",
                style: TextStyle(fontSize: 25),
              ),
              Text("create an account"),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            _showMyDialog();

            // profileImage(ImageSource.camera);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundImage:
                _image == null ? AssetImage('assets/k.jpg') : FileImage(_image),
          ),
        ),
      ],
    );
  }

  void toggleGender() {
    setState(() {
      isMale = !isMale;
      if (isMale) {
        _gender = "Male";
      } else {
        _gender = "Female";
      }
    });
  }

  Widget bodyPart() {
    return Column(
      children: <Widget>[
        MyTextField(
          placeHolder: "Full Name",
          value: _fullName,
        ),
        SizedBox(height: 10),
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
        SizedBox(height: 10),
        PasswordTextField(
            placeHolder: 'Confirm Password',
            value: _confirmPassword,
            showPassword: showConfirmPassword,
            togglePassword: toggleConfirmPassword),
        SizedBox(height: 10),
        MyTextField(
          placeHolder: "Phone Number",
          value: _phoneNumber,
        ),
        SizedBox(height: 10),
        MyTextField(
          placeHolder: "Full Address",
          value: _address,
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            toggleGender();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              height: 48,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Gender",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(isMale ? "Male" : "Female"),
                ],
              ),
              color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Consumer<ProductProvider>(builder: (ctx, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  topPart(),
                  SizedBox(height: 30),
                  bodyPart(),
                  SizedBox(height: 10),
                  provider.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MyButton(
                          text: "Signup",
                          whenPress: () {
                            checkValid(provider);
                          },
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthEndText(
                    firstText: "already have an account",
                    buttonText: "Login",
                    whenPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
