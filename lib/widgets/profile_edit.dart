import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/widgets/my_button.dart';
import 'package:wapar/widgets/my_list_tile.dart';

import 'my_text_field.dart';

class ProfileEdit extends StatefulWidget {
  final Function checkValid;
  final scaffoldKey;
  final User userData;

  ProfileEdit({this.scaffoldKey, this.checkValid, this.userData});

  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phoneNumberPattern =
      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String email;

  TextEditingController _phoneNumber;

  TextEditingController _fullName;

  String _gender;

  TextEditingController _address;
  bool isMale = true;
  RegExp phoneRegix = new RegExp(ProfileEdit.phoneNumberPattern);

  @override
  void initState() {
    super.initState();

    email = widget.userData.userEmail;
    _phoneNumber = TextEditingController(text: widget.userData.userPhoneNumber);
    _gender = widget.userData.userGender;
    _fullName = TextEditingController(text: widget.userData.userName);
    _address = TextEditingController(text: widget.userData.userAddress);
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

  void checkValid() {
    bool fullName = _fullName.text.trim().isEmpty;
    bool phoneNumber = _phoneNumber.text.trim().isEmpty;
    bool myAddress = _address.text.trim().isEmpty;

    if (fullName && phoneNumber && myAddress) {
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
        email: email,
        address: _address.text,
        fullName: _fullName.text,
        gender: _gender,
        phoneNumber: _phoneNumber.text,
        userImageUrl: widget.userData.userImageUrl,
        userImagePath: widget.userData.userImagePath);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider provider = Provider.of<ProductProvider>(context);
    return ListView(
      children: <Widget>[
        MyTextField(
          placeHolder: "Full Name",
          value: _fullName,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            widget.scaffoldKey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).errorColor,
                content: Text("Email cannot change"),
              ),
            );
          },
          child: MyListTile(
            myKey: "Email",
            value: email,
          ),
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
        provider.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MyButton(
                text: "Update",
                whenPress: () {
                  checkValid();
                },
              )
      ],
    );
  }
}
