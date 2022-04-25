import 'package:workout_places_app/domain/models/user/user.dart';

class Rating {
  final User user;

  int _value;

  Rating({
    required this.user,
    required int value,
  }) : _value = value;

  int get value => _value;

// todo create method to change rating value
}
