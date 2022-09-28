import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class FullPlaceInfo extends ShortPlaceInfo {
  final List<ImageProvider> allImages;

  FullPlaceInfo({
    required ShortPlaceInfo short,
    required this.allImages,
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
