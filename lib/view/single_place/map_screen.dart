import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';

class MapScreen extends StatelessWidget {
  final MapLocation location;

  const MapScreen({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Расположение"),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location.toGoogleLatLng(),
            zoom: 15
          ),
          markers: {
            Marker(
              markerId: MarkerId("workout"),
              position: location.toGoogleLatLng(),
            )
          },
        ));
  }
}
