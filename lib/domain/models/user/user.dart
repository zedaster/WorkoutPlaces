import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/location/city.dart';

class User {
  final String nickname;
  final bool isEmpty;
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
        _city = city,
        isEmpty = false;

  User.empty()
      : nickname = "unknown",
        _showingName = "Неизветсный пользователь",
        _avatar = const NetworkImage(
            "https://i1.sndcdn.com/artworks-000189080723-ez2uad-t500x500.jpg"),
        _city = City.unknown(),
        isEmpty = true;

  String get showingName => _showingName;

  ImageProvider get avatar => _avatar;

  City get city => _city;

// todo methods to change user`s data
}
