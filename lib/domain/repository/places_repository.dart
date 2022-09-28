import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

abstract class PlacesRepository {
  Future<List<ShortPlaceInfo>> getNearPlaces(int skip, int count, MapLocation location);
  Future<List<ShortPlaceInfo>> getMapPlaces(MapLocation topLeft, MapLocation bottomRight);
  Future<List<ShortPlaceInfo>> getAllPlaces(int skip, int count);
}