abstract class WorkoutListEvent {
  const WorkoutListEvent();
}

class LoadMoreEvent extends WorkoutListEvent {
  const LoadMoreEvent() : super();
}