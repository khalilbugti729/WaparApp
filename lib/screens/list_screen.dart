import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/product.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/admin.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var user;
  @override
  initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  Widget productListView(ctx, index, document) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        margin: EdgeInsets.only(top: 10),
        color: Theme.of(ctx).primaryColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                document[index]['productPrice'],
              ),
            ),
            Expanded(
              child: Text(
                document[index]['productName'],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(ctx).accentColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              Product product = Product(
                                productId: document[index]['productId'],
                                timeStamp: document[index]['timeStamp'],
                                imageUrl: document[index]['imageUrl'],
                                productType: document[index]['productType'],
                                userId: document[index]['userId'],
                                productPhoneNumber: document[index]
                                    ['productPhoneNumber'],
                                productName: document[index]['productName'],
                                productDescription: document[index]
                                    ['productDescription'],
                                productAddress: document[index]
                                    ['productAddress'],
                                productCompany: document[index]
                                    ['productCompany'],
                                productModel: document[index]['productModel'],
                                productPrice: double.parse(
                                    document[index]['productPrice']),
                                imagePath: document[index]['imagePath'],
                              );
                              print("from List screen2 ");
                              print(product.imagePath);
                              // ProductProvider provider =
                              //     Provider.of<ProductProvider>(context);
                              // provider.editScreenData(
                              //   address: document[index]['productAddress'],
                              //   company: document[index]['productCompany'],
                              //   description: document[index]
                              //       ['productDescription'],
                              //   image: 'assets/k.jpg',
                              //   model: document[index]['productModel'],
                              //   name: document[index]['productName'],
                              //   phoneNumber: document[index]
                              //       ['productPhoneNumber'],
                              //   price: document[index]['productPrice'],
                              //   productType: document[index]['productType'],
                              //   timeStamp: document[index]['timeStamp'],
                              // );
                              return Admin(1, product);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(ctx).errorColor,
                      ),
                      onPressed: () {
                        _showMyDialog(document[index]['productId'],
                            document[index]['imagePath']);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _showMyDialog(String productId, String imagePath) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("are you sure?"),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                              color: Colors.red[400],
                              onPressed: () {
                                ProductProvider provider =
                                    Provider.of<ProductProvider>(context,
                                        listen: false);
                                provider.deleteProduct(productId, imagePath);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ))),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No"))),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('Product').getDocuments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var document = snapshot.data.documents;
        if (document.length == 0) {
          return Center(
            child: Text("Nothing to View"),
          );
        }

        return ListView.builder(
            itemCount: document.length,
            itemBuilder: (ctx, index) {
              if (user.uid == document[index]['userId']) {
                return productListView(ctx, index, document);
              }
              return Container();
            });
      },
    );
  }
}
