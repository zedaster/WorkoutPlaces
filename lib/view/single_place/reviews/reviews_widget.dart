import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_places_app/view/single_place/reviews/single_review.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Отзывы",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          const SizedBox(height: 20),

          // Write review button
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                  child: Text(
                "Написать отзыв",
                style: TextStyle(
                  color: Color(0xFF27AE60),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ))),

          const SizedBox(height: 20),
          // User reviews
          Wrap(
            runSpacing: 20,
            children: Iterable.generate(2).map((i) {
              return const SingleReview(stars: 4);
            }).toList(),
          ),
        ]));
  }
}
