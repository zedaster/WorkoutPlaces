import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';

import 'single_place_state.dart';

class SinglePlaceCubit extends Cubit<SinglePlaceState> {
  final SinglePlaceRepository _repository;

  SinglePlaceCubit(SinglePlaceRepository repository)
      : _repository = repository,
        super(SinglePlaceState.initialState());

  Future<void> initialize(ShortPlaceInfo short) async {
    emit(state.copyWith(status: SinglePlaceStatus.initializing));
    final fullInfo = await _repository.getFullInfo(short);
    emit(state.copyWith(status: SinglePlaceStatus.success, place: fullInfo));
  }
}
