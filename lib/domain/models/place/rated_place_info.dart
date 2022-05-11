import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class RatedPlaceInfo extends ShortPlaceInfo {
  final double rating;
  final ShortPlaceInfo short;

  RatedPlaceInfo({
    required this.short,
    required this.rating,
  }) : super(
    id: short.id,
    size: short.size,
    novelty: short.novelty,
    mainImage: short.mainImage,
    cityName: short.cityName,
    locationName: short.locationName,
    location: short.location,
    distance: short.distance,
  );
  
  copyWithRating(double rating) {
    return RatedPlaceInfo(short: short, rating: rating);
  }
}