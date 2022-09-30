import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_places_app/bloc/favorites/favorites_cubit.dart';
import 'package:workout_places_app/bloc/favorites/favorites_state.dart';
import 'package:workout_places_app/view/navigator_screen.dart';
import 'package:workout_places_app/view/places/widgets/place_info_widget.dart';
import 'package:workout_places_app/view/single_place/single_place_screen.dart';

class FavoritesScreen extends StatelessWidget implements NavigatorScreen {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => "Избранное";

  @override
  Widget get asWidget => this;

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().initialize();
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == FavoritesStatus.initializing) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
          // TODO: Add loading animation
        } else if (state.places!.isEmpty) {
          return const Center(child: Text("У вас пока нет избранных площадок"));
        }
        // TODO: Show loading status and remove loading condition above
        return ListView.separated(
          padding:
              const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
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
            onFavoriteTap: (bool newStatus) {
              if (!newStatus) {
                context.read<FavoritesCubit>().removePlace(state.places![i]);
              }
            },
          ),
        );
      },
    );
  }
}
