import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/widgets/my_button.dart';
import 'package:wapar/widgets/my_list_tile.dart';
import 'package:wapar/widgets/my_text_field.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {
  final scaffoldKey;
  CreateScreen({this.scaffoldKey});

  static Pattern phoneNumberPattern =
      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  RegExp phoneRegix = new RegExp(CreateScreen.phoneNumberPattern);

  TextEditingController _productName = TextEditingController();

  TextEditingController _productDescription = TextEditingController();

  TextEditingController _productPrice = TextEditingController();

  TextEditingController _productAddress = TextEditingController();

  TextEditingController _productCompany = TextEditingController();

  TextEditingController _productModel = TextEditingController();

  TextEditingController _productPhoneNumber = TextEditingController();
  String productType = 'USED';

  void toggleProductType() {
    setState(() {
      productType == 'USED' ? productType = 'NEW' : productType = "USED";
    });
  }

  File _image;

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

  Future profileImage(ImageSource mySource) async {
    final pickedFile = await ImagePicker()
        .getImage(
            source: mySource, imageQuality: 75, maxHeight: 1024, maxWidth: 1536)
        .whenComplete(() => Navigator.of(context).pop());
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void checkVerify(ProductProvider provider) async {
    Object value = await provider.addProduct(
      productType: productType,
      address: _productAddress.text,
      company: _productCompany.text,
      description: _productDescription.text,
      model: _productModel.text,
      name: _productName.text,
      phoneNumber: _productPhoneNumber.text,
      price: _productPrice.text,
      image: _image,
    );
    if (value == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
    widget.scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: value == null ? Container() : Text(value),
      ),
    );
  }

  void checkValid(context, ProductProvider provider) {
    bool productName = _productName.text.trim().isEmpty;
    bool productDescription = _productDescription.text.trim().isEmpty;
    bool productPrice = _productPrice.text.trim().isEmpty;
    bool productAddress = _productAddress.text.trim().isEmpty;
    bool productCompany = _productCompany.text.trim().isEmpty;
    bool productModel = _productModel.text.trim().isEmpty;
    bool productPhoneNumber = _productPhoneNumber.text.trim().isEmpty;

    if (productName &&
        productDescription &&
        productPrice &&
        productAddress &&
        productModel &&
        productPhoneNumber &&
        productCompany) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("All Fields are Empty"),
        ),
      );
      return;
    }

    if (productName) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Name is Empty"),
        ),
      );
      return;
    }

    if (productCompany) {
      print("company is empy");
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Company is Empty"),
        ),
      );
      return;
    }

    if (productModel) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Model is Empty"),
        ),
      );
      return;
    }

    if (productPrice) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Price is Empty"),
        ),
      );
      return;
    }

    if (productAddress) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Address is Empty"),
        ),
      );
      return;
    }
    if (productDescription) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Product Description is Empty"),
        ),
      );
      return;
    }

    if (productPhoneNumber) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number is Empty"),
        ),
      );
      return;
    }

    if (!phoneRegix.hasMatch(_productPhoneNumber.text)) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Phone Number must be 11 numbers"),
        ),
      );
      return;
    }
    if (_image == null) {
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text("Photo is Empty"),
        ),
      );
      return;
    }
    checkVerify(provider);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Name",
          value: _productName,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Company",
          value: _productCompany,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Model",
          value: _productModel,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Price",
          value: _productPrice,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            toggleProductType();
          },
          child: MyListTile(
            myKey: 'ProductType',
            value: productType,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Address",
          value: _productAddress,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Product Description",
          value: _productDescription,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          placeHolder: "Phone Number",
          value: _productPhoneNumber,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            _showMyDialog();
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(height: 200),
            child: _image == null
                ? Image.asset(
                    "assets/car.png",
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Consumer<ProductProvider>(
          builder: (ctx, provider, child) {
            return provider.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : MyButton(
                    text: "Submit",
                    whenPress: () {
                      checkValid(context, provider);
                    },
                  );
          },
        )
      ],
    );
  }
}
