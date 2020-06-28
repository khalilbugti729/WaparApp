import 'package:flutter/material.dart';
import 'package:wapar/screens/admin.dart';
import 'package:wapar/screens/profile_screen.dart';
import 'package:wapar/widgets/single_product.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        backgroundColor: Color(0xff022534),
        drawer: Drawer(
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
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => Admin()));
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
                  whenPressed: () {},
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text("Wapar"),
        ),
        body: ListView(
          children: <Widget>[
            SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
            SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
            SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
            SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
            SingleProduct(company: "Samsung", price: 250.0, model: "A7 pro"),
          ],
        ));
  }
}
