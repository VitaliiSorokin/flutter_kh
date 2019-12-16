import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dating_app/models/user.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => Initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      yield* _mapGetUserEventToState();
    }
  }

  Stream<UserState> _mapGetUserEventToState() async* {
    yield Loading();
    try {
      final uri = Uri.https('randomuser.me', '/api/1.3');
      final response = await http.get(uri);
      final Map<String, dynamic> parsed = json.decode(response.body);
      final user = User.fromRandomUserResponse(parsed);
      yield Loaded(user);
    } catch (_) {
      yield const Error(message: 'Failed fetching user');
    }
  }
}
