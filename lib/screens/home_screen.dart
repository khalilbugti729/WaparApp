import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/admin.dart';
import 'package:wapar/screens/login_screen.dart';
import 'package:wapar/screens/profile_screen.dart';
import 'package:wapar/widgets/single_product.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     var provider = Provider.of<ProductProvider>(context, listen: false);
  //     provider.fetchProducts();
  //   });
  // }
  Widget myDrawer() {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/k.jpg"),
              ),
              accountName: Text("khalil"),
              accountEmail: Text("khaliljan924@gmail.com"),
            ),
            singleListTile(
              myIcon: Icons.home,
              myText: "Home",
              whenPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => HomeScreen()));
              },
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.add,
              myText: "Admin",
              whenPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Admin(0, null)));
              },
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.category,
              myText: "Category",
              whenPressed: () {},
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.person,
              myText: "Profile",
              whenPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => ProfileScreen()));
              },
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.info,
              myText: "About",
              whenPressed: () {},
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.call,
              myText: "Contact",
              whenPressed: () {},
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.exit_to_app,
              myText: "Logout",
              whenPressed: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => LoginScreen(),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget singleListTile(
      {IconData myIcon, String myText, Function whenPressed}) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        onTap: whenPressed,
        leading: Icon(
          myIcon,
          color: Colors.white,
        ),
        title: Text(myText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Wapar"),
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
