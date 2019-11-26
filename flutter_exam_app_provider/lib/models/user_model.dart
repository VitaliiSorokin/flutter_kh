import 'dart:convert';

import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

enum UserStatus { success, error }

class UserModel extends ChangeNotifier {
  User user;
  String error;
  UserStatus status;

  Future<void> getUser() async {
    user = null;
    error = null;
    status = null;

    try {
      user = await _generateUser();
      status = UserStatus.success;
      notifyListeners();
    } catch (err) {
      status = UserStatus.error;
      error = err;
      notifyListeners(); // ?
    }
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
}
