import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_places_app/domain/models/place/review/review.dart';

class SingleReview extends StatelessWidget {
  final Review review;

  const SingleReview({
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User header
        Row(
          children: [
            Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: review.user.avatar,
                    ))),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  review.user.showingName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  review.stringDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Stars
        Wrap(
          children: Iterable.generate(5).map((i) {
            return Icon(
              Icons.star_rate,
              size: 24,
              color: (i + 1 <= review.stars)
                  ? const Color(0xFFF1C40F)
                  : Theme.of(context).backgroundColor,
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        // Text
        Text(
          review.text,
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
