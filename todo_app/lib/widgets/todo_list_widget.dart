import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  List<String> items = ['item1', 'item2', 'item3'];

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext ctxt, int index) {
        final item = items[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('$item dismissed')));
          },
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(item),
            leading: Icon(Icons.keyboard_arrow_right),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tod List'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();

  void _addNewItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write new todo:'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Todo action'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ADD'),
                onPressed: () {
                  setState(() {
                    if (_textFieldController.text.isNotEmpty) {
                      items.add(_textFieldController.text);
                      _textFieldController.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
