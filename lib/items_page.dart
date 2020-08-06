import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  final String filter;

  const ItemsPage({Key key, this.filter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, int index) {
        if (filter == "none")
          return ListTile(title: Text("Item $index"));
        else if (filter == "even") {
          return ListTile(title: Text("Item ${index * 2}"));
        } else {
          return ListTile(title: Text("Item ${index * 2 + 1}"));
        }
      },
      itemCount: 100,
    );
  }
}
