import 'package:flutter/material.dart';
import 'package:wapar/model/product.dart';
import 'package:wapar/screens/create_screen.dart';
import 'package:wapar/screens/edit_screen.dart';
import 'package:wapar/screens/home_screen.dart';
import 'package:wapar/screens/list_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../helper/ad_manager.dart';

class Admin extends StatefulWidget {
  final pageIndex;
  final Product product;
  Admin(this.pageIndex, this.product);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool _isRewardedAdReady;

  void _loadRewardedAd() {
    RewardedVideoAd.instance.load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    );
  }

  void _onRewardedAdEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        setState(() {
          _isRewardedAdReady = true;
        });
        break;
      case RewardedVideoAdEvent.closed:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        setState(() {
          _isRewardedAdReady = false;
        });
        break;
      case RewardedVideoAdEvent.rewarded:
        break;
      default:
      // do nothing
    }
  }

  @override
  void initState() {
    super.initState();
    _isRewardedAdReady = false;
    RewardedVideoAd.instance.listener = _onRewardedAdEvent;
    _loadRewardedAd();
    RewardedVideoAd.instance.show();
  }

  @override
  void dispose() {
    RewardedVideoAd.instance.listener = null;
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.pageIndex,
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
                widget.product,
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
