import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/widgets/profile.dart';
import '../widgets/profile_edit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // void waitData() async {
  //   ProductProvider provider =
  //       Provider.of<ProductProvider>(context, listen: false);
  //   await provider.fetchUserData();
  // }

  // var user;
  // @override
  // initState() {
  //   super.initState();
  //   waitData();
  // }
  var user;

  getUserId() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool editMode = false;

  void _checkVerify(
      {String email,
      String address,
      String fullName,
      String gender,
      String phoneNumber,
      String userImageUrl,
      String userImagePath}) async {
    var userImage = _image == null ? userImageUrl : _image;

    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    Object value = await provider.updateUser(
      address: address,
      email: email,
      fullName: fullName,
      gender: gender,
      phoneNumber: phoneNumber,
      userImagePath: userImagePath,
      userImageUrl: userImage,
    );

    if (value == null) {
      closeButton();
    }

    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     backgroundColor: Theme.of(context).errorColor,
    //     content: Text("Updation Failed"),
    //   ),
    // );
  }

  void editButton() {
    setState(() {
      editMode = true;
    });
  }

  void closeButton() {
    setState(() {
      FocusScope.of(context).unfocus();
      editMode = false;
    });
  }

  File _image;

  Future profileImage(ImageSource mySource) async {
    final pickedFile = await ImagePicker()
        .getImage(
            source: mySource, imageQuality: 80, maxHeight: 480, maxWidth: 720)
        .whenComplete(() => Navigator.of(context).pop());
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        onPressed: () {
                          profileImage(ImageSource.camera);
                        }),
                    Text("Camera"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        onPressed: () {
                          profileImage(ImageSource.gallery);
                        }),
                    Text("Gallery"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topPart(context, imageUrl) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
                  _image == null ? NetworkImage(imageUrl) : FileImage(_image),
            ),
          ),
          editMode
              ? Positioned(
                  bottom: 80,
                  right: 105,
                  child: IconButton(
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      _showMyDialog();
                    },
                  ),
                )
              : Container()
        ],
      ),
      color: Theme.of(context).primaryColor,
    );
  }

  Widget bottomPart(context, ProductProvider provider) {
    User user = provider.getUserData;

    if (provider.loading || user.userImageUrl == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // return FutureBuilder(
    //   future: Firestore.instance.collection("User").getDocuments(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: Padding(
    //           padding: const EdgeInsets.only(top: 50),
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //     List<DocumentSnapshot> data = snapshot.data.documents;
    //     data.forEach((element) async {
    //       if (element['userId'] == user.uid) {
    //         userData = element;
    //       }
    //     });
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: editMode
            ? ProfileEdit(
                scaffoldKey: _scaffoldKey,
                checkValid: _checkVerify,
                userData: user,
              )
            : Profile(
                userData: user,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider provider = Provider.of<ProductProvider>(context);
    User user = provider.getUserData;
    if (provider.loading || user.userImageUrl == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    String imageUrl = user.userImageUrl;
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                editButton();
              },
              icon: Text("Edit"),
            )
          ],
          leading: IconButton(
            icon: editMode ? Icon(Icons.close) : Icon(Icons.arrow_back),
            onPressed: () {
              editMode
                  ? closeButton()
                  : Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomeScreen(),
                      ),
                    );
            },
          ),
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: Column(
          children: <Widget>[
            topPart(
              context,
              imageUrl,
            ),
            bottomPart(context, provider),
          ],
        ),
      ),
    );
  }
}
