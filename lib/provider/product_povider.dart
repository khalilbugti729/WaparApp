import 'dart:collection';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:wapar/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  var _auth = FirebaseAuth.instance;
  var _db = Firestore.instance;

  AuthResult authResult;
  bool get loading => _isLoading;

  List<Product> _allProducts = [];
  // Product _updateProduct;

  // get updateProduct {
  //   return _updateProduct;
  // }

  // Future<QuerySnapshot> currentUserData() async {
  //   var snapshot =
  //       await Firestore.instance.collection('Product').getDocuments();
  //   return snapshot;
  // }

  UnmodifiableListView get allProducts => UnmodifiableListView(_allProducts);

  User _user;
  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileUrl');
    await firebaseStorageRef.delete();
  }

  // void editScreenData(
  //     {String name,
  //     String productType,
  //     String company,
  //     String model,
  //     String price,
  //     String address,
  //     String description,
  //     String phoneNumber,
  //     String image,
  //     Timestamp timeStamp}) async {
  //   var user = await _auth.currentUser();
  //   _updateProduct = Product(
  //     image: 'assets/k.jpg',
  //     timeStamp: timeStamp,
  //     productType: productType,
  //     userId: user.uid,
  //     productPhoneNumber: phoneNumber,
  //     productName: name,
  //     productDescription: description,
  //     productAddress: address,
  //     productCompany: company,
  //     productModel: model,
  //     productPrice: double.parse(price),
  //   );
  // }

  // void fetchProducts() {
  //   _db.collection("Product").snapshots().listen((data) {
  //     data.documents.forEach((element) {
  //       Product product = Product(
  //         productType: element['productType'],
  //         userId: element['userId'],
  //         productPhoneNumber: element['productPhoneNumber'],
  //         productName: element['productName'],
  //         productDescription: element['productDescription'],
  //         productAddress: element['productAddress'],
  //         productCompany: element['productCompany'],
  //         productModel: element['productModel'],
  //         productPrice: element['productPrice'],
  //       );
  //       _allProducts.add(product);
  //       print(_allProducts[0].productCompany);
  //     });
  //   });
  // }

  Future<void> deleteProduct(String productId, String imagePath) async {
    await deleteImage(imagePath);
    await _db.collection('Product').document(productId).delete();
    notifyListeners();
    return;
  }

  Future<Object> updateProduct(
      {String name,
      String productType,
      String company,
      String model,
      String price,
      String address,
      String description,
      String phoneNumber,
      String productId,
      Object imageUrl,
      String imagePath}) async {
    _isLoading = true;
    notifyListeners();
    var id = productId;
    var user = await _auth.currentUser();
    try {
      if (imageUrl is File) {
        Map<String, String> imageData =
            await _uploadFile(imageUrl, editImagePath: imagePath);
        await Firestore.instance.collection("Product").document(id).updateData({
          "userId": user.uid,
          "productPhoneNumber": phoneNumber,
          "productName": name,
          "productDescription": description,
          "productAddress": address,
          "productCompany": company,
          "productModel": model,
          "productPrice": price,
          'productType': productType,
          'timeStamp': Timestamp.now(),
          'imageUrl': imageData['imageUrl'],
          'imagePath': imagePath,
        });
      } else {
        await Firestore.instance.collection("Product").document(id).updateData({
          "userId": user.uid,
          "productPhoneNumber": phoneNumber,
          "productName": name,
          "productDescription": description,
          "productAddress": address,
          "productCompany": company,
          "productModel": model,
          "productPrice": price,
          'productType': productType,
          'timeStamp': Timestamp.now(),
          'imageUrl': imageUrl,
          'imagePath': imagePath,
        });
      }
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }

  Future<Map<String, String>> _uploadSignup(File _image,
      {String editImagePath}) async {
    String _imagePath = editImagePath == null ? _image.path : editImagePath;

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profileImages/${Path.basename(_imagePath)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = (await task.ref.getDownloadURL());

    Map<String, String> _downloadData = {
      'imagePath': Path.basename(_imagePath),
      'imageUrl': _imageUrl
    };
    return _downloadData;
  }

  Future<Map<String, String>> _uploadFile(File _image,
      {String editImagePath}) async {
    String _imagePath = editImagePath == null ? _image.path : editImagePath;

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_imagePath)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = (await task.ref.getDownloadURL());

    Map<String, String> _downloadData = {
      'imagePath': Path.basename(_imagePath),
      'imageUrl': _imageUrl
    };
    return _downloadData;
  }

  Future<Object> addProduct(
      {String name,
      String productType,
      String company,
      String model,
      String price,
      String address,
      String description,
      String phoneNumber,
      File image}) async {
    _isLoading = true;
    notifyListeners();
    Map<String, String> imageData = await _uploadFile(image);
    var user = await _auth.currentUser();
    try {
      DocumentReference documentReference =
          Firestore.instance.collection('Product').document();
      documentReference.setData({
        'productId': documentReference.documentID,
        "userId": user.uid,
        "productPhoneNumber": phoneNumber,
        "productName": name,
        "productDescription": description,
        "productAddress": address,
        "productCompany": company,
        "productModel": model,
        "productPrice": price,
        'imageUrl': imageData['imageUrl'],
        'imagePath': imageData['imagePath'],
        'productType': productType,
        'timeStamp': Timestamp.now(),
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
      String phoneNumber,
      File image,
      String gender,
      String address,
      String fullName}) async {
    try {
      Map<String, String> myImage = await _uploadSignup(image);
      _isLoading = true;
      notifyListeners();
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // = User(
      //     userPhoneNumber: phoneNumber,
      //     userId: authResult.user.uid,
      //     userImage: image,
      //     userEmail: email,
      //     userGender: gender,
      //     userAddress: address,
      //     userName: fullName);

      Firestore.instance
          .collection("User")
          .document(authResult.user.uid)
          .setData({
        "userPhoneNumber": phoneNumber,
        "userId": authResult.user.uid,
        "userImage": myImage['imageUrl'],
        "userPath": myImage['imagePath'],
        "userEmail": email,
        "userGender": gender,
        "userAddress": address,
        'userName': fullName,
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

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();
    var user = await _auth.currentUser();
    QuerySnapshot dataInstance =
        await Firestore.instance.collection("User").getDocuments();
    List<DocumentSnapshot> data = dataInstance.documents;
    data.forEach((element) {
      if (element['userId'] == user.uid) {
        _user = User(
            userImagePath: element['userPath'],
            userPhoneNumber: element['userPhoneNumber'],
            userId: element['userId'],
            userImageUrl: element['userImage'],
            userEmail: element['userEmail'],
            userGender: element['userGender'],
            userAddress: element['userAddress'],
            userName: element['userName']);
      }
    });
    _isLoading = false;
    notifyListeners();
  }

  User get getUserData => _user;

  Future<Object> updateUser(
      {String email,
      String address,
      String fullName,
      String gender,
      String phoneNumber,
      Object userImageUrl,
      String userImagePath}) async {
    // print(email);
    // print(address);
    // print(fullName);
    // print(gender);
    // print(phoneNumber);
    // print(userImageUrl);
    // print(userImagePath);

    _isLoading = true;
    notifyListeners();
    var user = await _auth.currentUser();
    try {
      print(user.uid);
      if (userImageUrl is File) {
        Map<String, String> imageData =
            await _uploadSignup(userImageUrl, editImagePath: userImagePath);
        await Firestore.instance
            .collection("User")
            .document(user.uid)
            .updateData({
          'userName': fullName,
          'userPhoneNumber': phoneNumber,
          'userImage': imageData['imageUrl'],
          'userPath': imageData['imagePath'],
          'userId': user.uid,
          'userEmail': email,
          'userGender': gender,
          'userAddress': address,
        });
      } else {
        await Firestore.instance
            .collection("User")
            .document(user.uid)
            .updateData({
          'userPhoneNumber': phoneNumber,
          'userId': authResult.user.uid,
          'userImage': userImageUrl,
          'userPath': userImagePath,
          'userEmail': email,
          'userGender': gender,
          'userAddress': address,
          'userName': fullName,
        });
      }
      await fetchUserData();
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }
}
