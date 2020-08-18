import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/about.dart';
import 'package:wapar/screens/admin.dart';
import 'package:wapar/screens/contact.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/login_screen.dart';
import 'package:wapar/screens/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  ProductProvider provider;
  User myUser;

  @override
  initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchUserData();
    myUser = provider.getUserData;
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
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(myUser.userImageUrl),
              ),
              accountName: Text(myUser.userName),
              accountEmail: Text(myUser.userEmail),
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => ProfileScreen(user: myUser)));
              },
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.info,
              myText: "About",
              whenPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => About()));
              },
            ),
            SizedBox(
              height: 8,
            ),
            singleListTile(
              myIcon: Icons.call,
              myText: "Contact",
              whenPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => Contact()));
              },
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
}
