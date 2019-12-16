import 'package:dating_app/bloc/authentication_bloc/bloc.dart';
import 'package:dating_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please authorize'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              Container(
                height: 5,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              Container(
                height: 15,
              ),
              RaisedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email != null && password != null) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        LoginWithCredentialsPressed(
          email: email,
          password: password,
        ),
      );
      _navigateToMain(context);
    }
  }

  void _navigateToMain(BuildContext context) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    if (state is Authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MainPage(firebaseUser: state.firebaseUser),
        ),
      );
    }
  }
}
