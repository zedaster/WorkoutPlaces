import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/structure/favorite_update.dart';

abstract class FavoritesRepository {
  Future<List<ShortPlaceInfo>> getFavoritePlaces();
  Future<void> addFavoritePlace(ShortPlaceInfo place);
  Future<bool> isFavoritePlace(int placeId);
  Future<void> removeFavoritePlace(ShortPlaceInfo placeId);

  Future<void> addFavoriteUpdateListener(Future<void> Function(FavoriteUpdate) listener);
}