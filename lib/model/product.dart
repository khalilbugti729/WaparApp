import 'package:flutter/material.dart';

class Product {
  String productType;
  String userId;
  String productName;
  String productDescription;
  double productPrice;
  String productAddress;
  String productCompany;
  String productModel;
  int productPhoneNumber;
  Product({
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
