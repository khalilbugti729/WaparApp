import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String description;
  final String name;
  final double price;
  final String address;
  final String phoneNumber;
  final String model;
  final String company;
  final String image;

  DetailScreen(
      {@required this.description,
      @required this.price,
      @required this.address,
      @required this.phoneNumber,
      @required this.model,
      @required this.company,
      @required this.image,
      @required this.name});

  Widget renderImage({BuildContext ctx, String img}) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 370),
          child: Image.asset(img),
        ),
        Positioned(
          top: 30,
          left: -15,
          child: FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
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
      body: Column(
        children: <Widget>[
          renderImage(ctx: context, img: image),
          Expanded(
              child: infoDataString(ctx: context, key: "Name", value: name)),
          SizedBox(height: 10),
          Expanded(
              child: infoDataString(
                  ctx: context, key: "Description", value: description)),
          SizedBox(height: 10),
          Expanded(
              child: infoDataDouble(ctx: context, key: "Price", value: price)),
          SizedBox(height: 10),
          Expanded(
              child: infoDataString(
                  ctx: context, key: "Phone Number", value: phoneNumber)),
          SizedBox(height: 10),
          Expanded(
              child:
                  infoDataString(ctx: context, key: "Address", value: address)),
          SizedBox(height: 10),
          Expanded(
              child: infoDataString(ctx: context, key: "Model", value: model)),
          SizedBox(height: 10),
          Expanded(
              child:
                  infoDataString(ctx: context, key: "Company", value: company)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
