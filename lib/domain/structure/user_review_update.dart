import 'package:workout_places_app/domain/models/place/review/review.dart';

class UserReviewUpdate {
  int placeId;
  Review? oldReview;
  Review newReview;

  UserReviewUpdate({
    required this.placeId,
    this.oldReview,
    required this.newReview,
  });
}
