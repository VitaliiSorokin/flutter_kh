import 'package:dating_app/bloc/authentication_bloc/bloc.dart';
import 'package:dating_app/bloc/user_bloc/bloc.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:dating_app/pages/favorites_page.dart';
import 'package:dating_app/pages/login_page.dart';
import 'package:dating_app/widgets/user_buttons.dart';
import 'package:dating_app/widgets/user_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
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
      body: BlocProvider<UserBloc>(
        create: (context) => UserBloc()..add(GetUser()),
        child: Center(
            child: SingleChildScrollView(
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
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is Loaded) {
                    return UserImage(state.user);
                  } else if (state is Error) {
                    return Center(child: Text(state.message));
                  }
                  return const Padding(
                    padding: EdgeInsets.all(150.0),
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) => UserButtons(
                  onReload: () {
                    BlocProvider.of<UserBloc>(context).add(GetUser());
                  },
                  onNext: () {
                    final state = BlocProvider.of<UserBloc>(context).state;
                    if (state is Loaded) {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              user: widget.firebaseUser, person: state.user),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
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
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
