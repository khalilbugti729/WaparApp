import 'package:flutter/material.dart';

class User {
  String userName;
  String userId;
  String userImageUrl;
  String userAddress;
  String userPhoneNumber;
  String userEmail;
  String userGender;
  String userImagePath;
  User({
    @required this.userPhoneNumber,
    @required this.userId,
    @required this.userImageUrl,
    @required this.userImagePath,
    @required this.userEmail,
    @required this.userGender,
    @required this.userAddress,
    @required this.userName,
  });
}
