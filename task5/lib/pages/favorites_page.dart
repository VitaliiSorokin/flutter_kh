import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/bloc/favorites_bloc/bloc.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: _buildFavorites());
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

  Widget _buildFavorites() {
    return Center(
      child: BlocProvider<FavoritesBloc>(
          create: (context) =>
              FavoritesBloc()..add(GetFavorites(fbUser: firebaseUser)),
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
            if (state is Loaded) {
              return GridView.builder(
                itemCount: state.favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext ctxt, int index) {
                  final person = state.favorites[index];
                  return InkWell(
                    child: Image.network(person.image),
                    onTap: () => _navigateTodetails(ctxt, person),
                  );
                },
              );
            } else if (state is Error) {
              return Center(child: Text(state.message));
            }
            return const Padding(
              padding: EdgeInsets.all(150.0),
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
