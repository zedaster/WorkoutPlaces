import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/models/place/review/review_data.dart';
import 'package:workout_places_app/domain/models/user/user.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';

class FakeReviewsStorage implements ReviewsRepository {
  final _reviews = <int, Review>{};

  @override
  Future<List<Review>> getReviews(int placeId, int skip, int count) async {
    // if (placeId != 2) return [];
    // return [
    //   Review(
    //     user: User.empty(),
    //     date: DateTime(2022, 4, 7),
    //     stars: 4,
    //     text: "Отличная площадка! Тренеруюсь на ней постоянно. Жаль, что "
    //         "гантелей больше нет. Надеюсь, их скоро вернут.",
    //   ),
    // ];
    return _reviews.containsKey(placeId) ? [_reviews[placeId]!] : <Review>[];
  }

  @override
  Future<Review?> getUserReview(int userId, int placeId) async {
    if (_reviews.containsKey(placeId)) {
      return _reviews[placeId];
    } else {
      return null;
    }
  }

  @override
  Future<ReviewEditStatus> editUserReview(int userId, ReviewData data) async {
    if (_reviews.containsKey(data.placeId)) {
      _reviews[data.placeId] = _reviews[data.placeId]!.copyWithData(data);
    } else {
      _reviews[data.placeId] = Review(
        user: User.empty(),
        date: DateTime.now(),
        stars: data.stars,
        text: data.text
      );
    }
    return ReviewEditStatus.success;
  }

  @override
  Future<double> getAverageRating(int placeId) async {
    return _reviews[placeId]?.stars.toDouble() ?? 0.0;
  }
}
