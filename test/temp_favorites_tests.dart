import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:workout_places_app/data/temp_favorites_storage.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';

void main() {
  group("Tests for TempFavoritesStorage", () {
    var places = [
      ShortPlaceInfo(
        id: 1,
        size: WorkoutSize.medium,
        novelty: WorkoutNovelty.modern,
        mainImage: const NetworkImage(
            "https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-0vs.jpg"),
        cityName: "Екатеринбург",
        locationName: "Бориса Ельцина",
        location: MapLocation(56.846220, 60.590296),
      ),
      ShortPlaceInfo(
        id: 2,
        size: WorkoutSize.small,
        novelty: WorkoutNovelty.modern,
        mainImage: const NetworkImage(
            "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-tzo.jpg"),
        cityName: "Екатеринбург",
        locationName: "Антона Валека",
        location: MapLocation(56.839925, 60.592627),
      ),
    ];

    test("async save 2 different infos at one time", () async {
      var storage = TempFavoritesStorage();
      var tasks = <Future>[];
      for (var place in places) {
        tasks.add(storage.addFavoritePlace(place));
      }
      await Future.wait(tasks);
      expect(await storage.getFavoritePlaces(), places);
    });

    test("async save 2 same infos at one time", () async {
      var storage = TempFavoritesStorage();
      var tasks = <Future>[];
      for (var i = 0; i < 2; i++) {
        tasks.add(storage.addFavoritePlace(places[0]));
      }
      await Future.wait(tasks);
      expect((await storage.getFavoritePlaces()).length, 1);
      expect((await storage.getFavoritePlaces())[0], places[0]);
    });
  });
}
