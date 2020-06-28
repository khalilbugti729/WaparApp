import 'package:flutter/material.dart';
import 'my_list_tile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyListTile(
          myKey: "Full Name",
          value: "Khalil Bugti",
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Email",
          value: "khalilbugti@gmail.com",
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Phone Number",
          value: "03227896220",
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Gender",
          value: "Male",
        ),
        SizedBox(
          height: 10,
        ),
        MyListTile(
          myKey: "Address",
          value: "Phong Colony Sui",
        ),
      ],
    );
  }
}
