import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureContainer extends StatelessWidget {
  final List<Widget> children;
  final double innerHeight;

  const FeatureContainer({
    required this.children,
    required this.innerHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: SizedBox(
        height: innerHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) => children[i],
          separatorBuilder: (context, i) => const SizedBox(width: 20),
          itemCount: children.length,
        ),
      ),
    );
  }
}
