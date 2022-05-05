abstract class PlaceInfoEvent {
  final int placeId;

  PlaceInfoEvent({required this.placeId});
}

class PlaceInfoLoadEvent extends PlaceInfoEvent {
  PlaceInfoLoadEvent({required int placeId}) : super(placeId: placeId);
}
