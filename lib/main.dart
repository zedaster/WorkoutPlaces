import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/data/fake_single_place_storage.dart';
import 'package:workout_places_app/data/fake_places_storage.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/view/workout_app_scaffold.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlacesRepository>(
            create: (context) => FakePlacesStorage()),
        RepositoryProvider<SinglePlaceRepository>(
            create: (context) => FakeSinglePlaceStorage()),
      ],
      child: MaterialApp(
        title: 'Workout Places',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          backgroundColor: const Color(0xFFE5E5E5),
          primaryColor: const Color(0xFF00EB00),
        ),
        home: const WorkoutScaffold(),
      ),
    );
  }
}
