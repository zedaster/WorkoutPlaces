import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';

class FakePlacesStorage implements PlacesRepository {
  @override
  Future<List<ShortPlaceInfo>> getNearPlaces(
      int skip, int count, MapLocation location) async {
    return [
      ShortPlaceInfo(
        id: 1,
        size: WorkoutSize.medium,
        novelty: WorkoutNovelty.modern,
        mainImage: const NetworkImage("https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-0vs.jpg"),
        cityName: "Екатеринбург",
        locationName: "Бориса Ельцина",
        averageRating: 5,
        location: MapLocation(56.846220, 60.590296),
        distance: 400,
      ),
      ShortPlaceInfo(
        id: 2,
        size: WorkoutSize.small,
        novelty: WorkoutNovelty.modern,
        mainImage: const NetworkImage("https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-tzo.jpg"),
        cityName: "Екатеринбург",
        locationName: "Антона Валека",
        averageRating: 3,
        location: MapLocation(56.839925, 60.592627),
        distance: 700,
      ),
      ShortPlaceInfo(
        id: 3,
        size: WorkoutSize.small,
        novelty: WorkoutNovelty.modern,
        mainImage: const NetworkImage("https://workout.su/uploads/userfiles/2021/07/2021-07-06-13-07-39-h1h.jpg"),
        cityName: "Екатеринбург",
        locationName: "Парк Динамо",
        averageRating: 4,
        location: MapLocation(56.845337, 60.601613),
        distance: 1000,
      ),
    ];
  }
}
