import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/workout_novelty.dart';
import 'package:workout_places_app/domain/models/place/workout_size.dart';
import 'package:workout_places_app/view/widgets/list/place_info_widget.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://workout.su/uploads/userfiles/2017/08/2017-08-29-20-08-14-4mm.jpg";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          PlaceInfoWidget(
            height: 180,
            locationName: "Юлиса Фурчика",
            cityName: "Екатеринбург",
            image: NetworkImage(imageUrl),
            size: WorkoutSize.medium,
            novelty: WorkoutNovelty.modern,
            distance: 300,
            rating: 5.0,
          ),
        ],
      ),
    );
  }
}
