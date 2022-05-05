import 'package:workout_places_app/domain/models/place/full_place_info.dart';

enum SinglePlaceStatus {
  initializing,
  success,
  // failed
}

class SinglePlaceState {
  final SinglePlaceStatus status;
  final FullPlaceInfo? place;

  SinglePlaceState({
    required this.status,
    this.place,
  });

  SinglePlaceState.initialState()
      : status = SinglePlaceStatus.initializing,
        place = null;

  bool get isLoaded => status != SinglePlaceStatus.initializing;

  SinglePlaceState copyWith({
    SinglePlaceStatus? status,
    FullPlaceInfo? place,
  }) {
    return SinglePlaceState(
      status: status ?? this.status,
      place: place ?? this.place
    );
  }
}
