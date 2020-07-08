import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
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

  Widget renderImage({BuildContext ctx, String img}) {
    return Stack(
      children: <Widget>[
        FittedBox(
          // constraints: BoxConstraints.expand(height: 370),
          child: Image.network(
            img,
            fit: BoxFit.fill,
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ), // IconButton(icon: Icon(Icons.arrow_back), onPressed: () {})
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
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          renderImage(ctx: context, img: imageUrl),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Name", value: name),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Description", value: description),
          SizedBox(height: 10),
          infoDataDouble(ctx: context, key: "Price", value: price),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Phone Number", value: phoneNumber),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Address", value: address),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Model", value: model),
          SizedBox(height: 10),
          infoDataString(ctx: context, key: "Company", value: company),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
