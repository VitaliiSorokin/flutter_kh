import 'package:flutter/material.dart';
import 'package:image_viewer/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'RalewayBold',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cats Viewer'),
    );
  }
}
