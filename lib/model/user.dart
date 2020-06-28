import 'package:flutter/material.dart';

class User {
  String userName;
  String userId;
  String userImage;
  String userAddress;
  int userPhoneNumber;
  String userEmail;
  String userGender;
  User({
    @required this.userPhoneNumber,
    @required this. userId,
    @required this.userImage,
    @required this. userEmail,
    @required this. userGender,
    @required this. userAddress,
    @required this.userName, 
  });
}
