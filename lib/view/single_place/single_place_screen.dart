import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/single_place/single_place_cubit.dart';
import 'package:workout_places_app/bloc/single_place/single_place_state.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';
import 'package:workout_places_app/view/single_place/photo_slider/photo_slider.dart';

class SinglePlaceScreen extends StatelessWidget {
  final ShortPlaceInfo place;

  const SinglePlaceScreen({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SinglePlaceCubit(context.read<SinglePlaceRepository>())
            ..initialize(place),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SinglePlaceCubit, SinglePlaceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (!state.isLoaded) {
              return const Text('Loading...');
            }
            var place = state.place!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PhotoSlider(images: place.images)
              ],
            );
          },
          // child: const Center(
          //   child: Text('Place Info Screen'),
          // ),
        ),
      ),
    );
  }
}
