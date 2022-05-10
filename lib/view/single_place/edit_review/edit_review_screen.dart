import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';

class EditReviewScreen extends StatelessWidget {
  //final int placeId;
  final ShortPlaceInfo short;

  const EditReviewScreen({
    Key? key,
    required this.short,
    //required this.placeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ваш отзыв"),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            // Short Info
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 100,
              child: Row(
                children: [
                  Image(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    image: short.mainImage,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          short.locationName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(short.cityName,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Stars
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 100,
              child: Center(
                child: Wrap(
                    children: Iterable<int>.generate(5).map((i) {
                  return Icon(
                    Icons.star,
                    size: 50,
                    color: Theme.of(context).backgroundColor,
                  );
                }).toList()),
              ),
            ),

            const SizedBox(height: 10),

            // TextBox
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Введите отзыв (Необязательно)",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                  )
                ),
                minLines: 5,
                maxLines: 10,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Complete button
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF27AE60),
              ),
              height: 50,
              child: const Center(
                child: Text(
                  "Опубликовать",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
