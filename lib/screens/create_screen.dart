import 'package:flutter/material.dart';
import 'package:wapar/widgets/my_text_field.dart';

class CreateScreen extends StatelessWidget {
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescription = TextEditingController();
  TextEditingController _productPrice = TextEditingController();
  TextEditingController _productAddress = TextEditingController();
  TextEditingController _productCompany = TextEditingController();
  TextEditingController _productModel = TextEditingController();
  TextEditingController _productPhoneNumber = TextEditingController();

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
          value: _productAddress,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints.expand(height: 200),
          color: Colors.amber,
          child: Image.asset(
            "assets/k.jpg",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
