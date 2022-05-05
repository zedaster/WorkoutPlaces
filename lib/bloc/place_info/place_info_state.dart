abstract class PlaceInfoState {
  final int placeId;

  PlaceInfoState({required this.placeId});
}

class PlaceInfoLoadingState extends PlaceInfoState {
  PlaceInfoLoadingState({required int placeId}) : super(placeId: placeId);
}