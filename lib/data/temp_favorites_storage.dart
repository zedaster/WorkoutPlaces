import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/favorites_repository.dart';
import 'package:workout_places_app/domain/structure/favorite_update.dart';

class TempFavoritesStorage implements FavoritesRepository {
  List<ShortPlaceInfo> favoritePlaces = [];

  List<Future<void> Function(FavoriteUpdate)> updateListeners = [];

  @override
  Future<List<ShortPlaceInfo>> getFavoritePlaces() async {
    return favoritePlaces;
  }

  @override
  Future<void> addFavoritePlace(ShortPlaceInfo place) async {
    if (!(await isFavoritePlace(place.id))) {
      favoritePlaces.add(place);
      await _registerUpdate(place, true);
    }
  }

  @override
  Future<bool> isFavoritePlace(int placeId) async {
    return favoritePlaces.any((p) => p.id == placeId);
  }

  @override
  Future<void> removeFavoritePlace(ShortPlaceInfo place) async {
    var index = favoritePlaces.indexWhere((p) => p.id == place.id);
    if (index != -1) {
      favoritePlaces.removeAt(index);
      await _registerUpdate(place, false);
    }
  }

  @override
  Future<void> addFavoriteUpdateListener(
      Future<void> Function(FavoriteUpdate) listener) async {
    updateListeners.add(listener);
  }

  Future<FavoriteUpdate> _registerUpdate(
      ShortPlaceInfo place, bool isFavoriteNow) async {
    var update = FavoriteUpdate(place, isFavoriteNow);
    for (var listener in updateListeners) {
      listener(update);
    }
    return update;
  }
}
