import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/card_place_info.dart';

enum FavoritesStatus {
  initializing,
  updating,
  success,
}

class FavoritesState {
  final FavoritesStatus status;
  final List<CardPlaceInfo>? places;
  final MapLocation? deviceLocation;

  FavoritesState({
    required this.status,
    required this.places,
    required this.deviceLocation,
  });

  FavoritesState.initialState()
      : places = null,
        status = FavoritesStatus.initializing,
        deviceLocation = null;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<CardPlaceInfo>? places,
    MapLocation? deviceLocation
  }) {
    return FavoritesState(
      status: status ?? this.status,
      places: places ?? this.places,
      deviceLocation: deviceLocation ?? this.deviceLocation
    );
  }
}
