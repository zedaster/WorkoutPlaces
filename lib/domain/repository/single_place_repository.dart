import 'package:workout_places_app/domain/models/place/full_place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

abstract class SinglePlaceRepository {
  Future<FullPlaceInfo> getFullInfoById(int id);
  Future<FullPlaceInfo> getFullInfo(ShortPlaceInfo short);
}

abstract class SinglePlaceException implements Exception {
  final int placeId;

  SinglePlaceException(this.placeId);
}

class WrongPlaceIdException extends SinglePlaceException {
  WrongPlaceIdException(int placeId) : super(placeId);
}

class SinglePlaceNetworkException extends SinglePlaceException {
  SinglePlaceNetworkException(int placeId) : super(placeId);
}