import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/widgets/my_drawer.dart';
import 'package:wapar/widgets/single_product.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void waitData() async {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    await provider.fetchUserData();
  }

  @override
  initState() {
    super.initState();
    waitData();
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
    return Scaffold(
      drawer: Drawer(
        child: MyDrawer(user),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Wapar"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("Product")
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var document = snapShot.data.documents;
          if (document.length == 0) {
            return Center(
              child: Text("Data not Found"),
            );
          }
          // print(snapShot.hasData);
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  SingleProduct(
                    type: document[index]['productType'],
                    address: document[index]['productAddress'],
                    description: document[index]['productDescription'],
                    imageUrl: document[index]['imageUrl'],
                    name: document[index]['productName'],
                    phoneNumber: document[index]['productPhoneNumber'],
                    company: document[index]['productCompany'],
                    price: double.parse(document[index]['productPrice']),
                    model: document[index]['productModel'],
                  ),
                ],
              );
            },
            itemCount: document.length,
          );
          // children: <Widget>[
          //   SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          //   SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          //   SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          //   SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          //   SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          // ],
        },
      ),
    );
  }
}
