import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/product_povider.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (_) => ProductProvider(),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Color(0xff022534),
          accentColor: Color(0xff2d7a9c),
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.blue,
          ),
        ),
        // home: FutureBuilder(
        //   future: FirebaseAuth.instance.currentUser(),
        //   builder: (ctx, snapShot) {
        //     if (snapShot.hasData) {
        //       return HomeScreen();
        //     }
        //     return LoginScreen();
        //   },
        // ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return HomeScreen();
              }
              return LoginScreen();
            }),
      ),
    );
  }
}
