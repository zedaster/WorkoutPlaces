import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/repository/user_location_repository.dart';

class FakeEkbLocationAdapter implements UserLocationRepository {
  @override
  Future<MapLocation?> getUserLocation() async {
    return MapLocation(56.836243, 60.594896);
  }
  
}