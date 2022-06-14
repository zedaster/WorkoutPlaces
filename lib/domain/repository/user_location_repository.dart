import 'package:workout_places_app/domain/models/location/map_location.dart';

abstract class UserLocationRepository {
  Future<MapLocation?> getUserLocation();
}