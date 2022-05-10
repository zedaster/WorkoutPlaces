import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/models/user/user.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';

class FakeReviewsStorage implements ReviewsRepository {
  @override
  Future<List<Review>> getReviews(int placeId, int skip, int count) async {
    if (placeId != 2) return [];
    return [
      Review(
        user: User.empty(),
        date: DateTime(2022, 4, 7),
        stars: 4,
        text: "Отличная площадка! Тренеруюсь на ней постоянно. Жаль, что "
            "гантелей больше нет. Надеюсь, их скоро вернут.",
      ),
    ];
  }

  @override
  Future<Review?> getUserReview(int userId) async {
    // TODO: implement getUserReview
    throw UnimplementedError();
  }

  @override
  Future<ReviewEditStatus> editUserReview(int userId, Review newReview) async {
    // TODO: implement editUserReview
    throw UnimplementedError();
  }
}
