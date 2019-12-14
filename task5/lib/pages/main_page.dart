import 'dart:convert';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:dating_app/pages/favorites_page.dart';
import 'package:dating_app/pages/login_page.dart';
import 'package:dating_app/pages/user_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = _generateUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {
              _navigateToFavorites(context, widget.firebaseUser);
            },
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _signOut(context);
              }),
        ],
      ),
      body: Center(
        child: FutureBuilder<User>(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 80,
                          top: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          ' logged in as ${widget.firebaseUser.email}',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                      Hero(
                        tag: 'avatar',
                        child: Image.network(
                          snapshot.data.image,
                          fit: BoxFit.fill,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                          snapshot.data.name,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                      UserButtons(
                        onReload: () {
                          setState(() {
                            _user = _generateUser();
                          });
                        },
                        onNext: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  person: snapshot.data,
                                  user: widget.firebaseUser),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text(
                    'Something is wrong. Check your internet connection. :-(');
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Future<User> _generateUser() async {
    final uri = Uri.https('randomuser.me', '/api/1.3');
    final response = await http.get(uri);
    return compute(_parseUser, response.body);
  }

  static User _parseUser(String response) {
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }

  void _navigateToFavorites(BuildContext context, FirebaseUser fbUser) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => FavoritesPage(
          firebaseUser: fbUser,
        ),
      ),
    );
  }

  void _signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
