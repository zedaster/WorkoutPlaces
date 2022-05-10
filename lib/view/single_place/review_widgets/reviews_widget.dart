import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/review/review.dart';
import 'package:workout_places_app/domain/models/place/short_place_info.dart';
import 'package:workout_places_app/view/single_place/edit_review/edit_review_screen.dart';

import 'single_review.dart';

class ReviewsWidget extends StatelessWidget {
  final ShortPlaceInfo short;
  final List<Review> reviews;

  const ReviewsWidget({
    Key? key,
    required this.short,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Title
          const Text("Отзывы",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          const SizedBox(height: 20),

          // Write review button
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditReviewScreen(short: short))),
            child: Container(
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
          ),

          const SizedBox(height: 20),

          // User reviews
          if (reviews.isNotEmpty)
            Wrap(
              runSpacing: 20,
              children: reviews.map((review) {
                return SingleReview(review: review);
              }).toList(),
            )
          else
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Здесь пока нет отзывов. Вы можете быть первым!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ]));
  }
}
