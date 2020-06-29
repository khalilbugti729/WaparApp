import 'package:flutter/material.dart';

class Product {
  String productName;
  String productDescription;
  String productPrice;
  String productAddress;
  String productCompany;
  String productModel;
  int productPhoneNumber;
  Product({
    @required this.productPhoneNumber,
    @required this.productName,
    @required this.productDescription,
    @required this.productAddress,
    @required this.productCompany,
    @required this.productModel,
    @required this.productPrice,
  });
}
