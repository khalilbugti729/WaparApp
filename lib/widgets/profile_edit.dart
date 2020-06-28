import 'package:flutter/material.dart';
import 'package:wapar/widgets/my_button.dart';
import 'package:wapar/widgets/my_list_tile.dart';

import 'my_text_field.dart';

class ProfileEdit extends StatefulWidget {
  final Function checkValid;
  final scaffoldKey;

  ProfileEdit({this.scaffoldKey, this.checkValid});

  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phoneNumberPattern =
      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool isMale = true;
  RegExp emailRegix = new RegExp(ProfileEdit.emailPattern);
  RegExp phoneRegix = new RegExp(ProfileEdit.phoneNumberPattern);

  final TextEditingController _email =
      TextEditingController(text: "Khalilbugti@gmail.com");

  final TextEditingController _phoneNumber =
      TextEditingController(text: "03224545699");

  final TextEditingController _fullName =
      TextEditingController(text: "Khalil Bugti");

  String _gender = "Male";

  final TextEditingController _address =
      TextEditingController(text: "Phong Colony Sui");

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

  void checkValid() {
    bool fullName = _fullName.text.trim().isEmpty;
    bool phoneNumber = _phoneNumber.text.trim().isEmpty;
    bool email = _email.text.trim().isEmpty;
    bool myAddress = _address.text.trim().isEmpty;

    if (fullName && phoneNumber && email && myAddress) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("All Fields Empty"),
        ),
      );
      return;
    }

    if (fullName) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Name is Empty"),
        ),
      );
      return;
    }
    if (email) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Email is Empty"),
        ),
      );
      return;
    }

    if (!emailRegix.hasMatch(_email.text)) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Email is not Valid"),
        ),
      );
      return;
    }
    if (phoneNumber) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number is Empty"),
        ),
      );
      return;
    }

    if (!phoneRegix.hasMatch(_phoneNumber.text)) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number must be 11 numbers"),
        ),
      );
      return;
    }

    if (myAddress) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Address is empty"),
        ),
      );
      return;
    }
    widget.checkValid(
        email: _email.text,
        address: _address.text,
        fullName: _fullName.text,
        gender: _gender,
        phoneNumber: int.parse(_phoneNumber.text));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MyTextField(
          placeHolder: "Full Name",
          value: _fullName,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Email",
          value: _email,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Phone Number",
          value: _phoneNumber,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            toggleGender();
          },
          child: MyListTile(
            myKey: "Gender",
            value: isMale ? 'Male' : "Female",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Address",
          value: _address,
        ),
        SizedBox(
          height: 10,
        ),
        MyButton(
          text: "Update",
          whenPress: () {
            checkValid();
          },
        )
      ],
    );
  }
}
