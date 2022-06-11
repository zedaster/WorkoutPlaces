import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class CardPlaceInfo extends ShortPlaceInfo {
  double rating;
  double? distance;

  CardPlaceInfo({
    required ShortPlaceInfo short,
    required this.rating,
    required this.distance,
  }) : super(
    id: short.id,
    size: short.size,
    novelty: short.novelty,
    mainImage: short.mainImage,
    cityName: short.cityName,
    locationName: short.locationName,
    location: short.location,
  );
}