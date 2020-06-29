import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  var _auth = FirebaseAuth.instance;
  AuthResult authResult;

  bool get loading {
    return _loading;
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
      _loading = true;
      notifyListeners();
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = User(
          userPhoneNumber: phoneNumber,
          userId: authResult.user.uid,
          userImage: image,
          userEmail: email,
          userGender: gender,
          userAddress: address,
          userName: fullName);

      Firestore.instance.collection("User").document(user.userId).setData({
        "userPhoneNumber": user.userPhoneNumber,
        "userId": user.userId,
        "userImage": user.userImage,
        "userEmail": user.userEmail,
        "userGender": user.userGender,
        "userAddress": user.userAddress
      });
      _loading = false;
      notifyListeners();
      return null;
    } on PlatformException catch (error) {
      _loading = false;
      notifyListeners();
      var message = "error: Check your inputs";
      if (error.message != null) {
        return message = error.message;
      }
      return message;
    } catch (error) {
      _loading = false;
      notifyListeners();
      return error;
    }
  }

  Future<Object> login({
    String email,
    String password,
  }) async {
    try {
      _loading = true;
      notifyListeners();
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _loading = false;
      notifyListeners();
      return null;
    } on PlatformException catch (error) {
      _loading = false;
      notifyListeners();
      var message = "error: Check your inputs";
      if (error.message != null) {
        return message = error.message;
      }
      return message;
    } catch (error) {
      _loading = false;
      notifyListeners();
      return error;
    }
  }
}
