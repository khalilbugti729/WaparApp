import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:wapar/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  User _authenticatedUser;
  var _auth = FirebaseAuth.instance;
  var _db = Firestore.instance;
  AuthResult authResult;
  bool get loading => _isLoading;

  List<Product> _allProducts = [];

  UnmodifiableListView get allProducts => UnmodifiableListView(_allProducts);

  void fetchProducts() {
    _db.collection("Product").snapshots().listen((data) {
      data.documents.forEach((element) {
        Product product = Product(
          productType: element['productType'],
          userId: element['userId'],
          productPhoneNumber: element['productPhoneNumber'],
          productName: element['productName'],
          productDescription: element['productDescription'],
          productAddress: element['productAddress'],
          productCompany: element['productCompany'],
          productModel: element['productModel'],
          productPrice: element['productPrice'],
        );
        _allProducts.add(product);
        print(_allProducts[0].productCompany);
      });
    });
  }

  Future<Object> addProduct(
      {String name,
      String productType,
      String company,
      String model,
      String price,
      String address,
      String description,
      String phoneNumber}) async {
    print(phoneNumber);
    _isLoading = true;
    notifyListeners();
    try {
      var productId = await Firestore.instance.collection("Product").add({
        "userId": 'authResult.user.uid',
        "productPhoneNumber": phoneNumber,
        "productName": name,
        "productDescription": description,
        "productAddress": address,
        "productCompany": company,
        "productModel": model,
        "productPrice": price,
        'productType': productType,
      });
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }

  Future<Object> signUp(
      {String email,
      String password,
      int phoneNumber,
      String image,
      String gender,
      String address,
      String fullName}) async {
    try {
      _isLoading = true;
      notifyListeners();
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _authenticatedUser = User(
          userPhoneNumber: phoneNumber,
          userId: authResult.user.uid,
          userImage: image,
          userEmail: email,
          userGender: gender,
          userAddress: address,
          userName: fullName);

      Firestore.instance
          .collection("User")
          .document(_authenticatedUser.userId)
          .setData({
        "userPhoneNumber": _authenticatedUser.userPhoneNumber,
        "userId": _authenticatedUser.userId,
        "userImage": _authenticatedUser.userImage,
        "userEmail": _authenticatedUser.userEmail,
        "userGender": _authenticatedUser.userGender,
        "userAddress": _authenticatedUser.userAddress
      });
      _isLoading = false;
      notifyListeners();
      return null;
    } on PlatformException catch (error) {
      _isLoading = false;
      notifyListeners();
      var message = "error: Check your inputs";
      if (error.message != null) {
        return message = error.message;
      }
      return message;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }

  Future<Object> login({
    String email,
    String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _isLoading = false;
      notifyListeners();
      return null;
    } on PlatformException catch (error) {
      _isLoading = false;
      notifyListeners();
      var message = "error: Check your inputs";
      if (error.message != null) {
        return message = error.message;
      }
      return message;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }
}
