import 'package:flutter/material.dart';
import 'package:wapar/screens/detail_screen.dart';

class SingleProduct extends StatelessWidget {
  final String type;
  final String company;
  final String model;
  final double price;
  final String description;
  final String address;
  final String phoneNumber;
  final String image;
  final String name;
  SingleProduct(
      {this.phoneNumber,
      this.type,
      this.name,
      this.image,
      this.description,
      this.address,
      this.company,
      this.model,
      this.price});

  Widget headPart(context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/k.jpg'),
        ),
        title: Text(
          "Khalil Bugti",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          type,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          "3 hours ago",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget imagePart(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => DetailScreen(
              description: description,
              price: price,
              address: address,
              phoneNumber: phoneNumber,
              model: model,
              company: company,
              image: image,
              name: name,
            ),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 300),
        child: Image.asset(
          "assets/k.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget bottomPart(context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Rs:${price.toString()}',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            company,
            style: TextStyle(fontSize: 17),
          ),
          Text(
            model,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          headPart(context),
          imagePart(context),
          bottomPart(context),
        ],
      ),
    );
  }
}
