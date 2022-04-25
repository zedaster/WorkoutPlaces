import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/location/city.dart';

class User {
  final String nickname;

  String _showingName;
  ImageProvider _avatar;
  City _city;

  User(
      {required this.nickname,
      required String showingName,
      required ImageProvider avatar,
      required City city})
      : _showingName = showingName,
        _avatar = avatar,
        _city = city;

  String get showingName => _showingName;

  ImageProvider get avatar => _avatar;

  City get city => _city;

// todo methods to change user`s data
}
