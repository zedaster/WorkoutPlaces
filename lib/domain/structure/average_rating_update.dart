class AverageRatingUpdate {
  int placeId;
  double? oldRating;
  double? newRating;

  AverageRatingUpdate({
    required this.placeId,
    this.oldRating,
    this.newRating,
  });
}
