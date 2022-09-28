import 'dart:math' as math;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation {
  final double latitude;
  final double longitude;

  MapLocation(this.latitude, this.longitude);

  MapLocation.fromGoogleLatLng(LatLng latLng)
      : latitude = latLng.latitude,
        longitude = latLng.longitude;

  LatLng toGoogleLatLng() => LatLng(latitude, longitude);

  /// Gets distance in meters
  double distanceTo(MapLocation other) {
    var R = 6371; // Radius of the earth in km
    var dLat = _degreesToRadians(other.latitude - latitude); // deg2rad below
    var dLon = _degreesToRadians(other.longitude - longitude);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(latitude)) *
            math.cos(_degreesToRadians(other.latitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d * 1000;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapLocation &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
