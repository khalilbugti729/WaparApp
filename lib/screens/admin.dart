import 'package:flutter/material.dart';
import 'package:wapar/model/product.dart';
import 'package:wapar/screens/create_screen.dart';
import 'package:wapar/screens/edit_screen.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/list_screen.dart';

class Admin extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final pageIndex;
  final Product product;
  Admin(this.pageIndex, this.product);
  // TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = new TabController(vsync: this, length: 3);
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: pageIndex,
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
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.add_box),
                ),
                Tab(
                  icon: Icon(Icons.edit),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ],
              // controller: _tabController,
            ),
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
            // controller: _tabController,
            children: [
              CreateScreen(
                scaffoldKey: _scaffoldKey,
              ),
              EditScreen(
                product,
                scaffoldKey: _scaffoldKey,
              ),
              ListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
