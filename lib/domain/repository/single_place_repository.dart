import 'package:workout_places_app/domain/models/place/full_place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

abstract class SinglePlaceRepository {
  Future<FullPlaceInfo> getFullInfoById(int id);
  Future<FullPlaceInfo> getFullInfo(ShortPlaceInfo short);
}

class WrongPlaceIdException implements Exception {
  final int placeId;

  WrongPlaceIdException(this.placeId);
}