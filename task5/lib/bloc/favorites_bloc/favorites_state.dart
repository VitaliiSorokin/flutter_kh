import 'package:dating_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class Initial extends FavoritesState {}

class Loading extends FavoritesState {}

class Loaded extends FavoritesState {
  const Loaded(
    this.favorites,
  );
  final List<User> favorites;
}

class Error extends FavoritesState {
  const Error({
    @required this.message,
  });

  final String message;
}
