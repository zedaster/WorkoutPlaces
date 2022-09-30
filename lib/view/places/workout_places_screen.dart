import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/places/places_cubit.dart';
import 'package:workout_places_app/bloc/places/places_state.dart';
import 'package:workout_places_app/view/navigator_screen.dart';
import 'package:workout_places_app/view/single_place/single_place_screen.dart';

import 'widgets/place_info_widget.dart';

class WorkoutPlacesScreen extends StatelessWidget implements NavigatorScreen {
  WorkoutPlacesScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => "Площадки";

  @override
  Widget get asWidget => this;

  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<PlacesCubit>(context).getMorePlaces();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().initialize();
    _setupScrollController(context);

    return Stack(
      children: [
        BlocConsumer<PlacesCubit, PlacesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == PlacesStatus.initializing) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (state.status == PlacesStatus.loading) {
              return Stack(
                children: [
                  _placesList(context, state),
                  Align(
                    child: LinearProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.bottomCenter,
                  )
                ],
              );
            } else {
              return _placesList(context, state);
            }
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

  Widget _placesList(BuildContext context, PlacesState state) {
    return ListView.separated(
      key: const PageStorageKey(0),
      // To save position on pushing extra places
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.places!.length,
      itemBuilder: (ctx, i) => PlaceInfoWidget(
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
          context
              .read<PlacesCubit>()
              .onFavoriteStatusChanged(state.places![i].id, newStatus);
        },
      ),
    );
  }
}
