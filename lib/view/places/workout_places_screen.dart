import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/places/places_cubit.dart';
import 'package:workout_places_app/bloc/places/places_state.dart';
import 'package:workout_places_app/view/navigator_screen.dart';
import 'package:workout_places_app/view/single_place/single_place_screen.dart';

import 'widgets/place_info_widget.dart';

class WorkoutPlacesScreen extends StatelessWidget implements NavigatorScreen {
  const WorkoutPlacesScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => "Площадки";

  @override
  Widget get asWidget => this;

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().initialize();
    return Stack(
      children: [
        BlocConsumer<PlacesCubit, PlacesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == PlacesStatus.initializing ||
                state.status == PlacesStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF27AE60),));
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
                              SinglePlaceScreen(place: state.places![i])));
                },
                locationName: state.places![i].locationName,
                cityName: state.places![i].cityName,
                image: state.places![i].mainImage,
                size: state.places![i].size,
                novelty: state.places![i].novelty,
                rating: state.places![i].rating,
                distance: state.places![i].distance?.round(),
                isFavorite: state.places![i].isFavorite,
                onFavoriteTap: (newStatus) {
                  context.read<PlacesCubit>().onFavoriteStatusChanged(state.places![i].id, newStatus);
                },
              ),
            );
          },
        ),
        // const Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: EdgeInsets.only(bottom: 20),
        //     child: PlacesChangeModeButton(modeToChange: PlacesMode.MAP),
        //   ),
        // )
      ],
    );
  }
}
