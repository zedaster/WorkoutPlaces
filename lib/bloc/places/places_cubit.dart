import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/place/card_place_info.dart';
import 'package:workout_places_app/domain/repository/favorites_repository.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/repository/user_location_repository.dart';
import 'package:workout_places_app/domain/structure/favorite_update.dart';

import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlacesRepository placesRepository;
  final ReviewsRepository reviewsRepository;
  final UserLocationRepository userLocationRepository;
  final FavoritesRepository favoritesRepository;

  PlacesCubit(
    this.placesRepository,
    this.reviewsRepository,
    this.userLocationRepository,
    this.favoritesRepository,
  ) : super(PlacesState.initialState());

  void initialize() {
    if (state.status != PlacesStatus.initializing) return;
    _internalGetMorePlaces();
    favoritesRepository
        .addFavoriteUpdateListener((update) => _handleFavoriteUpdate(update));
  }

  void getMorePlaces() {
    emit(state.copyWith(status: PlacesStatus.loading));
    _internalGetMorePlaces();
  }

  void onFavoriteStatusChanged(int placeId, bool isFavoriteNow) {
    var index = state.places!.indexWhere((place) => placeId == place.id);
    var place = index != -1 ? state.places![index] : null;
    var newPlaces = List.of(state.places!);

    if (place == null) {
      throw 'The place with id $placeId is null';
    }

    if (isFavoriteNow != place.isFavorite) {
      var newPlace = place.copyWith(isFavorite: isFavoriteNow);
      newPlaces[index] = newPlace;

      Future<void> futureAction;
      if (isFavoriteNow) {
        futureAction = favoritesRepository.addFavoritePlace(place);
      } else {
        futureAction = favoritesRepository.removeFavoritePlace(place);
      }

      print("Emit replaced place with favorite $isFavoriteNow");
      futureAction.then((value) => emit(state.copyWith(
            status: PlacesStatus.success,
            places: newPlaces,
          )));
    }
  }

  Future<void> _internalGetMorePlaces() async {
    var startId = state.places?.length ?? 0;
    const count = 10;

    var userLoc = await userLocationRepository.getUserLocation();
    var newShortPlaces = (userLoc != null)
        ? await placesRepository.getNearPlaces(startId, count, userLoc)
        : await placesRepository.getAllPlaces(startId, count);
    var ratings = await Future.wait(newShortPlaces
        .map((place) => reviewsRepository.getAverageRating(place.id)));
    var isFavorites = await Future.wait(newShortPlaces
        .map((place) => favoritesRepository.isFavoritePlace(place.id)));

    var allPlaces = state.places ?? [];
    for (var i = 0; i < newShortPlaces.length; i++) {
      var short = newShortPlaces[i];
      var rating = ratings[i];
      var distance = userLoc?.distanceTo(short.location);
      var isFavorite = isFavorites[i];
      allPlaces.add(CardPlaceInfo(
        short: short,
        rating: rating,
        distance: distance,
        isFavorite: isFavorite,
      ));
    }
    emit(state.copyWith(status: PlacesStatus.success, places: allPlaces));
  }

  Future<void> _handleFavoriteUpdate(FavoriteUpdate update) async {
    onFavoriteStatusChanged(update.place.id, update.isFavoriteNow);
  }
}
