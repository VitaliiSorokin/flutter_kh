import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key key, this.firebaseUser}) : super(key: key);

  final FirebaseUser firebaseUser;
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Favorites'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: _buildList());
  }

  void _navigateTodetails(BuildContext context, User person) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => DetailsPage(
          person: person,
          user: firebaseUser,
        ),
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder<List<User>>(
      future: _getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext ctxt, int index) {
              final person = snapshot.data[index];
              return InkWell(
                child: Image.network(person.image),
                onTap: () => _navigateTodetails(ctxt, person),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<User>> _getFavorites() async {
    final users = <User>{};
    await databaseReference
        .collection('user')
        .document(firebaseUser.uid)
        .collection('favorites')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.documents) {
        users.add(User(
            item.data['location']['lat'],
            item.data['location']['long'],
            item.data['image'],
            item.data['name']));
      }
    });
    return users.toList();
  }
}
