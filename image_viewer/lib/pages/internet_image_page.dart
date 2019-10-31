import 'package:flutter/material.dart';

class InternetImagePage extends StatelessWidget {
  const InternetImagePage({Key key, @required this.assetPath})
      : assert(assetPath != null),
        super(key: key);

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cat From Your URL'),
        ),
        body: Center(
          // child: Image.network(this.assetPath)
          child: FadeInImage.assetNetwork(
              placeholder: 'resources/cats/no.jpg', image: this.assetPath),
        ));
  }
}
