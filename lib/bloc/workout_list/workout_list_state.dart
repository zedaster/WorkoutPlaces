import 'package:workout_places_app/domain/models/place/workout_place.dart';

class WorkoutListState {
  final List<WorkoutPlace>? places;
  final bool isLoaded;

  WorkoutListState(this.places) : isLoaded = true;

  WorkoutListState.initialState()
      : places = null,
        isLoaded = false;
}
