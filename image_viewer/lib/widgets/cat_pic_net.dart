import 'package:flutter/material.dart';
import 'package:image_viewer/pages/internet_image_page.dart';

class CatPicNet extends StatelessWidget {
  const CatPicNet({Key key, this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: NetworkImage(path), // TODO ?
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () {
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => InternetImagePage(
                        assetPath: path,
                      )));
        },
      ),
    );
  }
}
