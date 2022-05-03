import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';
import 'package:workout_places_app/view/widgets/places/places_mode.dart';
import 'package:workout_places_app/view/widgets/places/places_change_mode_button.dart';
import 'package:workout_places_app/view/widgets/places/place_info_widget.dart';

class WorkoutPlacesScreen extends StatelessWidget {
  const WorkoutPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          padding:
              const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, i) => PlaceInfoWidget(
            height: 130,
            locationName: "Юлиса Фурчика",
            cityName: "Екатеринбург",
            image: Image.asset("assets/images/workout-place.jpg").image,
            size: WorkoutSize.medium,
            novelty: WorkoutNovelty.modern,
            //distance: 300,
            rating: 5.0,
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
