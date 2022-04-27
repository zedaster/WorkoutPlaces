import 'package:workout_places_app/domain/models/location/city.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/workout_place.dart';
import 'package:workout_places_app/domain/repository/workout_places_repository.dart';

class FakeWorkoutPlacesStorage implements WorkoutPlacesRepository {
  @override
  Future<List<WorkoutPlace>> getCityPlaces(int skip, int count, City city) {
    // TODO: implement getCityPlaces
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutPlace>> getNearPlaces(int skip, int count, MapLocation location) {
    // TODO: implement getNearPlaces
    throw UnimplementedError();
  }

}