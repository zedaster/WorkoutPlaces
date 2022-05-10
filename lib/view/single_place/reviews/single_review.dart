import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleReview extends StatelessWidget {
  final int stars;

  const SingleReview({
    required this.stars,
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
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/workout-man.webp"),
                    ))),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Дмитрий Иванов",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "07.04.2022",
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
              color: (i + 1 <= stars)
                  ? const Color(0xFFF1C40F)
                  : Theme.of(context).backgroundColor,
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        // Text
        const Text(
          "Отличная площадка! Тренеруюсь на ней постоянно. Жаль, что "
          "гантелей больше нет. Надеюсь, их скоро вернут.",
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
