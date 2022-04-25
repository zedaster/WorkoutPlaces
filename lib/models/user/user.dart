import 'package:flutter/material.dart';

class User {
  final String nickname;

  String _showingName;
  ImageProvider _avatar;

  User(
      {required this.nickname,
      required String showingName,
      required ImageProvider avatar})
      : _showingName = showingName,
        _avatar = avatar;

  String get showingName => _showingName;

  ImageProvider get avatar => _avatar;

// todo methods to change user`s data
}
