import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';

import 'workout_novelty.dart';
import 'workout_size.dart';

class ShortPlaceInfo {
  final int id;
  final WorkoutSize size;
  final WorkoutNovelty novelty;
  final ImageProvider mainImage;
  final String cityName;
  final String locationName;
  final MapLocation location;
  final double distance;

  ShortPlaceInfo({
    required this.id,
    required this.size,
    required this.novelty,
    required this.mainImage,
    required this.cityName,
    required this.locationName,
    required this.location,
    required this.distance,
  });
}
