import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/models/place/review/review_data.dart';
import 'package:workout_places_app/domain/structure/average_rating_update.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';
import 'package:workout_places_app/domain/structure/user_review_update.dart';

abstract class ReviewsRepository {
  Future<List<Review>> getReviews(int placeId, int skip, int count);
  Future<Review?> getUserReview(int userId, int placeId);
  Future<ReviewEditStatus> editUserReview(int userId, ReviewData newReviewData);
  Future<double> getAverageRating(int placeId);

  Future<void> addAverageRatingUpdateListener(Future<void> Function(AverageRatingUpdate) listener);
  Future<void> addUserReviewUpdateListener(Future<void> Function(UserReviewUpdate) listener);
}