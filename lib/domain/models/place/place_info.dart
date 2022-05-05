import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/rating/general_rating.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class PlaceInfo extends ShortPlaceInfo {
  final GeneralRating rating;
  final List<ImageProvider> images;

  PlaceInfo({
    required ShortPlaceInfo short,
    required this.rating,
    required this.images,
  }) : super(
          id: short.id,
          size: short.size,
          novelty: short.novelty,
          mainImage: short.mainImage,
          cityName: short.cityName,
          locationName: short.locationName,
          averageRating: short.averageRating,
          location: short.location,
          distance: short.distance,
        );
}
