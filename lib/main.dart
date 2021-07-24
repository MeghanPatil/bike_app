import 'package:flutter/material.dart';
import 'package:bike_app/JsonImageList.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: JsonImageList(),
      debugShowCheckedModeBanner: false,
    );
  }
}


