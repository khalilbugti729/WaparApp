import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapar/provider/auth_provider.dart';
import 'package:wapar/provider/product_povider.dart';
import 'package:wapar/screens/admin.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/signup_screen.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
          lazy: false,
        ),
      ],
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
        home: SignupScreen(),
      ),
    );
  }
}
