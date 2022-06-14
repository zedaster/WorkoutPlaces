import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class FavoriteUpdate {
  ShortPlaceInfo place;
  bool isFavoriteNow;

  FavoriteUpdate(this.place, this.isFavoriteNow);
}