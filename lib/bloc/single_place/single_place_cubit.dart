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

  Future<void> initialize(ShortPlaceInfo short) async {
    // Initialize short info
    placeRepository.getFullInfo(short).then((fullInfo) {
      emit(state.copyWith(
        infoStatus: SinglePlaceInfoStatus.success,
        place: fullInfo,
      ));
    });

    // Initialize reviews
    reviewsRepository.getReviews(short.id, 0, 10).then((reviews) {
      emit(state.copyWith(
        reviews: reviews,
        reviewsStatus: SinglePlaceReviewsStatus.success,
      ));
    });
  }
}
