import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  const Authenticated(this.firebaseUser);

  final FirebaseUser firebaseUser;

  @override
  List<Object> get props => [firebaseUser];
}

class Authenticating extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}
