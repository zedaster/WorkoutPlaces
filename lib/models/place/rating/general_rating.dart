import 'package:workout_places_app/models/place/rating/rating.dart';
import 'package:collection/collection.dart';

class GeneralRating {
  double _averageValue;
  List<Rating> _ratingList;

  GeneralRating({required List<Rating> ratingList})
      : _ratingList = ratingList,
        _averageValue = ratingList.map((r) => r.value).sum / ratingList.length;

  List<Rating> get ratingList => _ratingList;

  double get averageValue => _averageValue;

  // todo add setters for general rating class
}
