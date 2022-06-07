import 'package:test/test.dart';
import 'package:workout_places_app/data/workout_su_single_place_parser.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';

void main() {
  group('WorkoutSuTests', () {
    late WorkoutSuSinglePlaceParser parser;

    setUp(() {
      parser = WorkoutSuSinglePlaceParser();
    });

    test("Should parse single place with id 9659", () async {
      // https://workout.su/areas/9659
      var fullPlaceInfo = await parser.getFullInfoById(9659);
      expect(fullPlaceInfo.id, 9659);
      expect(fullPlaceInfo.size, WorkoutSize.big);
      expect(fullPlaceInfo.novelty, WorkoutNovelty.modern);
      expect(fullPlaceInfo.cityName, "Екатеринбург");
      expect(fullPlaceInfo.locationName, "Проспект Ленина 85");
      expect(fullPlaceInfo.location.latitude, 56.843124);
      expect(fullPlaceInfo.location.longitude, 60.633194);
      expect(fullPlaceInfo.images.length, 12);
    });
  });
}