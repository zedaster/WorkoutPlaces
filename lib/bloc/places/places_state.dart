import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

enum PlacesStatus {
  initializing,
  loading,
  success,
  // TODO: Create end page state
  //failed
}

class PlacesState {
  final PlacesStatus status;
  final List<ShortPlaceInfo>? places;
  final MapLocation deviceLocation;

  PlacesState({
    required this.status,
    required this.places,
    required this.deviceLocation,
  });

  PlacesState.initialState()
      : places = null,
        status = PlacesStatus.initializing,
        deviceLocation = MapLocation(0, 0);

  PlacesState copyWith({
    PlacesStatus? status,
    List<ShortPlaceInfo>? places,
    MapLocation? deviceLocation,
  }) {
    return PlacesState(
      status: status ?? this.status,
      places: places ?? this.places,
      deviceLocation: deviceLocation ?? this.deviceLocation,
    );
  }
}
