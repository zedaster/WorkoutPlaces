import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';

import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlacesRepository _repository;

  PlacesCubit(PlacesRepository repository)
      : _repository = repository,
        super(PlacesState.initialState());

  Future<void> getMorePlaces() async {
    emit(state.copyWith(status: PlacesStatus.loading));
    var startId = state.places?.length ?? 0;
    const count = 10;
    var newPlaces = await _repository.getNearPlaces(
        startId, count, state.deviceLocation);
    var newList = List.of(state.places ?? <ShortPlaceInfo>[]);
    newList.addAll(newPlaces);
    emit(state.copyWith(status: PlacesStatus.success, places: newList));
  }

  void updateLocation(MapLocation location) {
    emit(state.copyWith(deviceLocation: location));
    // TODO: Load near places from zero id
  }
}
