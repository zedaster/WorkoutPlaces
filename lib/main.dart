import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/edit_review/edit_review_bloc.dart';
import 'package:workout_places_app/bloc/favorites/favorites_cubit.dart';
import 'package:workout_places_app/bloc/places/places_cubit.dart';
import 'package:workout_places_app/data/fake_reviews_storage.dart';
import 'package:workout_places_app/data/geolocator_adapter.dart';
import 'package:workout_places_app/data/local_places_storage.dart';
import 'package:workout_places_app/data/temp_favorites_storage.dart';
import 'package:workout_places_app/data/workout_su_single_place_parser.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/domain/repository/reviews_repository.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';
import 'package:workout_places_app/view/workout_app_scaffold.dart';

import 'bloc/single_place/single_place_cubit.dart';
import 'domain/repository/favorites_repository.dart';
import 'domain/repository/user_location_repository.dart';

// TODO: Create run mode
void main() {
  HttpOverrides.global = IgnoreCertificateHttpOverrides();
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call this function when Firebase is needed
    // _initFirebase();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SinglePlaceRepository>(
            create: (context) => WorkoutSuSinglePlaceParser()),
        RepositoryProvider<PlacesRepository>(
            create: (context) => LocalPlacesStorage(
                  context.read<SinglePlaceRepository>(),
                )),
        RepositoryProvider<ReviewsRepository>(
            create: (context) => FakeReviewsStorage()),
        RepositoryProvider<UserLocationRepository>(
            create: (context) => GeolocatorAdapter()),
        RepositoryProvider<FavoritesRepository>(
            create: (context) => TempFavoritesStorage()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => FavoritesCubit(
                    context.read<FavoritesRepository>(),
                    context.read<ReviewsRepository>(),
                    context.read<UserLocationRepository>(),
                  )),
          BlocProvider(
              create: (context) => SinglePlaceCubit(
                    context.read<SinglePlaceRepository>(),
                    context.read<ReviewsRepository>(),
                  )),
          BlocProvider(
              create: (context) => PlacesCubit(
                    context.read<PlacesRepository>(),
                    context.read<ReviewsRepository>(),
                    context.read<UserLocationRepository>(),
                    context.read<FavoritesRepository>(),
                  )),
          BlocProvider(
              create: (context) => EditReviewBloc(
                    reviewsRepository: context.read<ReviewsRepository>(),
                  )),
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
      ),
    );
  }

  void _initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class IgnoreCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}
