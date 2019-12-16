import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/repository/favs_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({@required User user, @required FirebaseUser fbUser})
      : _user = user,
        _fbUser = fbUser;

  final User _user;
  final FirebaseUser _fbUser;

  @override
  DetailsState get initialState => Initial();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetDistance) {
      yield Loading();
      try {
        final permission = LocationPermissions();
        await permission.requestPermissions();

        final geolocator = Geolocator();
        final position = await geolocator.getLastKnownPosition(
            desiredAccuracy: LocationAccuracy.high);
        final dist = const Distance().as(
            LengthUnit.Kilometer,
            LatLng(position.latitude, position.longitude),
            LatLng(_user.latitude, _user.longitude));
        yield DistanceCalculated(dist);
      } catch (_) {
        yield const Error(message: 'Please turn on the geolocation');
      }
    } else if (event is LikePerson) {
      try {
        final FavoritesRepository favRep = FavoritesRepository(fbUser: _fbUser);
        await favRep.addToFavorites(event.person);
      } catch (_) {
        yield const Error(message: 'Cannot add to Favorites');
      }
    }
  }
}
