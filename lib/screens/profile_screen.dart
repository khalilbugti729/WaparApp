import 'package:flutter/material.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool editMode = false;

  void _checkValid(
      {String email,
      String address,
      String fullName,
      String gender,
      int phoneNumber}) {
    if (_image == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Photo is Empty"),
        ),
      );
      return;
    }
    ////////Update User Data goes there.......
  }

  void editButton() {
    setState(() {
      editMode = true;
    });
  }

  void closeButton() {
    setState(() {
      editMode = false;
    });
  }

  File _image;

  Future profileImage(ImageSource mySource) async {
    final pickedFile = await ImagePicker()
        .getImage(
          source: mySource,
          imageQuality: 80,
        )
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

  Widget topPart(context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image == null
                    ? AssetImage("assets/k.jpg")
                    : FileImage(_image),
              ),
            ),
            editMode
                ? Positioned(
                    bottom: 60,
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
      ),
    );
  }

  Widget bottomPart(context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: editMode
            ? ProfileEdit(
                scaffoldKey: _scaffoldKey,
                checkValid: _checkValid,
              )
            : Profile(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ///top part
            topPart(context),
            bottomPart(context),
          ],
        ),
      ),
    );
  }
}
