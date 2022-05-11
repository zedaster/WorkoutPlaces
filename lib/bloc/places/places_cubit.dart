import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/rated_place_info.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';

import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlacesRepository placesRepository;
  final ReviewsRepository reviewsRepository;

  PlacesCubit(this.placesRepository, this.reviewsRepository)
      : super(PlacesState.initialState());

  void initialize() {
    if (state.status != PlacesStatus.initializing) return;
    getMorePlaces();
  }

  void getMorePlaces() {
    emit(state.copyWith(status: PlacesStatus.loading));
    var startId = state.places?.length ?? 0;
    const count = 10;
    placesRepository
        .getNearPlaces(startId, count, state.deviceLocation)
        .then((newPlaces) {
      var newRatingsTasks = newPlaces
          .map((place) => reviewsRepository.getAverageRating(place.id));
      Future.wait(newRatingsTasks).then((newRatings) {
        var i = 0;
        var newRatedPlaces = newPlaces.map((short) =>
            RatedPlaceInfo(short: short, rating: newRatings[i++]));
        var newList = state.places ?? <RatedPlaceInfo>[];
        newList.addAll(newRatedPlaces);
        emit(state.copyWith(
          status: PlacesStatus.success,
          places: newList,
        ));
      });
    });
  }

  void updateRating(int placeId) {
    var index = state.places?.indexWhere((place) => place.id == placeId);
    if (index == null) return;
    var place = state.places!.where((place) => place.id == placeId).first;
    reviewsRepository.getAverageRating(placeId).then((newRating) {
      var newPlace = place.copyWithRating(newRating);
      var newPlaceList = List.of(state.places!);
      newPlaceList[index] = newPlace;
      emit(state.copyWith(places: newPlaceList));
    });

  }

  void updateLocation(MapLocation location) {
    emit(state.copyWith(deviceLocation: location));
    // TODO: Load near places from zero id
  }
}
