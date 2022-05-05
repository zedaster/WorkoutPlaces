import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMapScreenPart extends StatelessWidget {
  const PlacesMapScreenPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(55.751244, 37.618423),
      ),
    );
  }
}
