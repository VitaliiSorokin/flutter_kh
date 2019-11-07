import 'package:flutter/material.dart';
import 'package:image_viewer/pages/internet_image_page.dart';
import 'package:image_viewer/widgets/cat_pic.dart';
import 'package:image_viewer/widgets/cat_pic_net.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> pics = [
    'https://i.imgur.com/i9k8D6W.jpg',
    'resources/cats/1.jpg',
    'resources/cats/2.jpg',
    'resources/cats/3.jpg',
    'resources/cats/4.jpg',
    'resources/cats/5.jpg',
    'resources/cats/6.jpg',
    'https://i.imgur.com/rsD0RUq.jpg',
  ];

  Widget _buildList() {
    return GridView.builder(
      itemCount: pics.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext ctxt, int index) {
        final picPath = pics[index];
        return picPath.startsWith('http')
            ? CatPicNet(
                path: picPath,
              )
            : CatPic(
                path: picPath,
              );
      },
    );
  }

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
                  pics.add(_textFieldController.text);
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
