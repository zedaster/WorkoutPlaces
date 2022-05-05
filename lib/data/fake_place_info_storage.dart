import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/place_info.dart';
import 'package:workout_places_app/domain/models/place/rating/general_rating.dart';
import 'package:workout_places_app/domain/models/place/rating/rating.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/models/user/user.dart';
import 'package:workout_places_app/domain/repository/place_info_repository.dart';

class FakePlaceInfoStorage implements PlaceInfoRepository {
  @override
  Future<PlaceInfo> getFullInfo(ShortPlaceInfo short) async {
    // TODO: customize fake users here
    switch (short.id) {
      case 1:
        return PlaceInfo(
          short: short,
          images: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-g4e.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-pln.jpg"),
          ],
          rating: GeneralRating(ratingList: [
            Rating(user: User.empty(), value: 5),
          ]),
        );
      case 2:
        return PlaceInfo(
          short: short,
          images: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-rgz.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-bzy.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-vfe.jpg"),
          ],
          rating: GeneralRating(ratingList: [
            Rating(user: User.empty(), value: 5),
          ]),
        );
      case 3:
        return PlaceInfo(
          short: short,
          images: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/07/2021-07-25-13-07-02-8bq.jpeg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/07/2021-07-25-13-07-04-dz_.jpeg"),
          ],
          rating: GeneralRating(ratingList: [
            Rating(user: User.empty(), value: 5),
          ]),
        );
      default:
        throw WrongPlaceIdException(short.id);
    }
  }

  @override
  Future<PlaceInfo> getFullInfoById(int id) {
    // TODO: implement getFullInfoById
    throw UnimplementedError();
  }
}
