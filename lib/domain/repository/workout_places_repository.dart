import 'package:workout_places_app/domain/models/location/city.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/workout_place.dart';

abstract class WorkoutPlacesRepository {
  Future<List<WorkoutPlace>> getNearPlaces(int skip, int count, MapLocation location);
  Future<List<WorkoutPlace>> getCityPlaces(int skip, int count, City city);
}