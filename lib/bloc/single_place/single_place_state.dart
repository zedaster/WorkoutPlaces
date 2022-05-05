abstract class SinglePlaceState {
  final int placeId;

  SinglePlaceState({required this.placeId});
}

class PlaceInfoLoadingState extends SinglePlaceState {
  PlaceInfoLoadingState({required int placeId}) : super(placeId: placeId);
}