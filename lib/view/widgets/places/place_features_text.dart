import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';

class PlaceFeaturesText extends StatelessWidget {
  final WorkoutNovelty novelty;
  final WorkoutSize size;

  const PlaceFeaturesText({
    required this.novelty,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_stringfySize()} | ${_stringfyNovelty()}",
      style: const TextStyle(fontSize: 12),
    );
  }

  String _stringfyNovelty() {
    switch(novelty) {
      case WorkoutNovelty.modern:
        return "Современная";
      case WorkoutNovelty.soviet:
        return "Советская";
    }
  }

  String _stringfySize() {
    switch(size) {
      case WorkoutSize.small:
        return "Маленькая";
      case WorkoutSize.medium:
        return "Средняя";
      case WorkoutSize.big:
        return "Большая";
    }
  }
}
