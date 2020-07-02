import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  Widget productListView(ctx, index) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        margin: EdgeInsets.only(top: 10),
        color: Theme.of(ctx).primaryColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text("2400"),
            ),
            Expanded(
              child: Text("Tractor"),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(ctx).accentColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(ctx).errorColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: productListView,
      itemCount: 1,
    );
  }
}
