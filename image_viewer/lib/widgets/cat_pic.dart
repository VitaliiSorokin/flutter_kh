import 'package:flutter/material.dart';
import 'package:image_viewer/pages/image_details_page.dart';

class CatPic extends StatefulWidget {
  const CatPic({Key key, this.path}) : super(key: key);
  final String path;

  @override
  _CatPicState createState() => _CatPicState();
}

class _CatPicState extends State<CatPic> {
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(widget.path),
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () {
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => ImageDetailsPage(
                        assetPath: widget.path,
                      )));
        },
      ),
    );
  }
}
