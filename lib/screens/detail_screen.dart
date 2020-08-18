import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../helper/ad_manager.dart';

class DetailScreen extends StatefulWidget {
  final String description;
  final String name;
  final double price;
  final String address;
  final String phoneNumber;
  final String model;
  final String company;
  final String imageUrl;

  DetailScreen(
      {@required this.description,
      @required this.price,
      @required this.address,
      @required this.phoneNumber,
      @required this.model,
      @required this.company,
      @required this.imageUrl,
      @required this.name});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady;

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        break;
      case MobileAdEvent.closed:
        break;
      default:
      // do nothing
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isInterstitialAdReady = false;
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
    _loadInterstitialAd();
    _isInterstitialAdReady == true ? _interstitialAd.show() : Container();
  }

  Widget renderImage({BuildContext ctx, String img}) {
    return Stack(
      children: <Widget>[
        FittedBox(
          child: FadeInImage.assetNetwork(
            image: img,
            fit: BoxFit.cover,
            placeholder: 'assets/car.jpg',
          ),

          // child: Image.network(
          //   img,
          //   fit: BoxFit.fill,
          // ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Color(0x50000000),
          textColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            size: 20,
          ),
          shape: CircleBorder(),
        ),
      ],
    );
  }

  Widget infoDataDouble({BuildContext ctx, String key, double value}) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Theme.of(ctx).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$key:",
            style: TextStyle(fontSize: 17),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget infoDataInt({BuildContext ctx, String key, int value}) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Theme.of(ctx).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$key:",
            style: TextStyle(fontSize: 17),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget infoDataString({BuildContext ctx, String key, String value}) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Theme.of(ctx).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$key:",
            style: TextStyle(fontSize: 17),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          renderImage(ctx: context, img: widget.imageUrl),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Name", value: widget.name),
          SizedBox(height: 10),
          infoDataString(
              ctx: context, key: "Description", value: widget.description),
          SizedBox(height: 10),
          infoDataDouble(ctx: context, key: "Price", value: widget.price),
          SizedBox(height: 10),
          infoDataString(
              ctx: context, key: "Phone Number", value: widget.phoneNumber),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Address", value: widget.address),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Model", value: widget.model),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Company", value: widget.company),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
