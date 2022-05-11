import 'package:intl/intl.dart';
import 'package:workout_places_app/domain/models/place/review/review_data.dart';
import 'package:workout_places_app/domain/models/user/user.dart';

class Review {
  final User user;
  final DateTime date;
  final int stars;
  final String text;

  Review({
    required this.user,
    required this.date,
    required this.stars,
    required this.text,
  });

  String get stringDate {
    final dateFormatter = DateFormat("dd.MM.yyyy");
    return dateFormatter.format(date);
  }

  Review copyWith({int? stars, String? text}) {
    return Review(
      user: user,
      date: date,
      stars: stars ?? this.stars,
      text: text ?? this.text,
    );
  }

  Review copyWithData(ReviewData data) {
    return Review(
      user: user,
      date: date,
      stars: data.stars,
      text: data.text,
    );
  }
}
