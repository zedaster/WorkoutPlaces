import 'map_location.dart';

class City {
  final String name;
  final MapLocation location;
  final bool isUnknown;

  City(this.name, this.location): isUnknown = false;

  City.unknown() :
        name = "Неизвестен",
        location = MapLocation(0, 0),
        isUnknown = true;
}