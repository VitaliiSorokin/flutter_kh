import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:dating_app/pages/user_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Almost Tinder'),
        ),
        body: Center(
          child: ChangeNotifierProvider<UserModel>(
            builder: (_) => UserModel()..getUser(),
            child: Consumer<UserModel>(
                builder: (context, user, _) => _buildMainPage(context, user)),
          ),
        ));
  }

  Widget _buildMainPage(BuildContext context, UserModel userModel) {
    print(userModel.status);

    return Consumer<UserModel>(
      builder: (context, provider, _) {
        if (userModel.status == UserStatus.success) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'avatar',
                  child: Image.network(
                    userModel.user.image,
                    fit: BoxFit.fill,
                    height: 300,
                    width: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    userModel.user.name,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                UserButtons(
                  onReload: () {
                    userModel.getUser();
                  },
                  onNext: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(user: userModel.user),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (userModel.status == UserStatus.error) {
          return const Text(
              'Something is wrong. Check your internet connection. :-(');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
