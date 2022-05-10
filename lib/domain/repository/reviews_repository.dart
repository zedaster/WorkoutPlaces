import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';

abstract class ReviewsRepository {
  Future<List<Review>> getReviews(int placeId, int skip, int count);
  Future<Review?> getUserReview(int userId);
  Future<ReviewEditStatus> editUserReview(int userId, Review newReview);
}