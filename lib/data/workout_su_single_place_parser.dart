import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:workout_places_app/domain/models/location/map_location.dart';
import 'package:workout_places_app/domain/models/place/full_place_info.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';

class WorkoutSuSinglePlaceParser implements SinglePlaceRepository {
  @override
  Future<FullPlaceInfo> getFullInfo(ShortPlaceInfo short) async {
    return await getFullInfoById(short.id);
  }

  @override
  Future<FullPlaceInfo> getFullInfoById(int id) async {
    var response =
        await http.Client().get(Uri.parse('https://workout.su/areas/$id'));

    if (response.statusCode == 404) {
      throw WrongPlaceIdException(id);
    } else if (response.statusCode != 200) {
      throw SinglePlaceNetworkException(id);
    }

    var document = parse(response.body);
    var fieldsContent = document
        .getElementsByClassName("field")
        .map((element) => element.text.trim())
        .toList();
    var size = _parseSize(fieldsContent[0]);
    var novelty = _parseNovelty(fieldsContent[1]);
    var addressParts = fieldsContent[2].split(', ');
    var cityName = addressParts[0];
    var locationName = addressParts[1];
    var allImages = _parseAllImages(document);

    var short = ShortPlaceInfo(
      id: id,
      size: size,
      novelty: novelty,
      mainImage: allImages[0],
      cityName: cityName,
      locationName: locationName,
      location: _parseLocation(document),
    );
    return FullPlaceInfo(short: short, allImages: allImages);
  }

  WorkoutSize _parseSize(String textSize) {
    switch (textSize.toLowerCase().replaceFirst("размер:", "")) {
      case "маленькая":
        return WorkoutSize.small;
      case "средняя":
        return WorkoutSize.medium;
      case "большая":
        return WorkoutSize.big;
    }
    throw ArgumentError("Size '$textSize' is not defined");
  }

  WorkoutNovelty _parseNovelty(String textNovelty) {
    switch (textNovelty.toLowerCase().replaceFirst("тип:", "")) {
      case "современная":
      case "хомуты":
        return WorkoutNovelty.modern;
      case "советская":
        return WorkoutNovelty.soviet;
    }
    throw ArgumentError("Workout novelty '$textNovelty' is not defined");
  }

  List<ImageProvider> _parseAllImages(Document document) {
    var localUrlRegex = RegExp("uploads.+");
    return document
        .getElementsByClassName("photo-list-fancybox")
        .map((elem) => elem.getElementsByTagName("img").first)
        .map((imgElem) => imgElem.attributes["src"]!)
        .map((localThumbUrl) =>
            localUrlRegex.firstMatch(localThumbUrl)!.group(0))
        .map((localUrl) => "https://workout.su/$localUrl")
        .map((url) => NetworkImage(url))
        .toList();
  }

  MapLocation _parseLocation(Document document) {
    final regex = RegExp(r'"lat":"([0-9]+\.[0-9]+)","lng":"([0-9]+\.[0-9]+)"');
    var mapScriptContents = document
        .getElementsByTagName("script")
        .where((element) => regex.hasMatch(element.text))
        .first
        .text;
    var match = regex.firstMatch(mapScriptContents)!;
    var lat = match.group(1)!;
    var lng = match.group(2)!;
    return MapLocation(double.parse(lat), double.parse(lng));
  }
}
