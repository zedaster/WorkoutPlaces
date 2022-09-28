import 'package:flutter/cupertino.dart';
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
  final bool isFavorite;
  final void Function() onTap;
  final void Function(bool newStatus) onFavoriteTap;

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
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Stack(
                  //alignment: Alignment.bottomLeft,
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
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 2),
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                color: (rating == 0)
                                    ? Theme.of(context).backgroundColor
                                    : const Color(0xFF00EB00),
                                size: 20),
                            const SizedBox(width: 2),
                            Text(rating.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    // TODO: Add favorite button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, top: 2),
                        child: GestureDetector(
                          onTap: () => onFavoriteTap(!isFavorite),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("$locationName, $cityName",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 1),
                                  PlaceFeaturesText(novelty: novelty, size: size)
                                ],
                              ),
                            ),
                            if (distance != null)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(stringfyDistance(distance!),
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
      ),
    );
  }

  String stringfyDistance(int metersDistance) {
    if (metersDistance < 1000) {
      return metersDistance.toString() + " м";
    } else {
      return (metersDistance.toDouble() / 1000).toStringAsFixed(1) + " км";
    }
  }
}
