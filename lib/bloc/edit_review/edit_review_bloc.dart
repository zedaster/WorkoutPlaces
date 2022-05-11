import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_event.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_state.dart';
import 'package:workout_places_app/bloc/places/places_cubit.dart';
import 'package:workout_places_app/bloc/single_place/single_place_cubit.dart';
import 'package:workout_places_app/domain/models/place/review/review_data.dart';
import 'package:workout_places_app/domain/models/user/user.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/structure/review_edit_status.dart';

class EditReviewBloc extends Bloc<EditReviewEvent, EditReviewState> {
  final ReviewsRepository reviewsRepository;
  final SinglePlaceCubit singlePlaceCubit;
  final PlacesCubit placesCubit;

  EditReviewBloc({
    required this.reviewsRepository,
    required this.singlePlaceCubit,
    required this.placesCubit
    // TODO: Replace this id
  }) : super(EditReviewState.initial(User.empty().id)) {
    on<InitializeReviewEvent>(_onInit);
    on<ChangeStarsReviewEvent>(_onChangeStars);
    on<PublishReviewEvent>(_onPublish);
  }

  _onInit(InitializeReviewEvent event, Emitter<EditReviewState> emit) {
    emit(EditReviewState.initial(User.empty().id));
    reviewsRepository
        .getUserReview(state.userId, event.short.id)
        .then((review) {
      if (review == null) {
        emit(state.copyWith(
          short: event.short,
          loadingState: ReviewLoadingState.success,
        ));
      } else {
        emit(state.copyWith(
          short: event.short,
          loadingState: ReviewLoadingState.success,
          selectedStars: review.stars,
          text: review.text,
        ));
      }
    });
  }

  _onChangeStars(ChangeStarsReviewEvent event, Emitter<EditReviewState> emit) {
    emit(state.copyWith(
      text: event.currentText,
      selectedStars: event.newStars,
    ));
  }

  _onPublish(PublishReviewEvent event, Emitter<EditReviewState> emit) {
    // TODO: Emit sending
    final newText = event.newText;
    if (newText.length < 30) {
      emit(state.copyWith(
        text: newText,
        sendStatus: SendStatus.smallText,
      ));
      return;
    }
    if (newText.length > 1024) {
      emit(state.copyWith(
        text: newText,
        sendStatus: SendStatus.bigText,
      ));
      return;
    }

    reviewsRepository
        .editUserReview(
            state.userId,
            ReviewData(
              placeId: state.short!.id,
              stars: event.newStars,
              text: newText,
            ))
        .then((responseStatus) {
      switch (responseStatus) {
        case ReviewEditStatus.success:
          emit(state.copyWith(
            text: newText,
            selectedStars: event.newStars,
            sendStatus: SendStatus.sent,
          ));
          singlePlaceCubit.updateReviews();
          placesCubit.updateRating(state.short!.id);
          return;
        case ReviewEditStatus.noAccess:
          emit(state.copyWith(
            text: newText,
            selectedStars: event.newStars,
            sendStatus: SendStatus.noAccess,
          ));
          return;
        case ReviewEditStatus.failed:
          emit(state.copyWith(
            text: newText,
            selectedStars: event.newStars,
            sendStatus: SendStatus.serverError,
          ));
          return;
      }
    });
  }
}
