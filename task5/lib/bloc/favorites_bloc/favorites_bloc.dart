import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/repository/favs_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  @override
  FavoritesState get initialState => Initial();

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavorites) {
      yield* _mapGetFavoritesEventToState(event.fbUser);
    }
  }

  Stream<FavoritesState> _mapGetFavoritesEventToState(
      FirebaseUser fbUser) async* {
    yield Loading();
    try {
      final FavoritesRepository favRep = FavoritesRepository(fbUser: fbUser);
      final favs = await favRep.getFavorites();
      yield Loaded(favs);
    } catch (_) {
      yield const Error(message: 'Failed fetching favorites');
    }
  }
}
