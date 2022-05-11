import 'package:workout_places_app/domain/models/place/short_place_info.dart';

enum ReviewLoadingState {
  loading,
  success,
}

enum SendStatus {
  none,
  smallText,
  bigText,
  // sending
  noAccess,
  serverError,
  sent,
}

class EditReviewState {
  final int userId;
  final ShortPlaceInfo? short;
  final ReviewLoadingState loadingState;
  final int? selectedStars;
  final String? text;
  final SendStatus sendStatus;

  EditReviewState({
    required this.userId,
    required this.short,
    required this.loadingState,
    this.selectedStars,
    this.text,
    this.sendStatus = SendStatus.none,
  });

  EditReviewState.initial(this.userId)
      : loadingState = ReviewLoadingState.loading,
        selectedStars = null,
        text = null,
        short = null,
        sendStatus = SendStatus.none;

  EditReviewState copyWith({
    ShortPlaceInfo? short,
    ReviewLoadingState? loadingState,
    int? selectedStars,
    String? text,
    SendStatus? sendStatus,
  }) {
    return EditReviewState(
      userId: userId,
      short: short ?? this.short,
      loadingState: loadingState ?? this.loadingState,
      selectedStars: selectedStars ?? this.selectedStars,
      text: text ?? this.text,
      sendStatus: sendStatus ?? this.sendStatus,
    );
  }
}
