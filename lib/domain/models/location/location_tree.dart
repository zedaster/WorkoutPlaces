import 'package:workout_places_app/domain/models/location/map_location.dart';

class LocationTree {
  final List<MapLocation> locations;

  LocationTree(Iterable<MapLocation> locations)
      : locations = locations.toList();

  Future<Iterable<MapEntry<MapLocation, double>>> getNearest(
      MapLocation givenLoc, int count) async {
    var futureMapEntries =
        locations.map((loc) => _getFutureLocDistPair(givenLoc, loc));
    var mapEntries = await Future.wait(futureMapEntries);
    mapEntries.sort((a, b) => a.value.compareTo(b.value));
    return mapEntries;
  }

  Future<MapEntry<MapLocation, double>> _getFutureLocDistPair(
      MapLocation givenLoc, MapLocation objectLoc) async {
    var distance = givenLoc.distanceTo(objectLoc);
    return MapEntry(objectLoc, distance);
  }
}
