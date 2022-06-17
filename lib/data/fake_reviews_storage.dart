import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/models/place/review/review_data.dart';
import 'package:workout_places_app/domain/models/user/user.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/structure/average_rating_update.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';
import 'package:workout_places_app/domain/structure/user_review_update.dart';

class FakeReviewsStorage implements ReviewsRepository {
  final _reviews = <int, Review>{};
  final _ratingListeners = <Future<void> Function(AverageRatingUpdate)>[];
  final _reviewListeners = <Future<void> Function(UserReviewUpdate)>[];

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
    Review? oldReview;
    Review newReview;
    int? oldStars;
    int newStars;

    if (_reviews.containsKey(data.placeId)) {
      oldReview = _reviews[data.placeId]!;
      oldStars = oldReview.stars;
      newReview = oldReview.copyWithData(data);
      newStars = data.stars;
    } else {
      newReview = Review(
          user: User.empty(),
          date: DateTime.now(),
          stars: data.stars,
          text: data.text);
      newStars = data.stars;
    }
    _reviews[data.placeId] = newReview;
    var tasks = <Future>[];
    tasks.add(_produceReviewUpdate(UserReviewUpdate(
      placeId: data.placeId,
      oldReview: oldReview,
      newReview: newReview,
    )));
    if (oldStars != newStars) {
      tasks.add(_produceRatingUpdate(AverageRatingUpdate(
        placeId: data.placeId,
        oldRating: oldStars?.toDouble(),
        newRating: newStars.toDouble(),
      )));
    }
    await Future.wait(tasks);
    return ReviewEditStatus.success;
  }

  @override
  Future<double> getAverageRating(int placeId) async {
    return _reviews[placeId]?.stars.toDouble() ?? 0.0;
  }

  Future<void> _produceRatingUpdate(AverageRatingUpdate update) async {
    var tasks = _ratingListeners.map((lister) => lister(update));
    await Future.wait(tasks);
  }

  Future<void> _produceReviewUpdate(UserReviewUpdate update) async {
    var tasks = _reviewListeners.map((listener) => listener(update));
    await Future.wait(tasks);
  }

  @override
  Future<void> addAverageRatingUpdateListener(
      Future<void> Function(AverageRatingUpdate) listener) async {
    _ratingListeners.add(listener);
  }

  @override
  Future<void> addUserReviewUpdateListener(
      Future<void> Function(UserReviewUpdate) listener) async {
    _reviewListeners.add(listener);
  }
}
