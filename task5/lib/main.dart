import 'package:bloc/bloc.dart';
import 'package:dating_app/bloc/authentication_bloc/bloc.dart';
import 'package:dating_app/pages/login_page.dart';
import 'package:dating_app/pages/main_page.dart';
import 'package:dating_app/repository/user_repository.dart';
import 'package:dating_app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destiny',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginPage();
          }
          if (state is Authenticated) {
            return MainPage(firebaseUser: state.firebaseUser);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
