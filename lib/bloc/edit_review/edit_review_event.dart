import 'package:workout_places_app/domain/models/place/short_place_info.dart';

abstract class EditReviewEvent {}

class InitializeReviewEvent extends EditReviewEvent {
  final ShortPlaceInfo short;

  InitializeReviewEvent(this.short);
}

class ChangeStarsReviewEvent extends EditReviewEvent {
  final String currentText;
  final int newStars;

  ChangeStarsReviewEvent({
    required this.currentText,
    required this.newStars,
  }) {
    assert (newStars >= 1 && newStars <= 5);
  }
}

class PublishReviewEvent extends EditReviewEvent {
  final int newStars;
  final String newText;

  PublishReviewEvent({
    required this.newStars,
    required this.newText,
  }) {
    assert (newStars >= 1 && newStars <= 5);
  }
}
