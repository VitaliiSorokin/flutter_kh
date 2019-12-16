import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class LoginWithCredentialsPressed extends AuthenticationEvent {
  const LoginWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUpWithCredentialsPressed extends AuthenticationEvent {
  const SignUpWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
