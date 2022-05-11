
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';

import 'single_place_state.dart';

class SinglePlaceCubit extends Cubit<SinglePlaceState> {
  final SinglePlaceRepository placeRepository;
  final ReviewsRepository reviewsRepository;

  SinglePlaceCubit(this.placeRepository, this.reviewsRepository)
      : super(SinglePlaceState.initialState());

  void initialize(ShortPlaceInfo short) {
    // Initialize short info
    emit(SinglePlaceState.initialState());
    placeRepository.getFullInfo(short).then((fullInfo) {
      reviewsRepository.getAverageRating(fullInfo.id).then((rating) {
        emit(state.copyWith(
          infoStatus: SinglePlaceInfoStatus.success,
          averageRating: rating,
          place: fullInfo,
        ));
      });
    });

    // Initialize reviews
    reviewsRepository.getReviews(short.id, 0, 10).then((reviews) {
      emit(state.copyWith(
        reviews: reviews,
        reviewsStatus: SinglePlaceReviewsStatus.success,
      ));
    });
  }

  void updateReviews() {
    if (state.place == null) return;
    reviewsRepository.getReviews(state.place!.id, 0, 10).then((reviews) {
      reviewsRepository.getAverageRating(state.place!.id).then((rating) {
        emit(state.copyWith(
          averageRating: rating,
          reviews: reviews,
          reviewsStatus: SinglePlaceReviewsStatus.success,
        ));
      });
    });
  }
}
