import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workout_places_app/bloc/single_place/single_place_cubit.dart';
import 'package:workout_places_app/bloc/single_place/single_place_state.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/view/single_place/feature_container.dart';
import 'package:workout_places_app/view/single_place/map_screen.dart';
import 'package:workout_places_app/view/single_place/photo_slider/slider_dot_indicator_wrapper.dart';
import 'package:workout_places_app/view/single_place/rating_box.dart';
import 'package:workout_places_app/view/single_place/review_widgets/reviews_widget.dart';

import 'photo_slider/photo_slider.dart';

class SinglePlaceScreen extends StatelessWidget {
  final ShortPlaceInfo place;

  const SinglePlaceScreen({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SinglePlaceCubit>().initialize(place);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.locationName),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<SinglePlaceCubit, SinglePlaceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (!state.isInfoLoaded) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF27AE60),));
          }
          var place = state.place!;
          return ListView(
            children: [
              SliderDotIndicatorWrapper(
                slider: PhotoSlider(
                  images: place.allImages,
                  height: 300,
                ),
              ),
              const SizedBox(height: 10),
              FeatureContainer(innerHeight: 30, children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/soviet-novelty.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Советская",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/size-icon.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Маленькая",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                )
              ]),
              const SizedBox(height: 10),
              FeatureContainer(children: [
                Row(
                  children: [
                    RatingBox(rating: state.averageRating ?? 0.0),
                    SizedBox(width: 10),
                    Text("Рейтинг",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ],
                )
              ], innerHeight: 30),
              const SizedBox(height: 10),
              // TODO: Create gesture detector and map page
              // TODO: Create material animation
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(location: place.location),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                        height: 200,
                        child: GoogleMap(
                          compassEnabled: false,
                          mapToolbarEnabled: false,
                          rotateGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
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
                        )),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF27AE60),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Развернуть карту",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              if (!state.isReviewsLoaded)
                const Text('Загрузка...')
              else
                ReviewsWidget(
                  short: place,
                  reviews: state.reviews!,
                )
            ],
          );
        },
        // child: const Center(
        //   child: Text('Place Info Screen'),
        // ),
      ),
    );
  }
}
