import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workout_places_app/bloc/single_place/single_place_cubit.dart';
import 'package:workout_places_app/bloc/single_place/single_place_state.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/domain/repository/single_place_repository.dart';
import 'package:workout_places_app/view/single_place/photo_slider/slider_dot_indicator_wrapper.dart';

import 'photo_slider/photo_slider.dart';

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
        appBar: AppBar(
          title: Text(place.locationName),
        ),
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
                SliderDotIndicatorWrapper(
                  slider: PhotoSlider(
                    images: place.images,
                    height: 300,
                  ),
                ),
                SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: place.location.toGoogleLatLng(),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId("workout"),
                          position: place.location.toGoogleLatLng(),
                        )
                      },
                    ))
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
