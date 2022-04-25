import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/workout_list/workout_list_event.dart';
import 'package:workout_places_app/bloc/workout_list/workout_list_state.dart';

class WorkoutListBloc extends Bloc<WorkoutListEvent, WorkoutListState> {
  WorkoutListBloc(WorkoutListState initialState) : super(WorkoutListState(null)) {
    on<LoadMoreEvent>(_onLoadMore);
  }

  void _onLoadMore(LoadMoreEvent event, Emitter<WorkoutListState> emit) {
    // todo use repository here
  }
}