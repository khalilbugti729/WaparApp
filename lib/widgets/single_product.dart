import 'package:flutter/material.dart';
import 'package:wapar/screens/detail_screen.dart';

class SingleProduct extends StatefulWidget {
  final String company;
  final String model;
  final double price;

  SingleProduct({this.company, this.model, this.price});

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  Widget headPart() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/k.jpg'),
      ),
      title: Text(
        "Khalil Bugti",
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "New",
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        "3 hours ago",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget imagePart() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => DetailScreen(
                description: 'Box is available',
                price: "4500",
                address: "phong Colony",
                phoneNumber: "12345678",
                model: "j7",
                company: "Samsung",
                image: 'assets/k.jpg',
                name: "Car"),
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

  Widget bottomPart() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Rs:4000",
            style: TextStyle(fontSize: 17),
          ),
          Text(
            "Samsung",
            style: TextStyle(fontSize: 17),
          ),
          Text(
            "j7 Pro",
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 5)),
      child: Column(
        children: <Widget>[
          headPart(),
          imagePart(),
          bottomPart(),
        ],
      ),
    );
  }
}
