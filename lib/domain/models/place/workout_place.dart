import 'package:flutter/material.dart';
import 'rating/general_rating.dart';
import 'workout_novelty.dart';
import 'workout_size.dart';

class WorkoutPlace {
  final WorkoutSize size;
  final WorkoutNovelty novelty;
  final ImageProvider image;
  final GeneralRating rating;
  final String cityName;
  final String locationName;

  // todo add location

  WorkoutPlace({
    required this.size,
    required this.novelty,
    required this.image,
    required this.rating,
    required this.cityName,
    required this.locationName,
  });
}
