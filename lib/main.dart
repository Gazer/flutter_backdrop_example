import 'package:backdrop_example/backdrop_widget.dart';
import 'package:backdrop_example/items_filters.dart';
import 'package:flutter/material.dart';

import 'items_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String filter = "none";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backdrop Example',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BackdropWidget(
        frontLayer: ItemsPage(
          filter: filter,
        ),
        frontTitle: Text("Items"),
        backLayer: ItemsFilters(
          onFilterChange: (f) {
            setState(() {
              filter = f;
            });
          },
        ),
        backTitle: Text("Filtrar"),
      ),
    );
  }
}
