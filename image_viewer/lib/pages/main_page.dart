import 'package:flutter/material.dart';
import 'package:image_viewer/pages/internet_image_page.dart';
import 'package:image_viewer/widgets/cat_pic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> pics = [
    'resources/cats/1.jpg',
    'resources/cats/2.jpg',
    'resources/cats/3.jpg',
    'resources/cats/4.jpg',
    'resources/cats/5.jpg',
    'resources/cats/6.jpg',
  ];

  Widget _buildList() {
    return GridView.builder(
      itemCount: pics.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext ctxt, int index) {
        final picPath = pics[index];
        return CatPic(
          path: picPath,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewImg(context),
        tooltip: 'Add Photo',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

final TextEditingController _textFieldController = TextEditingController();

void _addNewImg(BuildContext context) {
  _textFieldController.clear();
  showDialog<dynamic>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Write image url:'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'IMG URL'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
                _textFieldController.clear();
              },
            ),
            FlatButton(
              child: Text('ADD'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (context) => InternetImagePage(
                              assetPath: _textFieldController.text,
                            )));
              },
            )
          ],
        );
      });
}
