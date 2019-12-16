import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavorites extends FavoritesEvent {
  const GetFavorites({
    @required this.fbUser,
  });
  final FirebaseUser fbUser;

  @override
  List<Object> get props => [fbUser];
}
