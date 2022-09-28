import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/full_place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';

class FakeSinglePlaceStorage implements SinglePlaceRepository {
  @override
  Future<FullPlaceInfo> getFullInfo(ShortPlaceInfo short) async {
    // TODO: customize fake users here
    switch (short.id) {
      case 1:
        return FullPlaceInfo(
          short: short,
          allImages: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-g4e.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-01-08-09-32-pln.jpg"),
          ],
        );
      case 2:
        return FullPlaceInfo(
          short: short,
          allImages: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-rgz.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-bzy.jpg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/09/2021-09-02-15-09-49-vfe.jpg"),
          ],
        );
      case 3:
        return FullPlaceInfo(
          short: short,
          allImages: [
            short.mainImage,
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/07/2021-07-25-13-07-02-8bq.jpeg"),
            const NetworkImage(
                "https://workout.su/uploads/userfiles/2021/07/2021-07-25-13-07-04-dz_.jpeg"),
          ],
        );
      default:
        throw WrongPlaceIdException(short.id);
    }
  }

  @override
  Future<FullPlaceInfo> getFullInfoById(int id) {
    // TODO: implement getFullInfoById
    throw UnimplementedError();
  }
}
