import 'package:workout_places_app/domain/models/place/card_place_info.dart';

enum PlacesStatus {
  initializing,
  loading,
  success,
  // TODO: Create end page state
  //failed
}

class PlacesState {
  final PlacesStatus status;
  final List<CardPlaceInfo>? places;

  PlacesState({
    required this.status,
    required this.places,
  });

  PlacesState.initialState()
      : places = null,
        status = PlacesStatus.initializing;

  PlacesState copyWith({
    PlacesStatus? status,
    List<CardPlaceInfo>? places,
  }) {
    return PlacesState(
      status: status ?? this.status,
      places: places ?? this.places,
    );
  }
}
