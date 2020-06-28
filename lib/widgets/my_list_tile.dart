import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String myKey;
  final String value;
  MyListTile({this.myKey, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        height: 49,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              myKey,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        color: Theme.of(context).primaryColor);
  }
}
