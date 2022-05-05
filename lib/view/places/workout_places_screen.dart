
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/places/places_cubit.dart';
import 'package:workout_places_app/bloc/places/places_state.dart';
import 'package:workout_places_app/domain/repository/places_repository.dart';
import 'package:workout_places_app/view/single_place/single_place_screen.dart';

import 'widgets/place_info_widget.dart';
import 'widgets/places_change_mode_button.dart';
import 'widgets/places_mode.dart';

class WorkoutPlacesScreen extends StatelessWidget {
  const WorkoutPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocProvider(
          create: (context) =>
              PlacesCubit(context.read<PlacesRepository>())..getMorePlaces(),
          child: BlocConsumer<PlacesCubit, PlacesState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == PlacesStatus.initial ||
                  state.status == PlacesStatus.loading) {
                return const Center(child: Text("Loading..."));
                // TODO: Add loading animation
              }
              // TODO: Show loading status and remove loading condition above
              return ListView.separated(
                padding: const EdgeInsets.only(
                    bottom: 80, top: 10, left: 10, right: 10),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.places!.length,
                itemBuilder: (ctx, i) => PlaceInfoWidget(
                  height: 130,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SinglePlaceScreen(placeId: state.places![i].id)));
                  },
                  locationName: state.places![i].locationName,
                  cityName: state.places![i].cityName,
                  image: state.places![i].mainImage,
                  size: state.places![i].size,
                  novelty: state.places![i].novelty,
                  rating: state.places![i].averageRating,
                  distance: state.places![i].distance.round(),
                ),
              );
            },
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: PlacesChangeModeButton(modeToChange: PlacesMode.MAP),
          ),
        )
      ],
    );
  }
}
