import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';

import 'place_features_text.dart';

class PlaceInfoWidget extends StatelessWidget {
  final double height;
  final String locationName;
  final String cityName;
  final ImageProvider image;
  final WorkoutSize size;
  final WorkoutNovelty novelty;
  final int? distance;
  final double rating;

  const PlaceInfoWidget({
    Key? key,
    required this.height,
    required this.locationName,
    required this.cityName,
    required this.image,
    required this.size,
    required this.novelty,
    required this.rating,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.25),
                                BlendMode.srcOver),
                            image: image)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.star,
                            color: Color(0xFF00EB00), size: 20),
                        const SizedBox(width: 2),
                        Text(rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("$locationName, $cityName",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 1),
                              PlaceFeaturesText(novelty: novelty, size: size)
                            ],
                          ),
                          if (distance != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("$distance м",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ))
                              ],
                            )
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
