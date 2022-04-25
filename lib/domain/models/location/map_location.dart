import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation {
  final double latitude;
  final double longitude;

  MapLocation(this.latitude, this.longitude);

  MapLocation.fromGoogleLatLng(LatLng latLng)
      : latitude = latLng.latitude,
        longitude = latLng.longitude;

  LatLng toGoogleLatLng() => LatLng(latitude, longitude);
}
