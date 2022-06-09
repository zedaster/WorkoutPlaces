import 'package:test/test.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';

void main() {
  group('Map Location Tests', () {
    test("Get distance between two points", () {
      var loc1 = MapLocation(56.832865, 60.525877);
      var loc2 = MapLocation(56.835598, 60.552423);
      expect(loc1.distanceTo(loc2).toStringAsFixed(2), "1643.16");
    });
  });
}