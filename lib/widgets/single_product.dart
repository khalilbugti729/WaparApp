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
  final String imageUrl;
  final String name;
  final String time;
  SingleProduct(
      {this.time,
      this.phoneNumber,
      this.type,
      this.name,
      this.imageUrl,
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
          time,
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
              imageUrl: imageUrl,
              name: name,
            ),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 300),
        child: Image.network(
          imageUrl,
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
          Expanded(
            child: Center(
              child: Text(
                'Rs:${price.toString()}',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                company,
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                model,
                style: TextStyle(fontSize: 17),
              ),
            ),
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
