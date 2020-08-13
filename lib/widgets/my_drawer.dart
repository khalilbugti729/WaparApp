import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wapar/model/user.dart';
import 'package:wapar/screens/admin.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/login_screen.dart';
import 'package:wapar/screens/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  final User user;
  MyDrawer(this.user);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget.user.userImageUrl),
            ),
            accountName: Text(widget.user.userName),
            accountEmail: Text(widget.user.userEmail),
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => Admin(0, null)));
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
    );
  }
}
