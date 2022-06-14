import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/card_place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/favorites_repository.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/repository/user_location_repository.dart';
import 'package:workout_places_app/domain/structure/favorite_update.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  final ReviewsRepository reviewsRepository;
  final UserLocationRepository userLocationRepository;

  FavoritesCubit(this.favoritesRepository,
      this.reviewsRepository,
      this.userLocationRepository,) : super(FavoritesState.initialState());

  void initialize() {
    if (state.status != FavoritesStatus.initializing) return;
    _getPlaces().toList().then((places) {
      emit(state.copyWith(places: places, status: FavoritesStatus.success));
    });
    favoritesRepository.addFavoriteUpdateListener((update) =>
        _updatePlace(update));
  }

  Future<void> _updatePlace(FavoriteUpdate update) async {
    emit(state.copyWith(status: FavoritesStatus.updating));

    var updatedIndex = state.places!.indexWhere((place) =>
    place.id == update.place.id);
    var newPlaces = List.of(state.places!);

    if (!update.isFavoriteNow) {
      if (updatedIndex != -1) {
        newPlaces.removeAt(updatedIndex);
      }
    } else {
      var userLoc = await userLocationRepository.getUserLocation();
      var card = await _transferShortToCardInfo(update.place, userLoc);
      newPlaces.add(card);
    }

    emit(state.copyWith(status: FavoritesStatus.success, places: newPlaces));
  }

  void removePlace(ShortPlaceInfo place) {
    favoritesRepository.removeFavoritePlace(place);
  }

  Stream<CardPlaceInfo> _getPlaces() async* {
    var userLocation = await userLocationRepository.getUserLocation();
    var shorts = await favoritesRepository.getFavoritePlaces();

    for (var short in shorts) {
      yield await _transferShortToCardInfo(short, userLocation);
    }
  }

  Future<CardPlaceInfo> _transferShortToCardInfo(ShortPlaceInfo short,
      MapLocation? userLocation) async {
    var rating = await reviewsRepository.getAverageRating(short.id);
    var distance = userLocation?.distanceTo(short.location);
    return CardPlaceInfo(
      short: short,
      rating: rating,
      distance: distance,
      isFavorite: true,
    );
  }
}
