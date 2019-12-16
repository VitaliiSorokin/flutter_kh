import 'package:dating_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Initial extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  const Loaded(
    this.user,
  );
  final User user;
}

class Error extends UserState {
  const Error({
    @required this.message,
  });

  final String message;
}
