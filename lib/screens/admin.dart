import 'package:flutter/material.dart';
import 'package:wapar/screens/create_screen.dart';
import 'package:wapar/screens/edit_screen.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/list_screen.dart';

class Admin extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            ),
          );
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.add_box)),
              Tab(icon: Icon(Icons.edit)),
              Tab(icon: Icon(Icons.list)),
            ]),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomeScreen(),
                  ),
                );
              },
            ),
            centerTitle: true,
            title: Text("Admin"),
          ),
          body: TabBarView(
            children: [
              CreateScreen(
                scaffoldKey: _scaffoldKey,
              ),
              EditScreen(),
              ListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
