import 'package:flutter/material.dart';

class ItemsFilters extends StatelessWidget {
  final Function(String) onFilterChange;

  const ItemsFilters({Key key, this.onFilterChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          FlatButton(
            child: Text("Pares"),
            onPressed: () {
              onFilterChange("even");
            },
          ),
          SizedBox(height: 10),
          FlatButton(
            child: Text("Impares"),
            onPressed: () {
              onFilterChange("odd");
            },
          ),
        ],
      ),
    );
  }
}
