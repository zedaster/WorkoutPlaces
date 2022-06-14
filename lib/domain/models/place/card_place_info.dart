import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class CardPlaceInfo extends ShortPlaceInfo {
  final double rating;
  final double? distance;
  final bool isFavorite;

  CardPlaceInfo({
    required ShortPlaceInfo short,
    required this.rating,
    required this.distance,
    required this.isFavorite,
  }) : super(
          id: short.id,
          size: short.size,
          novelty: short.novelty,
          mainImage: short.mainImage,
          cityName: short.cityName,
          locationName: short.locationName,
          location: short.location,
        );

  CardPlaceInfo copyWith({
    double? rating,
    double? distance,
    bool? isFavorite,
  }) {
    return CardPlaceInfo(
      short: this,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
