import 'package:flutter/material.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({Key key, @required this.assetPath})
      : assert(assetPath != null),
        super(key: key);
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Center(
          child: Image.asset(this.assetPath),
        ));
  }
}
