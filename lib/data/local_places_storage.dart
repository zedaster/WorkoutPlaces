import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';

import '../domain/models/location/location_tree.dart';

class LocalPlacesStorage implements PlacesRepository {
  final SinglePlaceRepository singlePlaceRepository;

  late final LocationTree _locationTree;
  final Map<MapLocation, int> _locationIdMap = HashMap();
  final Completer _initCompleter = Completer();

  LocalPlacesStorage(this.singlePlaceRepository) {
    rootBundle.loadString("assets/json/places.json").then((content) {
      var json = jsonDecode(content);
      var locations = <MapLocation>[];
      for (var placeJson in json["places"]) {
        var id = placeJson["id"] as int;
        var lat = double.parse(placeJson["lat"] as String);
        var lng = double.parse(placeJson["lng"] as String);
        var location = MapLocation(lat, lng);
        _locationIdMap[location] = id;
        locations.add(MapLocation(lat, lng));
      }

      _locationTree = LocationTree(locations);
      _initCompleter.complete();
    });
  }

  @override
  Future<List<ShortPlaceInfo>> getAllPlaces(int skip, int count) async {
    await _initCompleter.future;
    var tasks = _locationIdMap.values
        .skip(skip)
        .take(count)
        .map((id) => singlePlaceRepository.getFullInfoById(id));
    return (await Future.wait(tasks)).toList();
  }

  @override
  Future<List<ShortPlaceInfo>> getMapPlaces(
      MapLocation topLeft, MapLocation bottomRight) async {
    await _initCompleter.future;
    var tasks = _locationIdMap.entries
        .where((pair) => topLeft.latitude < pair.key.latitude)
        .where((pair) => pair.key.latitude < bottomRight.latitude)
        .where((pair) => topLeft.longitude < pair.key.longitude)
        .where((pair) => pair.key.longitude < bottomRight.longitude)
        .map((pair) => pair.value)
        .map((id) => singlePlaceRepository.getFullInfoById(id));
    return (await Future.wait(tasks)).toList();
  }

  @override
  Future<List<ShortPlaceInfo>> getNearPlaces(
      int skip, int count, MapLocation location) async {
    // TODO: Make our KD-Tree algorithm
    await _initCompleter.future;
    var nearest = await _locationTree.getNearest(location, skip + count);
    print(nearest.map((pair) => "${pair.value}").toList());
    var tasks = nearest
        .skip(skip)
        .take(count)
        .map((pair) => pair.key)
        .map((location) => _locationIdMap[location]!)
        .map((id) => singlePlaceRepository.getFullInfoById(id));
    return (await Future.wait(tasks)).toList();
  }
}
