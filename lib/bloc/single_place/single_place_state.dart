import 'package:workout_places_app/domain/models/place/full_place_info.dart';
import 'package:workout_places_app/domain/models/place/review/review.dart';

enum SinglePlaceInfoStatus {
  initializing,
  success,
  // failed
}

enum SinglePlaceReviewsStatus {
  initializing,
  success,
  // TODO: Add sub-loading and page-end status
}

class SinglePlaceState {
  final SinglePlaceInfoStatus infoStatus;
  final SinglePlaceReviewsStatus reviewsStatus;
  final FullPlaceInfo? place;
  final List<Review>? reviews;
  final double? averageRating;

  SinglePlaceState({
    required this.infoStatus,
    required this.reviewsStatus,
    this.place,
    this.reviews,
    this.averageRating,
  });

  SinglePlaceState.initialState()
      : infoStatus = SinglePlaceInfoStatus.initializing,
        reviewsStatus = SinglePlaceReviewsStatus.initializing,
        place = null,
        reviews = null,
        averageRating = null;

  bool get isInfoLoaded => infoStatus != SinglePlaceInfoStatus.initializing;

  bool get isReviewsLoaded =>
      reviewsStatus != SinglePlaceReviewsStatus.initializing;

  SinglePlaceState copyWith({
    SinglePlaceInfoStatus? infoStatus,
    SinglePlaceReviewsStatus? reviewsStatus,
    FullPlaceInfo? place,
    List<Review>? reviews,
    double? averageRating,
  }) {
    return SinglePlaceState(
      infoStatus: infoStatus ?? this.infoStatus,
      reviewsStatus: reviewsStatus ?? this.reviewsStatus,
      place: place ?? this.place,
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating
    );
  }
}
