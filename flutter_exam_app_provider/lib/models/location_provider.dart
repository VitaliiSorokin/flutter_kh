import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

enum LocationStatus { success, error }

class LocationProvider extends ChangeNotifier {
  LatLng location;
  String error;
  LocationStatus status;

  Future<void> getLocation() async {
    location = null;
    error = null;
    status = null;

    try {
      location = await _getCoordinates();
      status = LocationStatus.success;
      notifyListeners();
    } catch (err) {
      status = LocationStatus.error;
      error = err;
      notifyListeners(); // ?
    }
  }

  Future<LatLng> _getCoordinates() async {
    final permission = LocationPermissions();
    await permission.requestPermissions();

    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
