import 'package:workout_places_app/domain/models/place/place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

abstract class PlaceInfoRepository {
  Future<PlaceInfo> getFullInfoById(int id);
  Future<PlaceInfo> getFullInfo(ShortPlaceInfo short);
}

class WrongPlaceIdException implements Exception {
  final int placeId;

  WrongPlaceIdException(this.placeId);
}