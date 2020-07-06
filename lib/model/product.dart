import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  String productId;
  String imageUrl;
  String imagePath;
  Timestamp timeStamp;
  String productType;
  String userId;
  String productName;
  String productDescription;
  double productPrice;
  String productAddress;
  String productCompany;
  String productModel;
  String productPhoneNumber;
  Product({
    @required this.imagePath,
    @required this.productId,
    @required this.imageUrl,
    @required this.timeStamp,
    @required this.productType,
    @required this.userId,
    @required this.productPhoneNumber,
    @required this.productName,
    @required this.productDescription,
    @required this.productAddress,
    @required this.productCompany,
    @required this.productModel,
    @required this.productPrice,
  });
}
