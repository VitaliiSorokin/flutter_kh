import 'package:flutter/material.dart';
import 'package:image_viewer/pages/image_details_page.dart';

class CatPic extends StatelessWidget {
  const CatPic({Key key, this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(path),
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () {
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => ImageDetailsPage(
                        assetPath: path,
                      )));
        },
      ),
    );
  }
}
