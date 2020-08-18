import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/provider/product_povider.dart';
import 'my_list_tile.dart';

class Profile extends StatelessWidget {
  final User userData;
  Profile({this.userData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MyListTile(
          myKey: "Full Name",
          value: userData.userName,
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Email",
          value: userData.userEmail,
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Phone Number",
          value: userData.userPhoneNumber,
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Gender",
          value: userData.userGender,
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Address",
          value: userData.userAddress,
        ),
      ],
    );
  }
}
